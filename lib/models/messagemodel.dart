import 'package:cloud_firestore/cloud_firestore.dart';

class MessegModel {
  String text;
  Timestamp datetaime;
  String senderId;
  String receverId;

  MessegModel({this.datetaime, this.receverId, this.senderId, this.text});

  MessegModel.Fromjson(Map<String, dynamic> json) {
    text = json['text'];
    datetaime = json['dateataime'];
    senderId = json['senderId'];
    receverId = json['receverId'];
  }
  Map<String, dynamic> tojson() {
    return {
      'text': text,
      'dateataime': datetaime,
      'senderId': senderId,
      'receverId': receverId,
    };
  }
}
