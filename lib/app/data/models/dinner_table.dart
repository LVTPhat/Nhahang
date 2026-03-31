import 'package:cloud_firestore/cloud_firestore.dart';

class DinnerTableModel {
  String? tableName, paymentStatus, tableStatus;
  int? guestNumber, capacity, totalPrice;
  String? tableID;
  DinnerTableModel(
      {this.capacity,
      this.guestNumber,
      this.paymentStatus,
      this.tableName,
      this.tableStatus,
      this.tableID,
      this.totalPrice});
  DinnerTableModel.fromJson(Map<String, dynamic> json) {
    this.capacity = json['capacity'];
    this.guestNumber = json['guestnumber'];
    this.paymentStatus = json['paymentstatus'];
    this.tableName = json['tablename'];
    this.tableStatus = json['tablestatus'];
    this.tableID = json['tableid'];
    this.totalPrice = json['totalprice'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['capacity'] = this.capacity;
    data['guestnumber'] = this.guestNumber;
    data['paymentstatus'] = this.paymentStatus;
    data['tablestatus'] = this.tableStatus;
    data['tablename'] = this.tableName;
    return data;
  }
}
