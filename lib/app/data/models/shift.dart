import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sora_manager/app/data/models/workday.dart';

class ShiftModel {
  String? name, id;
  Timestamp? timeStart, timeEnd;
  List<WorkdayModel>? workdays;

  ShiftModel({this.name, this.id, this.timeEnd, this.timeStart, this.workdays});

  ShiftModel.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.id = json['id'];
    this.timeEnd = json['timeend'];
    this.timeStart = json['timestart'];
  }

  void setWorkday(List<WorkdayModel> list) {
    this.workdays = list;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['timeend'] = this.timeEnd;
    data['timestart'] = this.timeStart;
    return data;
  }
}
