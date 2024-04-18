import 'package:captura_lens/services/user_controller.dart';
import 'package:captura_lens/splash_screen.dart';
import 'package:captura_lens/user/user_categories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class UserHomeDetails extends StatefulWidget {
  const UserHomeDetails({super.key});

  @override
  State<UserHomeDetails> createState() => _UserHomeDetailsState();
}

class _UserHomeDetailsState extends State<UserHomeDetails> {
  // SearchController _searchController = SearchController();
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(builder: (context, controller, child) {
      return Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        suffixIcon: const Icon(
                          Icons.search,
                          color: CupertinoColors.black,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Search",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  IconButton(
                    icon: const Icon(
                      Icons.power_settings_new_rounded,
                      color: Color.fromARGB(255, 229, 43, 30),
                    ),
                    onPressed: () {
                      FirebaseAuth.instance.signOut().then((value) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const SplashScreen()),
                            (route) => false);
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: 100,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const UserCategories()));
                          },
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey,
                            ),
                            child: const Center(
                                child: Text(
                              "Category",
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(
              child: Column(
                children: [
                  FutureBuilder(
                      future: controller.fetchAllPost(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          );
                        }
                        final postList = controller.allPost;
                        return Expanded(
                          child: ListView.builder(
                            itemCount: postList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  height: 300,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey)),
                                  child: Column(
                                    children: [
                                      FutureBuilder(
                                          future: controller
                                              .fetchSelectedPhotoGraphererData(
                                                  postList[index].uid),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const SizedBox();
                                            }
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                snapshot.data!.profileUrl
                                                        .isEmpty
                                                    ? const CircleAvatar(
                                                        radius: 10,
                                                        backgroundColor:
                                                            Colors.grey,
                                                        child: Icon(Icons
                                                            .supervised_user_circle_sharp),
                                                      )
                                                    : CircleAvatar(
                                                        radius: 10,
                                                        backgroundColor:
                                                            Colors.grey,
                                                        backgroundImage:
                                                            NetworkImage(snapshot
                                                                .data!
                                                                .profileUrl),
                                                      ),
                                                const SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  snapshot.data!.email,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            );
                                          }),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                      postList[index]
                                                          .imageUrl)),
                                              color: Colors.blueGrey,
                                              border: Border.all(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                  CupertinoIcons.heart_fill)),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                  CupertinoIcons.chat_bubble)),
                                          const Spacer(),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                  CupertinoIcons.bookmark))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}