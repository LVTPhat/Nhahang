import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sora_manager/app/data/helper/datetime_helpers.dart';
import 'package:sora_manager/app/data/models/position.dart';
import 'package:sora_manager/app/data/models/user.dart';
import 'package:sora_manager/app/data/services/database.dart';
import 'package:sora_manager/app/modules/worktime/views/components/add_position.dart';
import 'package:sora_manager/common/constant.dart';
import 'dart:convert';

class StaffsController extends GetxController {
  final cloudImage =
      "https://firebasestorage.googleapis.com/v0/b/nha-hang-sora.appspot.com/o/avatar%2Fanh5.jpg?alt=media&token=908d2869-7599-4a15-aed3-3cb86fc273e0";
  late UserModel currentUser;
  late String initName,
      initPhone,
      initAddress,
      newUrlAvatar,
      newPosition = '',
      newName,
      newAddress,
      newSex,
      newPhone;
  late Timestamp newBirthDate;
  String posName = '';
  late int initSalary, newSalary = 0;
  final GlobalKey<FormState> signupFormKey =
      new GlobalKey<FormState>(debugLabel: '_staffScreen');

  FirebaseAuth _auth = FirebaseAuth.instance;

  var name = '';
  var email = '';
  var phone = '';
  var password = '';

  List<String> workdays = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday'
  ];

  List<String> workdayChoose = [];

  Rx<String> _searchStaffName = ''.obs;
  String get searchStaffName => _searchStaffName.value;
  set searchStaffName(value) => _searchStaffName.value = value;

  RxBool _isReadTimeEnd = false.obs;
  bool get isReadTimeEnd => _isReadTimeEnd.value;
  set isReadTimeEnd(value) => _isReadTimeEnd.value = value;

  RxBool _isLoadingWorktimeData = true.obs;
  bool get isLoadingWorktimeData => _isLoadingWorktimeData.value;
  set isLoadingWorktimeData(value) => _isLoadingWorktimeData.value = value;

  RxBool _isReadTimeStart = false.obs;
  bool get isReadTimeStart => _isReadTimeStart.value;
  set isReadTimeStart(value) => _isReadTimeStart.value = value;

  RxString _hint = 'Phục vụ'.obs;
  String get hint => _hint.value;
  set hint(value) => _hint.value = value;

  Rx<Uint8List> _image = new Uint8List(0).obs;
  Uint8List get image => _image.value;
  set image(value) => _image.value = value;

  RxList<bool> _workdaysCheck =
      [false, false, false, false, false, false, false].obs;
  List<bool> get workdaysCheck => _workdaysCheck.value;
  set workdaysCheck(value) => _workdaysCheck.value = value;

  Rx<Color> _bgCheckBox = Colors.white.obs;
  Color get bgCheckBox => _bgCheckBox.value;
  set bgCheckBox(value) => _bgCheckBox.value = value;

  Rx<Color> _bgCheckBoxAdd = Colors.white.obs;
  Color get bgCheckBoxAdd => _bgCheckBoxAdd.value;
  set bgCheckBoxAdd(value) => _bgCheckBoxAdd.value = value;

  RxBool _sex = true.obs;
  bool get sex => _sex.value;
  set sex(value) => _sex.value = value;

  RxBool _isHaveAcc = false.obs;
  bool get isHaveAcc => _isHaveAcc.value;
  set isHaveAcc(value) => _isHaveAcc.value = value;

  Rx<int> _chooseIndex = 0.obs;
  int get chooseIndex => _chooseIndex.value;
  set chooseIndex(value) => _chooseIndex.value = value;

  Rx<String> _pos = 'Tất cả'.obs;
  String get pos => _pos.value;
  set pos(value) => _pos.value = value;

  Rx<String> _currentUserID = 'Thien'.obs;
  String get currentUserID => _currentUserID.value;
  set currentUserID(value) => _currentUserID.value = value;

  RxBool _isChooseImage = false.obs;
  bool get isChooseImage => _isChooseImage.value;
  set isChooseImage(value) => _isChooseImage.value = value;

  RxBool _isUpdate = false.obs;
  bool get isUpdate => _isUpdate.value;
  set isUpdate(value) => _isUpdate.value = value;

  RxBool _isLoadCurrentUser = true.obs;
  bool get isLoadCurrentUser => _isLoadCurrentUser.value;
  set isLoadCurrentUser(value) => _isLoadCurrentUser.value = value;

  RxBool _isNullUser = false.obs;
  bool get isNullUser => _isNullUser.value;
  set isNullUser(value) => _isNullUser.value = value;

  var _date = DateTime.now().obs;
  DateTime get date => _date.value;
  set date(value) => _date.value = value;

  var _dateGetJob = DateTime.now().obs;
  DateTime get dateGetJob => _dateGetJob.value;
  set dateGetJob(value) => _dateGetJob.value = value;

  RxList<PositionModel> _listPos =
      new List<PositionModel>.empty(growable: true).obs;
  set listPos(value) => _listPos.value = value;
  List<PositionModel> get listPos => _listPos.value;

  RxList<PositionModel> _positionList =
      new List<PositionModel>.empty(growable: true).obs;
  set positionList(value) => _positionList.value = value;
  List<PositionModel> get positionList => _positionList.value;

  Rx<TimeOfDay> _timeEnd = TimeOfDay(hour: 0, minute: 0).obs;
  TimeOfDay get timeEnd => _timeEnd.value;
  set timeEnd(value) => _timeEnd.value = value;

  Rx<TimeOfDay> _timeStart = TimeOfDay(hour: 0, minute: 0).obs;
  TimeOfDay get timeStart => _timeStart.value;
  set timeStart(value) => _timeStart.value = value;

  onClickWorkdayInWorkdayList(int index) {
    List<bool> temp = [];
    for (var ele in workdaysCheck) {
      temp.add(ele);
    }
    temp[index] = !temp[index];
    workdaysCheck = temp;
  }

  getListWorkday() {
    workdayChoose = [];
    for (int i = 0; i < 7; i++) {
      if (workdaysCheck[i]) {
        workdayChoose.add(workdays[i]);
      }
    }
  }

  updateTimeWork() {
    DateTime day = DateTime.now();
    getListWorkday();
    FirebaseFirestore.instance.collection('users').doc(currentUserID).update({
      'cantimestart': DateTimeHelpers.dateTimeToTimestamp(
          DateTimeHelpers.timeOfDayToDateTime(day, timeStart)),
      'musttimeend': DateTimeHelpers.dateTimeToTimestamp(
          DateTimeHelpers.timeOfDayToDateTime(day, timeEnd)),
      'canworkdays': workdayChoose
    });
  }

  addPosition() {
    FirebaseFirestore.instance
        .collection('positions')
        .add({'name': posName, 'number': 0});
  }

  Future<Null> getWorktimeData(String userId) async {
    isLoadingWorktimeData = true;
    var userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    var userMap = userDoc.data() as Map<String, dynamic>;
    Timestamp startTime;
    Timestamp endTime;
    List<String> listWorkday;
    if (userMap.containsKey('cantimestart')) {
      startTime = userMap['cantimestart'];
      isReadTimeStart = true;
    } else {
      startTime = Timestamp.fromDate(DateTime.now());
      isReadTimeStart = false;
    }
    if (userMap.containsKey('musttimeend')) {
      endTime = userMap['musttimeend'];
      isReadTimeEnd = true;
    } else {
      endTime = Timestamp.fromDate(DateTime.now());
      isReadTimeEnd = false;
    }
    if (userMap.containsKey('canworkdays')) {
      listWorkday = userMap['canworkdays'].cast<String>();
    } else {
      listWorkday = [];
    }
    timeStart = DateTimeHelpers.timestampToTimeOfDay(startTime);
    timeEnd = DateTimeHelpers.timestampToTimeOfDay(endTime);
    List<bool> workdayCheckTemp = [
      false,
      false,
      false,
      false,
      false,
      false,
      false
    ];
    for (var day in listWorkday) {
      int index = 0;
      for (int i = 0; i < 7; i++) {
        if (day.compareTo(workdays[i]) == 0) {
          index = i;
          break;
        }
      }
      workdayCheckTemp[index] = true;
    }
    workdaysCheck = workdayCheckTemp;
    isLoadingWorktimeData = false;
  }

  Future<Null> getPositionList() async {
    positionList = await DatabaseMethods.getPositions();
    var allMap = {'name': 'Tất cả', 'number': 0};
    var all = PositionModel.fromJson(allMap);
    positionList.add(all);
    var temp = positionList[positionList.length - 1];
    positionList[positionList.length - 1] = positionList[0];
    positionList[0] = temp;
  }

  Future<Null> getListPos() async {
    listPos = await DatabaseMethods.getPositions();
  }

  String getText(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  initHint() {
    if (currentUser.name == 'Chưa cập nhật') {
      newName = 'VD: Võ Tứ Thiên';
      initName = '';
    } else {
      initName = currentUser.name!;
      newName = currentUser.name!;
    }
    if (currentUser.phone == 'Chưa cập nhật') {
      newPhone = 'VD: 0971008616';
      initPhone = '';
    } else {
      initPhone = currentUser.phone!;
      newPhone = currentUser.phone!;
    }
    if (currentUser.address == 'Chưa cập nhật') {
      newAddress = 'VD: Ninh Kiều, Cần Thơ';
      initAddress = '';
    } else {
      initAddress = currentUser.address!;
      newAddress = currentUser.address!;
    }
    if (currentUser.dateOfBirth != null) {
      date = DateTimeHelpers.timestampsToDateTime(currentUser.dateOfBirth!);
    }
    if (currentUser.sex != null) {
      if (currentUser.sex == 'Nam') {
        sex = true;
        bgCheckBox = primaryColor;
        newSex = 'Nam';
      } else {
        if (currentUser.sex == 'Chưa cập nhật') {
          sex = true;
          bgCheckBox = primaryColor;
          newSex = 'Nam';
        } else {
          sex = false;
          bgCheckBox = Colors.white;
          newSex = 'Nữ';
        }
      }
    }
  }

  initUpdateStaff() {
    if (currentUser.position == 'Không') {
      newPosition = 'Không';
    } else {
      newPosition = currentUser.position!;
    }
    if (currentUser.salary == 0) {
      newSalary = 0;
    } else {
      newSalary = currentUser.salary!;
    }
  }

  Stream<UserModel> getCurrentUser(String currentUserID) async* {
    var userStream = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserID)
        .snapshots();
    await for (var userSnap in userStream) {
      var userMap = userSnap.data() as Map<String, dynamic>;
      UserModel user = UserModel.fromJson(userMap);
      // ignore: prefer_conditional_assignment
      if (user.name == null) {
        user.name = 'Chưa cập nhật';
      }
      // ignore: prefer_conditional_assignment
      if (user.sex == null) {
        user.sex = 'Chưa cập nhật';
      }
      // ignore: prefer_conditional_assignment
      if (user.address == null) {
        user.address = 'Chưa cập nhật';
      }
      // ignore: prefer_conditional_assignment
      if (user.phone == null) {
        user.phone = 'Chưa cập nhật';
      }

      // ignore: prefer_conditional_assignment
      if (user.email == null) {
        user.email = 'Chưa cập nhật';
      }
      // ignore: prefer_conditional_assignment
      if (user.salary == null) {
        user.salary = 0;
      }
      // ignore: prefer_conditional_assignment
      if (user.position == null) {
        user.position = 'Không';
      }
      currentUser = user;
      yield user;
    }
  }

  Stream<List<UserModel>> getAllUser(
      String position, String searchName) async* {
    var userStream = FirebaseFirestore.instance.collection('users').snapshots();
    List<UserModel> users = [];
    await for (var userSnap in userStream) {
      users.clear();
      for (var userDoc in userSnap.docs) {
        var userMap = userDoc.data() as Map<String, dynamic>;
        userMap['id'] = userDoc.id;
        var user = UserModel.fromJson(userMap);
        // ignore: prefer_conditional_assignment
        if (user.position == null) {
          user.position = 'Chưa cập nhật';
        }
        // ignore: prefer_conditional_assignment
        if (user.email == null) {
          user.email = 'Chưa cập nhật';
        }
        // ignore: prefer_conditional_assignment
        if (user.name == null) {
          user.name = 'Chưa cập nhật';
        }
        // ignore: prefer_conditional_assignment
        if (user.phone == null) {
          user.phone = 'Chưa cập nhật';
        }

        String staffNameLower = user.name!.toLowerCase();
        String searchStaffNameLower = searchName.toLowerCase();
        if (staffNameLower.contains(searchStaffNameLower)) {
          // kiem tra và them vao
          if (position.compareTo('Tất cả') == 0) {
            users.add(user);
          } else {
            if (position.compareTo(user.position!) == 0) {
              users.add(user);
            }
          }

          ///
        }
      }
      yield users;
    }
  }

  Future<Null> getFirstUser() async {
    String userId = '';
    isLoadCurrentUser = true;
    await FirebaseFirestore.instance
        .collection('users')
        .limit(1)
        .get()
        .then((value) {
      if (value.docs[0].exists) {
        currentUserID = value.docs[0].id;
        isLoadCurrentUser = false;
        userId = value.docs[0].id;
      }
    }).catchError((e) {
      currentUserID = 'thien';
      isLoadCurrentUser = false;
      isNullUser = true;
    });
    getWorktimeData(userId);
  }

  setTypeOfList(String type) {
    pos = type;
  }

  updateUserInfo(bool isChangeAvatar) {
    newBirthDate = Timestamp.fromDate(date);
    if (isChangeAvatar) {
      currentUser.avatar = newUrlAvatar;
    } else {
      currentUser.avatar = currentUser.avatar;
    }
    FirebaseFirestore.instance.collection('users').doc(currentUserID).update({
      'name': newName,
      'phone': newPhone,
      'address': newAddress,
      'dateofbirth': newBirthDate,
      'avatar': currentUser.avatar,
      'sex': newSex
    });
    // isUpdate = true;
  }

  // bat dau update anh

  Future pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result?.files.first != null) {
      image = result!.files.first.bytes!;
      isChooseImage = true;
    } else {
      throw "Cancelled File Picker";
    }
  }

  Future<void> deleteAvatar(String url) async {
    await FirebaseStorage.instance.refFromURL(url).delete().then((value) {});
  }

  Future uploadImage() async {
    if (isChooseImage) {
      String nameImage = DateTime.now().millisecondsSinceEpoch.toString();

      Reference _reference =
          FirebaseStorage.instance.ref().child('avatar/$nameImage');
      await _reference
          .putData(
        image,
        SettableMetadata(contentType: 'image/jpeg'),
      )
          .whenComplete(() async {
        await _reference.getDownloadURL().then((value) {
          newUrlAvatar = value;
          if (currentUser.avatar != null) {
            deleteAvatar(currentUser.avatar!);
          }
          updateUserInfo(true);
        }).catchError((e) {
          updateUserInfo(false);
        });
      });
    } else {
      updateUserInfo(false);
    }
    isChooseImage = false;
    //  reLoadUserInfor();
  }

  updateStaff() {
    if (newPosition != 'Không') {
      Timestamp dateOfEmployment =
          DateTimeHelpers.dateTimeToTimestamp(dateGetJob);
      FirebaseFirestore.instance.collection('users').doc(currentUserID).update({
        'salary': newSalary,
        'position': newPosition,
        'dateofemployment': dateOfEmployment
      }).then((value) {});
    } else {
      Timestamp dateOfEmployment =
          DateTimeHelpers.dateTimeToTimestamp(dateGetJob);
      FirebaseFirestore.instance.collection('users').doc(currentUserID).update({
        'salary': newSalary,
        'dateofemployment': dateOfEmployment
      }).then((value) {});
    }
  }

  // Phần đăng nhập
  String? validateEmail(String email) {
    if (email.length < 1) {
      return 'Hãy nhập vào email!';
    }
    if (!GetUtils.isEmail(email)) {
      return 'Email không chính xác!';
    }
    return null;
  }

  String? validateName(String name) {
    if (name.length >= 255) {
      return 'Tên của bạn không được vượt quá 255 kí tự!';
    }
    if (name.length < 1) {
      return 'Hãy nhập vào tên!';
    }
    return null;
  }

  String? validatePhone(String phone) {
    if (phone.length < 1) {
      return 'Hãy nhập vào số điện thoại!';
    }
    if (!GetUtils.isPhoneNumber(phone)) {
      return 'Số điện thoại không chính xác!';
    }
    return null;
  }

  void checkSignUp(bool isHaveAcc) {
    final isValid = signupFormKey.currentState!.validate();
    if (!isValid) {
      print('Fail to validate');
      return;
    }
    signupFormKey.currentState!.save();
    createUser(isHaveAcc);
  }

  void createUser(bool isHaveAcc) async {
    if (isHaveAcc) {
      this.password = autoPass();
      try {
        CollectionReference reference =
            FirebaseFirestore.instance.collection('users');

        Map<String, dynamic> userData = {
          'name': this.name,
          'email': this.email,
          'phone': this.phone,
        };
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
                email: this.email, password: this.password);

        reference.doc(userCredential.user!.uid).set(userData).then((value) {});
        sendEmail(
            staffName: this.name, pass: this.password, sendTo: this.email);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          /* Get.snackbar("Sign up error!", "The password provided is too weak.",
              snackPosition: SnackPosition.BOTTOM);*/
        } else if (e.code == 'email-already-in-use') {
          /*
          Get.snackbar(
              "Sign up error!", "The account already exists for that email.",
              snackPosition: SnackPosition.BOTTOM);*/
        }
      }
    } else {
      CollectionReference reference =
          FirebaseFirestore.instance.collection('users');
      Map<String, dynamic> userData = {
        'name': this.name,
        'email': this.email,
        'phone': this.phone,
      };
      reference.add(userData).then((value) {});
    }
    resetData();
    Get.back();
  }

  Future sendEmail({
    required String staffName,
    required String pass,
    required String sendTo,
  }) async {
    final String serviceId = 'service_layfvfq';
    final String templateId = 'template_q7v6r0w';
    final String userId = 'mnKzjKVOwueoX3XTd';

    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'staff_name': staffName,
            'pass': pass,
            'send_to': sendTo
          }
        }));

    print(response.body);
  }

  String autoPass() {
    return '123456';
  }

  resetData() {
    email = '';
    name = '';
    password = '';
    phone = '';
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
