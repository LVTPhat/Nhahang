import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String? content, name, avatar, id, title, tableId;
  Timestamp? time;
  DocumentReference? userRef;

  NotificationModel(
      {this.avatar,
      this.tableId,
      this.content,
      this.name,
      this.time,
      this.id,
      this.userRef,
      this.title});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    this.time = json['time'];
    this.name = json['name'];
    this.avatar = json['avatar'];
    this.content = json['content'];
    this.id = json['id'];
    this.userRef = json['from'];
    this.title = json['title'];
    this.tableId = json['tableid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['content'] = this.content;
    //  data['name'] = this.name;
    //  data['avatar'] = this.avatar;
    data['from'] = this.userRef;
    data['title'] = this.title;
    return data;
  }
}
