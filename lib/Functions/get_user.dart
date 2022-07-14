
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_pass/models/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
class GetUsers{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel> getUser()async{
    String? email = _auth.currentUser!.email;
    DocumentSnapshot<Map<String, dynamic>> doc = await _firestore.collection("users").doc(email).get();
    UserModel instance = UserModel.fromJson(doc.data());
    return instance;
  }
}

GetUsers getUsers = GetUsers();