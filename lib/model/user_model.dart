import 'dart:convert';

class UserModel {
  String? uid;
  String? name;
  String? email;
  UserModel({this.uid, this.name, this.email});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'uid': uid, 'name': name, 'email': email};
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
