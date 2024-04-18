import 'package:captura_lens/model/add_event_model.dart';
import 'package:captura_lens/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AdminController with ChangeNotifier {
  Future addAdminCompetition(AddEventModel addEventModel, String id) async {
    return await FirebaseFirestore.instance
        .collection("Competition")
        .doc(id)
        .set(addEventModel.toJson());
  }

  Future<Stream<QuerySnapshot>> getPhotographerDetails() async {
    return FirebaseFirestore.instance.collection("Photographers").snapshots();
  }

  Future<Stream<QuerySnapshot>> getCompetitionDetails() async {
    return FirebaseFirestore.instance.collection("Competition").snapshots();
  }

  List<UserModel> userList = [];
  Future<List<UserModel>> fetchAllUsers() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection("User").get();

  return  userList = snapshot.docs.map((e) {
      return UserModel.fromJson(e.data());
    }).toList();
  }
}
