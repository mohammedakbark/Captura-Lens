import 'package:captura_lens/constants.dart';
import 'package:captura_lens/photographer/photo_event_payment.dart';
import 'package:captura_lens/photographer/photo_login_signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhotoEventRegistration extends StatefulWidget {
  const PhotoEventRegistration({super.key});

  @override
  State<PhotoEventRegistration> createState() =>
      _PhotoEventRegistrationState();
}

class _PhotoEventRegistrationState extends State<PhotoEventRegistration> {
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
                padding: EdgeInsets.symmetric(horizontal: 20, ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30,),
                        Text('Register Yourself', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        Text('Complete the form below to get start', style: TextStyle(color: Colors.white),)
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
                        prefixIcon: Icon(
                          Icons.perm_identity,
                          color: CustomColors.buttonGreen,
                        ),
                        hintText: 'Name',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.mail_outline,
                          color: CustomColors.buttonGreen,
                        ),
                        hintText: 'Email Address',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 20.0),
                  const TextField(
                    decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: CustomColors.buttonGreen,
                        ),
                        border: OutlineInputBorder()),
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone_android,
                          color: CustomColors.buttonGreen,
                        ),
                        hintText: 'Contact Number',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PhotoEventPayment()));
                      },
                      child: const Text('Register'),
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
