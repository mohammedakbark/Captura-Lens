import 'package:captura_lens/model/register_competition_model.dart';
import 'package:captura_lens/photographer/photo_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants.dart';

class PhotoEventPayment extends StatefulWidget {
  RegisterCompetitionModel registerCompetitionModel;
  String regId;
  PhotoEventPayment(
      {super.key, required this.registerCompetitionModel, required this.regId});

  @override
  State<PhotoEventPayment> createState() => _PhotoEventPaymentState();
}

class _PhotoEventPaymentState extends State<PhotoEventPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
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
                          'Payment',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Make an advance payment',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const TextField(
                    decoration: InputDecoration(
                        hintText: 'Bank Account Number',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const TextField(
                    decoration: InputDecoration(
                        hintText: 'Re-enter Bank Account Number',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'IFSC code',
                        suffix: TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Search for IFSC",
                              style: TextStyle(color: Colors.blue),
                            )),
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const TextField(
                    decoration: InputDecoration(
                        hintText: 'Bank Account Holders Name',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 20.0),
                  const TextField(
                    decoration: InputDecoration(
                        hintText: 'Enter Your UPI ID',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 20.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          foregroundColor: Colors.white,
                          backgroundColor: CustomColors.buttonGreen),
                      onPressed: () {
                        Fluttertoast.showToast(
                          msg: 'Event Registered',
                          backgroundColor: Colors.grey,
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PhotoHome()));
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
