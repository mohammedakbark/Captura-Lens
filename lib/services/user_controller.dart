import 'package:captura_lens/model/add_post.dart';
import 'package:captura_lens/model/user_model.dart';
import 'package:captura_lens/user/user_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserController with ChangeNotifier {
  final auth = FirebaseAuth.instance;

  Future userSignup(email, password, context, UserModel userModel) async {
    auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((credential) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("registration successful..!")));
      _registerUserData(userModel, credential.user!.uid).then((value) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => UserHome()),
            (route) => false);
      });
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    });
  }

  Future signIn(email, password, context) async {
    auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((credential) {
      fetchCurrentUserData().then((value) => {
            if (value == true)
              {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => UserHome()),
                    (route) => false)
              }
            else
              {
                FirebaseAuth.instance.signOut().then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Sorry,the user not exist")));
                }),
              }
          });
    });
  }

  //---------------------- D A T A B A S E
  final db = FirebaseFirestore.instance;
  Future _registerUserData(UserModel usermodel, id) async {
    db.collection("User").doc(id).set(usermodel.tojson(id));
  }

  UserModel? currentUserData;
  Future<bool> fetchCurrentUserData() async {
    final snapShot = await db
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (snapShot.exists) {
      currentUserData = UserModel.fromJson(snapShot.data()!);
      return true;
    } else {
      return false;
    }
  }

  List<AddPost> allPost = [];
  Future fetchAllPost() async {
    final snapshot = await db.collection("Posts").get();
    allPost = snapshot.docs.map((e) {
      return AddPost.fromJson(e.data());
    }).toList();
  }

 Future<UserModel?> fetchSelectedPhotoGraphererData(uid) async {
    final snapshot = await db.collection("Photographers").doc(uid).get();
    if (snapshot.exists) {
      return UserModel.fromJson(snapshot.data()!);
    }
  }
}
