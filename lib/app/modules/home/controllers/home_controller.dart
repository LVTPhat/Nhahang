import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sora_manager/app/data/models/dinner_table.dart';
import 'package:sora_manager/app/data/models/notification%20copy.dart';
import 'package:sora_manager/app/data/models/user.dart';
import 'package:sora_manager/app/data/services/database.dart';
import 'package:sora_manager/app/data/user_infor.dart';
import 'package:sora_manager/app/routes/app_pages.dart';

class HomeController extends GetxController {
  late UserModel userInfo;
  late UserInfor user;
  final cloudImage =
      "https://firebasestorage.googleapis.com/v0/b/nha-hang-sora.appspot.com/o/avatar%2Fanh5.jpg?alt=media&token=908d2869-7599-4a15-aed3-3cb86fc273e0";
  final DatabaseMethods databaseMethods = new DatabaseMethods();

  Rx<bool> _loadDone = false.obs;
  bool get loadDone => _loadDone.value;
  set loadDone(value) => _loadDone.value = value;

  Stream<List<DinnerTableModel>> getAllTable() async* {
    var dinnerTableStream =
        FirebaseFirestore.instance.collection('dinnertables').snapshots();
    List<DinnerTableModel> dinnertables = [];
    await for (var dinnerTableSnap in dinnerTableStream) {
      dinnertables.clear();
      for (var dinnerTableDoc in dinnerTableSnap.docs) {
        var dinnerTableMap = dinnerTableDoc.data() as Map<String, dynamic>;
        var dinnerTable = DinnerTableModel.fromJson(dinnerTableMap);
        dinnertables.add(dinnerTable);
      }
      yield dinnertables;
    }
  }

  checkSingIn() {
    if (FirebaseAuth.instance.currentUser == null) {
      Get.offAndToNamed(Routes.LOGIN);
    }
  }

  //Future<Null> getUserInfo() async {
  //  userInfo = await databaseMethods.getUserByUID(UserId.id!);
  //  user = new UserInfor(userInfo);
  //  loadDone = true;
  //}

  Future<Null> deleteNotification(String notifiId) async {
    FirebaseFirestore.instance
        .collection('notifications')
        .doc(notifiId)
        .delete();
  }

  Stream<List<NotificationModel>> getNotification() async* {
    var notificationStream;
    notificationStream = FirebaseFirestore.instance
        .collection('notifications')
        .orderBy('time', descending: true)
        .snapshots();
    List<NotificationModel> notifications = [];
    await for (var notifiSnap in notificationStream) {
      notifications.clear();
      for (var notifiDoc in notifiSnap.docs) {
        var notifi = notifiDoc.data() as Map<String, dynamic>;
        notifi['id'] = notifiDoc.id;
        if (notifi.containsKey('from')) {
          DocumentSnapshot userRef = await notifi['from'].get();
          if (userRef.exists) {
            var user = userRef.data() as Map<String, dynamic>;
            notifi['name'] = user['name'];
            notifi['avatar'] = user['avatar'];
          }
        }
        NotificationModel noti = NotificationModel.fromJson(notifi);
        if (noti.title!.compareTo('Thông báo từ bếp') != 0) {
          // ignore: prefer_conditional_assignment
          if (noti.avatar == null) {
            noti.avatar = cloudImage;
          }
          // ignore: prefer_conditional_assignment
          if (noti.name == null) {
            noti.name = 'Chưa cập nhật';
          }
        }
        notifications.add(noti);
      }
      yield notifications;
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    // checkSingIn();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
