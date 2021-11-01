import 'package:cloud_firestore/cloud_firestore.dart';

class DebugFirestorService{

  DebugFirestorService instance=DebugFirestorService();

  late FirebaseFirestore _db;

  DebugFirestorService(){
    _db=FirebaseFirestore.instance;
  }

  void cloneService(){
    _db.collection("organisations").
  }

}