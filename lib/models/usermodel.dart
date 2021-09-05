import 'package:flutter/cupertino.dart';

class UserModel {
  @required
  String name;
  @required
  String email;

  @required
  String phone;
  @required
  String uid;
  String cover;
  String image;
  String bio;

  UserModel(
      {this.name,
      this.cover,
      this.image,
      this.email,
      this.uid,
      this.bio,
      this.phone});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    email = json["email"];

    phone = json["phone"];
    uid = json["uid"];
    cover = json["cover"];
    image = json["image"];
    bio = json["bio"];
  }
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "phone": phone,
      "image": image,
      "cover": cover,
      "bio": bio,
    };
  }
}
