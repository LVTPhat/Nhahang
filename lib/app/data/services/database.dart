import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sora_manager/app/data/models/position.dart';
import 'package:sora_manager/app/data/models/user.dart';

class DatabaseMethods {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> getUserByUID(String uid) async {
    var snapshot = await _firestore.collection('users').doc(uid).get();
    if (snapshot.exists) {
      Map<String, dynamic> user = snapshot.data() as Map<String, dynamic>;
      user['reference'] = snapshot.reference;
      return UserModel.fromJson(user);
    }
    return UserModel();
  }

  Future<DocumentReference> getUserRefByUID(String uid) async {
    var snapshot = await _firestore.collection('users').doc(uid).get();
    return snapshot.reference;
  }

  static Future<List<PositionModel>> getPositions() async {
    List<PositionModel> list = [];
    var snap = await _firestore.collection('positions').get();
    for (var element in snap.docs) {
      var pos = element.data() as Map<String, dynamic>;
      pos['id'] = element.id;
      list.add(PositionModel.fromJson(pos));
    }
    return list;
  }

  static addPostion(Map<String, dynamic> data) {
    _firestore.collection('positions').add(data);
  }

  static deletePosition(String id) {
    if (id == '') return;
    _firestore.collection('positions').doc(id).delete();
  }

  static updateNumberOfPosition(String id, int num) {
    if (id == '') return;
    _firestore.collection('positions').doc(id).update({'number': num});
  }
}
