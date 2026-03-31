import 'package:cloud_firestore/cloud_firestore.dart';

class DishModel {
  String? name, urlOfImage, dishID, type;
  int? price, soldQuantity;
  DocumentReference? reference;

  DishModel(
      {this.name,
      this.urlOfImage,
      this.price,
      this.dishID,
      this.type,
      this.soldQuantity,
      this.reference});
  DishModel.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.urlOfImage = json['urlofimage'];
    this.price = json['price'];
    this.type = json['type'];
    this.dishID = json['dishid'];
    this.reference = json['reference'];
    this.soldQuantity = json['soldquantity'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['urlofimage'] = this.urlOfImage;
    data['price'] = this.price;
    data['type'] = this.type;
    return data;
  }
}
