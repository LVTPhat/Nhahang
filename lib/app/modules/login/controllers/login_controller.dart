import 'dart:math';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sora_manager/app/data/helper/storge_helperfunctions.dart';
import 'package:sora_manager/app/data/services/auth.dart';
import 'package:sora_manager/app/data/user_id.dart';
import 'package:sora_manager/app/routes/app_pages.dart';
import 'package:sora_manager/common/constant.dart';

class LoginController extends GetxController {
  final formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool isLoading = false;
  AuthMethods authMethods = new AuthMethods();
  late UserId id;
  final carouselController = Get.put(CarouselController());
  RxInt activeIndex = 0.obs;

  final urlImages = [
    'assets/images/image_1.jpg',
    'assets/images/image_2.jpg',
    'assets/images/image_3.jpg',
    'assets/images/image_4.jpg',
    'assets/images/image_5.jpg',
    'assets/images/image_6.jpg'
  ];
  final textBelowImages = [
    'Nâng cao hiệu quả',
    'Gọi món nhanh chóng',
    'Kết nối giữa các nhân viên',
    'Quản lý nhân viên',
    'Biến nhà hàng thành một nơi sang trọng',
    'Dễ dàng và thuận tiện'
  ];
  final notes = [
    'Chất lượng và hiệu quả của việc phục vụ được nâng cao',
    'Quá trình gọi món được thực hiện qua thiết bị di động',
    'Các nhân viên hợp tác, trao đổi thông tin với nhau thông qua các thiết bị thông minh',
    'Cung cấp các tính năng hỗ trợ quản lý nhân viên một cách dễ dàng',
    'Khách hàng của bạn sẽ tận hưởng các món ăn cũng như các dịch vụ cao cấp',
    'Hỗ trợ cho công việc của mọi nhân viên và nâng cao hiệu suất làm việc của họ'
  ];

  RxBool initializedFirebase = false.obs;
  RxBool isAuth = false.obs;

  void _initFirebase() async {
    try {
      await Firebase.initializeApp();
      initializedFirebase.value = true;
    } catch (e) {
      print(e);
    }
  }

  void _initUserSession() {
    try {
      isAuth.value = FirebaseAuth.instance.currentUser != null;
    } catch (e) {
      print(e);
    }
  }

  void _listenAuthState() {
    try {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        isAuth.value = user != null;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<Null> handleSignIn(BuildContext context) async {
    bool? isValid = formkey.currentState?.validate();
    if (isValid != null && isValid) {
      formkey.currentState?.save();

      HelperFunctions.saveUserEmailSharedPreference(email.toString());

      /* databaseMethods.getUserByUserEmail(email).then((valueGet) {
        snapshotUserInfo = valueGet;
        HelperFunctions.saveUserNameSharedPreference(
            snapshotUserInfo?.docs[0]["name"]);
      });*/

      isLoading = true;

      authMethods
          .signInWithEmailAndPassword(email.toString(), password.toString())
          .then((value) async {
        if (value != null) {
          //  databaseMethods.getUserByUserEmail(email.toString());
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          id = new UserId(FirebaseAuth.instance.currentUser!.uid.toString());

          // tuy them role de dang nhap
          String? role = await getRole(FirebaseAuth.instance.currentUser!.uid);
          if (role != null) {
            if (role.compareTo('admin') == 0) {
              Get.offAllNamed(Routes.HOME);
            } else {
              Get.offAllNamed(Routes.COOKER);
            }
          } else {
            final snackBar = SnackBar(
              backgroundColor: primaryColor,
              content: const Text(
                'Tài khoản của bạn không thể đăng nhập vào hệ thống!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        } else {
          final snackBar = SnackBar(
            backgroundColor: primaryColor,
            content: const Text(
              'Email hoặc Mật khẩu không chính xác!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    }
  }

  Future<String?> getRole(String uid) async {
    var roleDoc =
        await FirebaseFirestore.instance.collection('roles').doc(uid).get();
    if (roleDoc.exists) {
      var roleMap = roleDoc.data() as Map<String, dynamic>;
      String role = roleMap['role'];
      return role;
    }
    return null;
  }

  @override
  void onInit() {
    super.onInit();
    _initFirebase();
  }

  @override
  void onReady() {
    super.onReady();

    once(
      initializedFirebase,
      (_) => _initUserSession(),
      condition: () => initializedFirebase.isTrue,
    );
    once(
      initializedFirebase,
      (_) => _listenAuthState(),
      condition: () => initializedFirebase.isTrue,
    );
  }

  @override
  void onClose() {}
}
