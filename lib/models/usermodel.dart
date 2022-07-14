class UserModel {
  final String name;
  final String id;
  final String email;
  final String uid;

  UserModel.fromJson(Map<String, dynamic>? json)
    : name = json!["name"],
      id = json["id"],
      email = json["email"],
      uid = json["uid"];

  UserModel({
    required this.name,
    required this.email,
    required this.id,
    required this.uid,
  });
}
