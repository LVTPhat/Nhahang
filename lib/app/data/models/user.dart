import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? email, name, phone, uid, sex, address, avatar, id, position;
  Timestamp? dateOfBirth, dateOfEmployment;
  int? salary;
  DocumentReference? addressRef;
  DocumentReference? reference;

  UserModel(
      {this.uid,
      this.email,
      this.name,
      this.phone,
      this.id,
      this.sex,
      this.dateOfBirth,
      this.position,
      this.addressRef,
      this.reference,
      this.avatar,
      this.salary,
      this.dateOfEmployment});

  UserModel.fromJson(Map<String, dynamic> json) {
    this.email = json['email'];
    this.name = json['name'];
    this.phone = json['phone'];
    this.sex = json['sex'];
    this.address = json['address'];
    this.dateOfBirth = json['dateofbirth'];
    this.reference = json['reference'];
    this.dateOfEmployment = json['dateofemployment'];
    this.avatar = json['avatar'];
    this.id = json['id'];
    this.position = json['position'];
    this.salary = json['salary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['sex'] = this.sex;
    data['address'] = this.address;
    data['dateofbirth'] = this.dateOfBirth;
    data['dateofemployment'] = this.dateOfEmployment;
    data['avatar'] = this.avatar;
    data['position'] = this.position;
    data['salary'] = this.salary;
    return data;
  }
}
