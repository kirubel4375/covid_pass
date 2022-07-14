import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_pass/models/Infomodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetDocuments{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ignore: body_might_complete_normally_nullable
  Future<InfoModel?> getInfo()async{
    String? email = _auth.currentUser!.email;
    String? uid = _auth.currentUser!.uid;
    try{
      DocumentSnapshot<Map<String, dynamic>> doc = await _firestore.collection("users").doc(email).collection("info").doc(uid).get();

    if(doc.data()!.isNotEmpty){
      Map<String, dynamic>? mapValue = doc.data();
      InfoModel infoModel = InfoModel.fromJson(mapValue);
    return infoModel;
    }else if(doc.data()!.isEmpty){
      return InfoModel(last_tested: doc.data()!.entries.first.key as Timestamp, testresult: doc.data()!.entries.first.value);
    }
    }catch(_){
      return null;
    }
  }
}

GetDocuments getDocuments = GetDocuments();