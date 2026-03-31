import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sora_manager/app/data/models/user.dart';

class UserInfor {
  static String? email, name, phone, uid, sex, address, avatar;
  static Timestamp? dateOfBirth, dateOfEmployment;
  static DocumentReference? reference;
  UserInfor(UserModel user) {
    email = user.email;
    name = user.name;
    phone = user.phone;
    uid = user.uid;
    sex = user.sex;
    address = user.address;
    avatar = user.avatar;
    dateOfBirth = user.dateOfBirth;
    dateOfEmployment = user.dateOfEmployment;
    reference = user.reference;
  }
}
