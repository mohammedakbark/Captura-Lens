import 'package:captura_lens/model/add_post.dart';
import 'package:captura_lens/model/new_photographer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class PhotographerController with ChangeNotifier {
  final db = FirebaseFirestore.instance;
//------------------ r e a d
  NewPhotographer? currentUserData;
  Future readPhotographerData() async {
    final snapshot = await db
        .collection("Photographers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (snapshot.exists) {
      currentUserData = NewPhotographer.fromJson(snapshot.data()!);
    }
  }

  List<AddPost> currentUserPosts = [];
  Future readCurrentPhotoGrapherrPhotoa() async {
    final snapshot = await db
        .collection("Posts")
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    currentUserPosts = snapshot.docs.map((e) {
      return AddPost.fromJson(e.data());
    }).toList();
  }

   Future<Stream<QuerySnapshot>> getCompetitionDetails()async{
    return  FirebaseFirestore.instance.collection("Competition").snapshots();
  }

//---------------------------------u p d a t e

//------------d e l e t e

//---------------------------------c r e a t e
  Future addPhotoDetails(NewPhotographer newPhotographer, String id) async {
    return await FirebaseFirestore.instance
        .collection("Photographers")
        .doc(id)
        .set(newPhotographer.tojson());
  }

  Future photoPost(AddPost addPost, String id) async {
    return await FirebaseFirestore.instance
        .collection("Posts")
        .doc(id)
        .set(addPost.toJson());
  }
}
