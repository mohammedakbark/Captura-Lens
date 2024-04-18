import 'dart:io';

import 'package:captura_lens/about_us.dart';
import 'package:captura_lens/forgot_password.dart';
import 'package:captura_lens/services/admin_controller.dart';
import 'package:captura_lens/services/photographer_controller.dart';
import 'package:captura_lens/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../complaints_page.dart';
import '../help_page.dart';
import '../services/database.dart';
import '../support_page.dart';

class PhotoProfile extends StatefulWidget {
  bool isPhoto;

  PhotoProfile({super.key, required this.isPhoto});

  @override
  State<PhotoProfile> createState() => _PhotoProfileState();
}

class _PhotoProfileState extends State<PhotoProfile> {
  // Stream? photoProfileStream;

  // getOnTheLoad() async {
  //   photoProfileStream = await AdminController().getPhotographerDetails();
  //   setState(() {});
  // }

  // @override
  // void initState() {
  //   getOnTheLoad();
  //   super.initState();
  // }

  final List<Widget> _pages = <Widget>[
    const AboutUs(),
    const ForgotPassword(),
    const SupportPage(),
    const HelpPage(),
    const ComplaintsPage(),
  ];
  final List<String> _pagesname = [
    "AboutUs",
    "ForgotPasswor",
    "SupportPag",
    "HelpPag",
    "ComplaintsPag",
    "Logout"
  ];
  File? selectedImage;
  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Consumer<PhotographerController>(
            builder: (context, controller, child) {
          return FutureBuilder(
              future: controller.readPhotographerData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                }
                final userData = controller.currentUserData;
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: Colors.white)),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              _pickImageFromGallery().then((value) async {
                                SettableMetadata metadata =
                                    SettableMetadata(contentType: 'image/jpeg');
                                final currenttime = TimeOfDay.now();
                                UploadTask uploadTask = FirebaseStorage.instance
                                    .ref()
                                    .child("shopTagImage/Shop$currenttime")
                                    .putFile(selectedImage!, metadata);
                                TaskSnapshot snapshot = await uploadTask;
                                await snapshot.ref.getDownloadURL().then((url) {
                                  FirebaseFirestore.instance
                                      .collection("Photographers")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .update({"profileUrl": url}).then(
                                          (value) => setState(() {}));
                                });
                              });
                            },
                            child: Container(
                              width: 90,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: userData!.profileUrl.isNotEmpty
                                      ? DecorationImage(
                                          fit: BoxFit.fill,
                                          image:
                                              NetworkImage(userData.profileUrl))
                                      : null),
                              child: userData.profileUrl.isEmpty
                                  ? const Center(child: Text("Photo"))
                                  : const SizedBox(),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userData.email,
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                userData.typePhotographer,
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    userData.place,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    userData.phoneNumber.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  )
                                ],
                              )
                            ],
                          ),
                          const Spacer(),
                          Expanded(
                            child: Column(
                              children: [
                                PopupMenuButton<int>(
                                  icon: const Icon(
                                    Icons.menu,
                                    color: Colors.white,
                                  ),
                                  onSelected: (int index) {
                                    if (index == 5) {
                                      FirebaseAuth.instance
                                          .signOut()
                                          .then((value) {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const SplashScreen()),
                                                (route) => false);
                                      });
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => _pages[
                                              index], // Use the selected index
                                        ),
                                      );
                                    }
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return List.generate(
                                      _pagesname.length,
                                      (index) => PopupMenuItem(
                                        value:
                                            index, // Set the value to the index
                                        child: Text(_pagesname[index]),
                                      ),
                                    ).toList();
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    FutureBuilder(
                        future: controller.readCurrentPhotoGrapherrPhotoa(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Expanded(child: SizedBox());
                          }
                          final postList = controller.currentUserPosts;
                          return postList.isEmpty
                              ? const Expanded(
                                  child: Center(
                                  child: Text("No Post"),
                                ))
                              : Expanded(
                                  child: GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                      ),
                                      itemCount: postList.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                      postList[index]
                                                          .imageUrl))),
                                        );
                                      }),
                                );
                        })
                  ],
                );
              });
        }),
      ),
    );
  }
}
