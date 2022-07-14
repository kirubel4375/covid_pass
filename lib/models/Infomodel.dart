import 'package:cloud_firestore/cloud_firestore.dart';

class InfoModel {
  // ignore: non_constant_identifier_names
  final Timestamp? last_tested;
  final bool? testresult;


  InfoModel.fromJson(Map<String, dynamic>? json)
    :last_tested = json!["last_tested"],
    testresult = json["testresult"];


    // ignore: non_constant_identifier_names
    InfoModel({this.last_tested, this.testresult});
}