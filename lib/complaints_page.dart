import 'package:captura_lens/photographer/photo_profile.dart';
import 'package:captura_lens/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

import 'constants.dart';

class ComplaintsPage extends StatefulWidget {
  const ComplaintsPage({super.key});

  @override
  State<ComplaintsPage> createState() => _ComplaintsPageState();
}

class _ComplaintsPageState extends State<ComplaintsPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController complaintsController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: CupertinoColors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: CupertinoColors.black,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'We are very Sorry to have an issue with you',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 70,
                      ),
                      TextFormField(
                        controller: complaintsController,
                        decoration: const InputDecoration(
                          hintText: 'Type your Complaints',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          hintText: 'Enter Your Name',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: 'Phone Number',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          String id = randomAlphaNumeric(10);
                          Map<String, dynamic> complaintsInfoMap = {
                            "Complaint": complaintsController.text,
                            "Name": nameController.text,
                            "Phone": phoneController.text,
                            "id": id
                          };
                          await DataBaseMethods()
                              .complaintsDetails(complaintsInfoMap, id).then((value) {
                            Fluttertoast.showToast(
                                msg: "Complaint Registered",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> PhotoProfile(isPhoto: true)));
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColors.buttonGreen,
                            foregroundColor: Colors.white),
                        child: const Text("Submit"),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
