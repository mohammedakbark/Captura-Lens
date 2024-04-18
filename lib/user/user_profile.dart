import 'package:captura_lens/about_us.dart';
import 'package:captura_lens/change_password.dart';
import 'package:captura_lens/complaints_page.dart';
import 'package:captura_lens/help_page.dart';
import 'package:captura_lens/services/user_controller.dart';
import 'package:captura_lens/splash_screen.dart';
import 'package:captura_lens/support_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Consumer<UserController>(builder: (context, controller, child) {
            return Container(
                height: 250,
                color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FutureBuilder(
                        future: controller.fetchCurrentUserData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            );
                          }
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              controller.currentUserData!.profileUrl.isEmpty
                                  ? IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.image_sharp,
                                        size: 66,
                                        color: Colors.white,
                                      ))
                                  : CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 35,
                                      backgroundImage: NetworkImage(controller
                                          .currentUserData!.profileUrl),
                                    ),
                              Text(
                                controller.currentUserData!.email,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          );
                        }),
                  ],
                ));
          }),
          Container(
            color: Colors.black,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                        style:
                            TextButton.styleFrom(foregroundColor: Colors.white),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AboutUs()));
                        },
                        child: const Text("About Us")),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        style:
                            TextButton.styleFrom(foregroundColor: Colors.white),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SupportPage()));
                        },
                        child: const Text("Support")),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        style:
                            TextButton.styleFrom(foregroundColor: Colors.white),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HelpPage()));
                        },
                        child: const Text("Help")),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        style:
                            TextButton.styleFrom(foregroundColor: Colors.white),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ChangePassword()));
                        },
                        child: const Text("Change Password")),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        style:
                            TextButton.styleFrom(foregroundColor: Colors.white),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ComplaintsPage()));
                        },
                        child: const Text("Complains")),
                    ElevatedButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut().then((value) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const SplashScreen()),
                                (route) => false);
                          });
                        },
                        child: const Row(
                          children: [Icon(Icons.logout), Text("Log Out")],
                        ))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
