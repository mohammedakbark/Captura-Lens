import 'package:captura_lens/admin/admin_home.dart';
import 'package:captura_lens/launching_page.dart';
import 'package:captura_lens/photographer/photo_home.dart';
import 'package:captura_lens/photographer/photo_login_signup.dart';
import 'package:captura_lens/user/user_home.dart';
import 'package:captura_lens/utils/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 4)).then((value) async {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LaunchingPage()),
            (route) => false);
      } else {
        if (FirebaseAuth.instance.currentUser!.uid == adminuid) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const AdminHome()),
              (route) => false);
        } else {
          final snapshot = await FirebaseFirestore.instance
              .collection("User")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get();

          if (snapshot.exists) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const UserHome()),
                (route) => false);
//
          } else {
            final snapshot = await FirebaseFirestore.instance
                .collection("Photographers")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .get();
            if (snapshot.exists) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const PhotoHome()),
                  (route) => false);
            } else {
              FirebaseAuth.instance.signOut();
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Sorry,the user not exist")));
            }
          }
        }
      }
    });

    return const Scaffold(
      backgroundColor: Colors.black,
    );
  }
}
