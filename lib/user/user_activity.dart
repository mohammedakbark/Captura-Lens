import 'dart:ffi';
import 'dart:io';
import 'dart:ui';

import 'package:captura_lens/constants.dart';
import 'package:captura_lens/services/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class UserActivity extends StatefulWidget {
  const UserActivity({super.key});

  @override
  State<UserActivity> createState() => _UserActivityState();
}

class _UserActivityState extends State<UserActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
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
                    Icons.menu,
                    color: Colors.grey,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Consumer<UserController>(builder: (context, controller, child) {
              return Expanded(
                  child: FutureBuilder(
                      future: controller.fetchCurrentuserBookingEvents(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        }
                        final list = controller.mybookingList;
                        return list.isEmpty
                            ? Center(
                                child: Text(
                                  "No activities",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            : ListView.builder(
                                itemCount: list.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        border: Border.all(color: Colors.white),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: FutureBuilder(
                                        future: controller
                                            .fetchSelectedPhotoGraphererData(
                                                list[index].photographerId),
                                        builder: (context, snap) {
                                          if (snap.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                              child: Text(
                                                "Loading...",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            );
                                          }
                                          final pgData =
                                              controller.selectedpGData;
                                          return Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  pgData!.profileUrl.isEmpty
                                                      ? const CircleAvatar(
                                                          backgroundColor:
                                                              Colors.grey,
                                                          radius: 30,
                                                          child: Icon(
                                                            CupertinoIcons
                                                                .profile_circled,
                                                            size: 40,
                                                            color: Colors.black,
                                                          ),
                                                        )
                                                      : CircleAvatar(
                                                          backgroundColor:
                                                              Colors.grey,
                                                          radius: 30,
                                                          backgroundImage:
                                                              NetworkImage(pgData
                                                                  .profileUrl),
                                                        ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        pgData.email,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.phone,
                                                            color: Colors.white,
                                                          ),
                                                          Text(
                                                            pgData.phoneNumber
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        list[index]
                                                            .photographyType,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Text(
                                                            list[index].status ==
                                                                    "Requested"
                                                                ? list[index]
                                                                    .status
                                                                : "Booking ${list[index].status}",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                fontSize: 18,
                                                                color: colorPicker(
                                                                    list[index]
                                                                        .status)),
                                                          ),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          // list[index].status ==
                                                          //         "Accepted"
                                                          //     ? ElevatedButton(
                                                          //         onPressed:
                                                          //             () {},
                                                          //         style: ElevatedButton.styleFrom(
                                                          //             shape: RoundedRectangleBorder(
                                                          //                 borderRadius: BorderRadius.circular(
                                                          //                     10)),
                                                          //             foregroundColor:
                                                          //                 Colors
                                                          //                     .white,
                                                          //             backgroundColor:
                                                          //                 Colors
                                                          //                     .blue),
                                                          //         child:
                                                          //             const Text(
                                                          //           "Pay",
                                                          //           style: TextStyle(
                                                          //               color: Colors
                                                          //                   .black),
                                                          //         ),
                                                          //       )
                                                          //     : const SizedBox()
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          );
                                        }),
                                  );
                                });
                      }));
            })
          ],
        ),
      ),
    );
  }
}

colorPicker(status) {
  switch (status) {
    case "Requested":
      {
        return Colors.green;
      }
    case "Accepted":
      {
        return Colors.green;
      }
    case "Rejected":
      {
        return Colors.red;
      }
  }
}
