import 'dart:async';

import 'package:captura_lens/model/add_event_model.dart';
import 'package:captura_lens/model/new_photographer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DataBaseMethods {
  
  

 
  // Future<Stream<QuerySnapshot>> getPostDetails()async{
  //   return await FirebaseFirestore.instance.collection("Posts").snapshots();
  // }

  Future complaintsDetails(Map<String, dynamic> complaintsInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Complaints")
        .doc(id)
        .set(complaintsInfoMap);
  }
  Future<Stream<QuerySnapshot>> getComplaintsDetails()async{
    return await FirebaseFirestore.instance.collection("Complaints").snapshots();
  }


 
  
 

  Future<Stream<QuerySnapshot>> getBookingDetails()async{
    return  FirebaseFirestore.instance.collection("Bookings").snapshots();
  }

  Future rejectBooking(String id) async{
    return await FirebaseFirestore.instance.collection("Bookings").doc(id).delete();
  }


}