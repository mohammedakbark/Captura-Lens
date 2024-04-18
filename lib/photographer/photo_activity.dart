import 'package:captura_lens/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhotoActivity extends StatefulWidget {
  const PhotoActivity({super.key});

  @override
  State<PhotoActivity> createState() => _PhotoActivityState();
}

class _PhotoActivityState extends State<PhotoActivity> {
  Stream? bookingStream;

  getOnTheLoad() async {
    bookingStream = await DataBaseMethods().getBookingDetails();
    setState(() {});
  }

  @override
  void initState() {
    getOnTheLoad();
    super.initState();
  }

  Widget allBookingDetails() {
    return StreamBuilder(
        stream: bookingStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? snapshot.data.docs.isEmpty
                  ? const Center(
                      child: Text(
                        "Booking not found",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot ds = snapshot.data.docs[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          height: 200,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 30,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ds["Name"],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        ds["Phone Number"],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        ds["Details"],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        ds["Time Duration"],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 40),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        foregroundColor: Colors.black,
                                        backgroundColor: Colors.white),
                                    child: const Text(
                                      "Accept",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      await DataBaseMethods()
                                          .rejectBooking(ds["id"]);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 40),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        foregroundColor: Colors.black,
                                        backgroundColor: Colors.white),
                                    child: const Text(
                                      "Reject",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Booking",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ],
            ),
            Expanded(child: allBookingDetails())
          ],
        ),
      ),
    );
  }
}
