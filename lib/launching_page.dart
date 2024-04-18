import 'package:captura_lens/admin/admin_login.dart';
import 'package:captura_lens/photographer/photo_login_signup.dart';
import 'package:captura_lens/user/user_login_signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class LaunchingPage extends StatefulWidget {
  const LaunchingPage({super.key});

  @override
  State<LaunchingPage> createState() => _LaunchingPageState();
}

class _LaunchingPageState extends State<LaunchingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: CupertinoColors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
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
                            builder: (context) => const PhotoLoginSignUp()));
                  },
                  child: const Text('Photographer'),
                ),
                TextButton(
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
                            builder: (context) => const UserLoginSignUp()));
                  },
                  child: const Text('User'),
                ),
                TextButton(
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
                            builder: (context) => const AdminLogin()));
                  },
                  child: const Text('Admin'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
