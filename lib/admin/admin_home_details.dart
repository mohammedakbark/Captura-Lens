import 'package:captura_lens/services/admin_controller.dart';
import 'package:captura_lens/services/database.dart';
import 'package:captura_lens/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminHomeDetails extends StatefulWidget {
  const AdminHomeDetails({super.key});

  @override
  State<AdminHomeDetails> createState() => _AdminHomeDetailsState();
}

class _AdminHomeDetailsState extends State<AdminHomeDetails> {
  Stream? competitionStream;

  getOnTheLoad() async {
    competitionStream = await AdminController().getCompetitionDetails();
    setState(() {});
  }

  @override
  void initState() {
    getOnTheLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final serchController = Provider.of<AdminController>(context);
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onTap: () async {
                      await serchController.fetchAllCompetitionForSearch();
                    },
                    onChanged: (value) {
                      print("hello");
                      print(value);
                      serchController.searchCompetition(value);
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: const Icon(CupertinoIcons.search),
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
                              builder: (context) => SplashScreen()),
                          (route) => false);
                    });
                  },
                ),
              ],
            ),
          ),
          serchController.searchResult.isNotEmpty
              // ? Text("data")
              ? Expanded(
                  child: Container(
                      color: Colors.white,
                      margin: EdgeInsets.all(10),
                      child: ListView.builder(
                          itemCount: serchController.searchResult.length,
                          itemBuilder: (context, index) {
                            final list = serchController.searchResult;
                            return Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          color: Colors.grey,
                                          width: size.width * .3,
                                          // height: size.height * .18,
                                          child: Image.network(
                                              list[index].imageURL),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          list[index].payment == false
                                              ? "Free"
                                              : "Paid",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color:
                                                  list[index].payment == false
                                                      ? Colors.green
                                                      : Colors.red),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            list[index].title,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            list[index].prizeAndDescription,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "Deadline : ${list[index].deadline}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "Place : ${list[index].place}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          })

                      // child: InkWell(
                      //     onTap: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => const PhotoEventDetails()));
                      //     },
                      //     child: allCompetitionDetails()),
                      ),
                )
              : Expanded(
                  child: Container(
                    color: Colors.white,
                    margin: EdgeInsets.all(10),
                    child: StreamBuilder(
                        stream: competitionStream,
                        builder: (context, AsyncSnapshot snapshot) {
                          return snapshot.hasData
                              ? snapshot.data.docs.isEmpty
                                  ? const Center(
                                      child: Text(
                                        "No Events",
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: snapshot.data.docs.length,
                                      itemBuilder: (context, index) {
                                        DocumentSnapshot ds =
                                            snapshot.data.docs[index];
                                        return Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Column(
                                                  children: [
                                                    Container(
                                                      color: Colors.grey,
                                                      width: size.width * .3,
                                                      // height: size.height * .18,
                                                      child: ds.exists
                                                          ? Image.network(
                                                              ds["imageURL"],
                                                            )
                                                          : const Center(
                                                              child: Text(
                                                                  "Photo")),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      ds["payment"] == false
                                                          ? "Free"
                                                          : "Paid",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              ds["payment"] ==
                                                                      false
                                                                  ? Colors.green
                                                                  : Colors.red),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 30,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        ds["title"],
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text(
                                                        ds["prizeAndDescription"],
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text(
                                                        "Deadline : ${ds["deadline"]}",
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text(
                                                        "Place : ${ds["place"]}",
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      })
                              : const Center(
                                  child: Text("Loading .."),
                                );
                        }),
                    // child: InkWell(
                    //     onTap: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => const PhotoEventDetails()));
                    //     },
                    //     child: allCompetitionDetails()),
                  ),
                )
        ],
      ),
    );
  }
}
