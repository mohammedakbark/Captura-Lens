import 'package:captura_lens/photographer/photo_event_details.dart';
import 'package:captura_lens/services/database.dart';
import 'package:captura_lens/services/photographer_controller.dart';
import 'package:captura_lens/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PhotoHomeDetails extends StatefulWidget {
  const PhotoHomeDetails({super.key});

  @override
  State<PhotoHomeDetails> createState() => _PhotoHomeDetailsState();
}

class _PhotoHomeDetailsState extends State<PhotoHomeDetails> {
  Stream? competitionStream;

  getOnTheLoad() async {
    competitionStream = await PhotographerController().getCompetitionDetails();
    setState(() {});
  }

  @override
  void initState() {
    getOnTheLoad();
    super.initState();
  }

  Widget allCompetitionDetails() {
    return StreamBuilder(
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
                        DocumentSnapshot ds = snapshot.data.docs[index];
                        return Container(
                          height: 130,
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
                                      width: 50,
                                      height: 70,
                                      child: ds.exists
                                          ? Image.network(
                                              ds["imageURL"],
                                            )
                                          : const Center(child: Text("Photo")),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Paid/Unpaid",
                                      style: TextStyle(fontSize: 8),
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
                                        ds["title"],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        ds["prizeAndDescription"],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        ds["deadline"],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        ds["place"],
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
              : const Center(
                  child: Text("No Events"),
                );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
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
          Expanded(
            child: Column(
              children: [
                Expanded(
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PhotoEventDetails()));
                        },
                        child: allCompetitionDetails())),
              ],
            ),
          )
        ],
      ),
    );
  }
}
