import 'package:cloud_firestore/cloud_firestore.dart';

class DebugFirestoreService{

  static DebugFirestoreService instance=DebugFirestoreService();

  late FirebaseFirestore _db;

  DebugFirestoreService(){
    _db=FirebaseFirestore.instance;
  }

  void cloneService()async{
    var y=await _db.collection("organisations").doc("0EkeKMzWJ0Rt2HaJtoev").collection("services").doc("3KsWuBI6ESyvpUZvoFwc").collection("offerings").get();
    var x=y.docs[0].data();
    var n=await _db.collection("organisations").doc("0EkeKMzWJ0Rt2HaJtoev").collection("services").doc("3KsWuBI6ESyvpUZvoFwc").collection("offerings").doc().set(x);
  }

  void testPayService()async{

  }

}
