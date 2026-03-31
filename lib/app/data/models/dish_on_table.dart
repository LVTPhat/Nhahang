import 'package:cloud_firestore/cloud_firestore.dart';

class DishOnTableModel {
  String? name, urlOfImage, id, type, note, tableId, tableName;
  int? price, amount, done;
  Timestamp? timeAdd;
  DocumentReference? dishRef;
  DishOnTableModel(
      {this.name,
      this.timeAdd,
      this.dishRef,
      this.tableId,
      this.done,
      this.urlOfImage,
      this.price,
      this.id,
      this.type,
      this.tableName,
      this.amount,
      this.note});
  DishOnTableModel.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.urlOfImage = json['urlofimage'];
    this.price = json['price'];
    this.type = json['type'];
    this.id = json['id'];
    this.amount = json['amount'];
    this.note = json['note'];
    this.done = json['done'];
    this.tableId = json['tableid'];
    this.timeAdd = json['timeadd'];
    this.dishRef = json['dish'];
    this.tableName = json['tablename'];
  }
}
