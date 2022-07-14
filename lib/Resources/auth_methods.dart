import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> registerUser(
    {required String name, required String password, required String email, required String id })async{
      String res = " ";
      try{
        if(name.isNotEmpty && password.isNotEmpty && email.isNotEmpty && id.isNotEmpty){
          UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
          User? user = cred.user;
          await _firestore.collection("users").doc(email).set({
            "name": name,
            "email": email,
            "id": id,
            "uid": user!.uid,
          });
          res = user.uid;
        } 
      }catch(_){
        res = "error";
      }
      return res;
  }

  Future<void> createEmptyFile({required String email, required String uid})async{
    await _firestore.collection("users").doc(email).collection("info").doc(uid).set({
      "last_tested": null,
      "testresult": null,
    });
  }


   Future<String> loginUser(
    {required String password, required String email})async{
      String res = "some error occured";
      try{
        if(password.isNotEmpty && email.isNotEmpty){
          await _auth.signInWithEmailAndPassword(email: email, password: password);
          res = "successfully logedin";
        }
      }catch(e){
        res = e.toString();
      }
      return res;
  }

  Future<String> logoutUser()async{
      String res = "some error occured";
      try{
        if(_auth.currentUser!=null){
          _auth.signOut();
          res= "success";
        }
      }catch(e){
        res = e.toString();
      }
      return res;
  }
}