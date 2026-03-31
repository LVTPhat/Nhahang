// ignore_for_file: unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sora_manager/app/data/helper/datetime_helpers.dart';
import 'package:sora_manager/app/data/models/auto_schedule_data.dart';
import 'package:sora_manager/app/data/models/position.dart';
import 'package:sora_manager/app/data/models/schedule.dart';
import 'package:sora_manager/app/data/models/shift.dart';
import 'package:sora_manager/app/data/models/timekeeping.dart';
import 'package:sora_manager/app/data/models/user.dart';
import 'package:sora_manager/app/data/models/workday.dart';
import 'package:sora_manager/app/data/models/worktime_data.dart';
import 'package:sora_manager/app/data/services/database.dart';

class WorktimeController extends GetxController {
  final GlobalObjectKey<ScaffoldState> key =
      new GlobalObjectKey<ScaffoldState>('key1');
  final _firestore = FirebaseFirestore.instance;
  final DatabaseMethods _databaseMethods = new DatabaseMethods();

  String posName = '', shiftName = '', position = '';
  List<String> workdayId = [];
  String currentDay = '', currentShift = '', currenNamePos = '';
  bool isInsertShift = true, openW = false;
  int timeOfShift = 0;
  late BuildContext context;
  int numberOfStaff = 0, maxNumberOfStaff = 0;
  late PositionModel currenPosition;
  int num = 0;
  late Schedule schedule;
  late Timekeeping timekeeping;
  late bool isDataChange = true;
  late Stream loadScheduleData;
  String day = '';
  late AutoSchedule staffData;
  int flag = 0;
  late DateTime monOfLastWeek;
  late Worktime worktime;
  final cloudImage =
      "https://firebasestorage.googleapis.com/v0/b/nha-hang-sora.appspot.com/o/avatar%2Fanh5.jpg?alt=media&token=908d2869-7599-4a15-aed3-3cb86fc273e0";

  var _focusDay = DateTime.now().obs;
  DateTime get focusDay => _focusDay.value;
  set focusDay(value) => _focusDay.value = value;
  late List<DateTime> weekday;
  bool isChangeDay = true;

  RxList<UserModel> _allStaffPos =
      new List<UserModel>.empty(growable: true).obs;
  List<UserModel> get allStaffPos => _allStaffPos.value;
  set allStaffPos(value) => _allStaffPos.value = value;

  RxList<UserModel> _staffList = new List<UserModel>.empty(growable: true).obs;
  List<UserModel> get staffList => _staffList.value;
  set staffList(value) => _staffList.value = value;

  Rx<bool> _isLoadStaffList = true.obs;
  bool get isLoadStaffList => _isLoadStaffList.value;
  set isLoadStaffList(value) => _isLoadStaffList.value = value;

  Rx<bool> _isLoadShifts = false.obs;
  bool get isLoadShifts => _isLoadShifts.value;
  set isLoadShifts(value) => _isLoadShifts.value = value;

  Rx<int> _chooseIndex = 0.obs;
  int get chooseIndex => _chooseIndex.value;
  set chooseIndex(value) => _chooseIndex.value = value;

  Rx<int> _coppyPercent = 100.obs;
  int get coppyPercent => _coppyPercent.value;
  set coppyPercent(value) => _coppyPercent.value = value;

  Rx<int> _autoSchedudling = 100.obs;
  int get autoSchedudling => _autoSchedudling.value;
  set autoSchedudling(value) => _autoSchedudling.value = value;

  Rx<int> _loadingProcessing = 0.obs;
  int get loadingProcessing => _loadingProcessing.value;
  set loadingProcessing(value) => _loadingProcessing.value = value;

  RxList<PositionModel> _positionList =
      new List<PositionModel>.empty(growable: true).obs;
  set positionList(value) => _positionList.value = value;
  List<PositionModel> get positionList => _positionList.value;

  RxList<PositionModel> _workdayPos =
      new List<PositionModel>.empty(growable: true).obs;
  set workdayPos(value) => _workdayPos.value = value;
  List<PositionModel> get workdayPos => _workdayPos.value;

  Rx<TimeOfDay> _timeEnd = TimeOfDay(hour: 0, minute: 0).obs;
  TimeOfDay get timeEnd => _timeEnd.value;
  set timeEnd(value) => _timeEnd.value = value;

  Rx<TimeOfDay> _timeStart = TimeOfDay(hour: 0, minute: 0).obs;
  TimeOfDay get timeStart => _timeStart.value;
  set timeStart(value) => _timeStart.value = value;

  var _monOfWeek = DateTime.now().obs;
  DateTime get monOfWeek => _monOfWeek.value;
  set monOfWeek(value) => _monOfWeek.value = value;

  var _selectedDay = DateTime.now().obs;
  DateTime get selectedDay => _selectedDay.value;
  set selectedDay(value) => _selectedDay.value = value;

  Rx<String> _currentShiftName = ''.obs;
  String get currentShiftName => _currentShiftName.value;
  set currentShiftName(value) => _currentShiftName.value = value;

  Rx<String> _currentShiftTime = ''.obs;
  String get currentShiftTime => _currentShiftTime.value;
  set currentShiftTime(value) => _currentShiftTime.value = value;

  Rx<int> _currentShiftSalary = 0.obs;
  int get currentShiftSalary => _currentShiftSalary.value;
  set currentShiftSalary(value) => _currentShiftSalary.value = value;

  Rx<int> _currentNumberOfStaff = 0.obs;
  int get currentNumberOfStaff => _currentNumberOfStaff.value;
  set currentNumberOfStaff(value) => _currentNumberOfStaff.value = value;

  Rx<int> _currentNumberStaffOfDay = 0.obs;
  int get currentNumberStaffOfDay => _currentNumberStaffOfDay.value;
  set currentNumberStaffOfDay(value) => _currentNumberStaffOfDay.value = value;

  setId(String shiftId, String workdayId) {
    currentShift = shiftId;
    currentDay = workdayId;
    // print('shift: ${currentShift}, day: ${currentDay}');
  }

  getTimeOfShift(Timestamp timeStart, Timestamp timeEnd) {
    String start = DateTimeHelpers.timestampsToTime(timeStart);
    String end = DateTimeHelpers.timestampsToTime(timeEnd);
    int startHour = int.parse(start.substring(0, 2));
    int startMin = int.parse(start.substring(3));
    int endHour = int.parse(end.substring(0, 2));
    int endMin = int.parse(end.substring(3));
    if ((endHour * 60 + endMin) - (startHour * 60 + startMin) > 0) {
      timeOfShift = (endHour * 60 + endMin) - (startHour * 60 + startMin);
    } else {
      timeOfShift =
          24 * 60 - (startHour * 60 + startMin) + (endHour * 60 + endMin);
    }
    //  print(timeOfShift);
  }

  Future<Null> updateNumberOfStaff() async {
    int numberOfStaff = 0;
    for (var pos in workdayPos) {
      var temp = await _firestore
          .collection('worktime')
          .doc(DateTimeHelpers.dateTimeToDate(monOfWeek))
          .collection('shifts')
          .doc(currentShift)
          .collection('workdays')
          .doc(currentDay)
          .collection(pos.name!)
          .get();
      numberOfStaff += temp.docs.length;
    }
    currentNumberOfStaff = numberOfStaff;
    _firestore
        .collection('worktime')
        .doc(DateTimeHelpers.dateTimeToDate(monOfWeek))
        .collection('shifts')
        .doc(currentShift)
        .collection('workdays')
        .doc(currentDay)
        .update({'staffnumber': currentNumberOfStaff}).whenComplete(
            () => refreshSchedule(currentShift));
  }

  Future<Null> updateMaxNumberOfStaff() async {
    int maxNumberOfStaff = 0;
    var temp = await _firestore
        .collection('worktime')
        .doc(DateTimeHelpers.dateTimeToDate(monOfWeek))
        .collection('shifts')
        .doc(currentShift)
        .collection('workdays')
        .doc(currentDay)
        .get();
    var workdayMap = temp.data() as Map<String, dynamic>;
    for (var ele in workdayMap.keys) {
      if (ele.compareTo('staffnumber') != 0 &&
          ele.compareTo('maxstaffnumber') != 0) {
        int num = workdayMap[ele];
        maxNumberOfStaff += num;
      }
    }
    _firestore
        .collection('worktime')
        .doc(DateTimeHelpers.dateTimeToDate(monOfWeek))
        .collection('shifts')
        .doc(currentShift)
        .collection('workdays')
        .doc(currentDay)
        .update({'maxstaffnumber': maxNumberOfStaff}).whenComplete(
            () => refreshSchedule(currentShift));
  }

  Future<Null> getCurrentShiftData() async {
    // get so luong nhan vien trong ca
    int numberOfStaff = 0;
    double sumSalary = 0;
    for (var pos in workdayPos) {
      var temp = await _firestore
          .collection('worktime')
          .doc(DateTimeHelpers.dateTimeToDate(monOfWeek))
          .collection('shifts')
          .doc(currentShift)
          .collection('workdays')
          .doc(currentDay)
          .collection(pos.name!)
          .get();
      numberOfStaff += temp.docs.length;
      for (var ele in temp.docs) {
        var eleMap = ele.data() as Map<String, dynamic>;
        DocumentReference staffRef = eleMap['staff'];
        var staffDoc = await staffRef.get();
        var staffMap = staffDoc.data() as Map<String, dynamic>;
        double tempSalary = staffMap['salary'];
        sumSalary += timeOfShift * (tempSalary / 60);
      }
    }
    currentNumberOfStaff = numberOfStaff;
    currentShiftSalary = sumSalary;
  }

  Future<Null> updateCurrentNumberOfStaff(String shiftId) async {
    for (var day in workdayId) {
      var snapWorkday = await _firestore
          .collection('worktime')
          .doc(DateTimeHelpers.dateTimeToDate(monOfWeek))
          .collection('shifts')
          .doc(shiftId)
          .collection('workdays')
          .doc(day)
          .get();
      var mapWorkday = snapWorkday.data() as Map<String, dynamic>;
      int numTemp = 0;
      int maxNum = 0;
      for (var ele in mapWorkday.keys) {
        if (ele.compareTo('staffnumber') != 0 &&
            ele.compareTo('maxstaffnumber') != 0) {
          var snapDay = await _firestore
              .collection('worktime')
              .doc(DateTimeHelpers.dateTimeToDate(monOfWeek))
              .collection('shifts')
              .doc(shiftId)
              .collection('workdays')
              .doc(day)
              .collection(ele)
              .get();
          numTemp += snapDay.docs.length;
          int temp = mapWorkday[ele];
          maxNum += temp;
        }
      }
      _firestore
          .collection('worktime')
          .doc(DateTimeHelpers.dateTimeToDate(monOfWeek))
          .collection('shifts')
          .doc(shiftId)
          .collection('workdays')
          .doc(day)
          .update({'staffnumber': numTemp, 'maxstaffnumber': maxNum});
    }
  }

  Future<Null> getStaffList(String shiftId, String shiftDay, String pos) async {
    isLoadStaffList = true;
    // print('getStaffList(${shiftId},${shiftDay},${pos})');
    List<UserModel> list = [];
    var snap = await _firestore
        .collection('worktime')
        .doc(DateTimeHelpers.dateTimeToDate(monOfWeek))
        .collection('shifts')
        .doc(shiftId)
        .collection('workdays')
        .doc(shiftDay)
        .collection(pos)
        .get();
    for (var doc in snap.docs) {
      var map = doc.data() as Map<String, dynamic>;
      if (map.containsKey('staff')) {
        DocumentReference ref = map['staff'];
        var docStaff = await ref.get();
        var mapStaff = docStaff.data() as Map<String, dynamic>;
        mapStaff['id'] = docStaff.id;
        list.add(UserModel.fromJson(mapStaff));
      }
    }

    staffList = list;
    isLoadStaffList = false;
    getAllStaffOfPos(pos);
    // print(isLoadStaffList);
  }

  List<DateTime> getWeek(DateTime focusDay) {
    List<DateTime> week = [];
    int temp = focusDay.weekday;
    int count = 1;
    int i, j;
    while (temp > 1) {
      focusDay.add(Duration(days: count));
      week.add(focusDay.subtract(Duration(days: count)));
      ;
      temp--;
      count++;
    }

    temp = focusDay.weekday;
    count = 0;
    while (temp <= 7) {
      focusDay.add(Duration(days: count));
      week.add(focusDay.add(Duration(days: count)));
      temp++;
      count++;
    }
    for (i = 0; i <= 5; i++) {
      for (j = i + 1; j <= 6; j++) {
        if (week[i].isAfter(week[j])) {
          DateTime a = week[i];
          week[i] = week[j];
          week[j] = a;
        }
      }
    }
    weekday = week;
    return week;
  }

  getday(String dayOfWeek, DateTime date) {
    String temp = '';
    switch (dayOfWeek) {
      case 'monday':
        temp = 'thứ hai';
        break;
      case 'tuesday':
        temp = 'thứ ba';
        break;
      case 'wednesday':
        temp = 'thứ tư';
        break;
      case 'thursday':
        temp = 'thứ năm';
        break;
      case 'friday':
        temp = 'thứ sáu';
        break;
      case 'saturday':
        temp = 'thứ bảy';
        break;
      default:
        temp = 'chủ nhật';
    }
    day = '${temp} ${date.day}/${date.month}/${date.year}';
  }

  initWorkdayId() {
    workdayId.add('monday');
    workdayId.add('tuesday');
    workdayId.add('wednesday');
    workdayId.add('thursday');
    workdayId.add('friday');
    workdayId.add('saturday');
    workdayId.add('sunday');
  }

  getMonOfWeek() {
    DateTime mon = selectedDay;
    int temp = selectedDay.weekday;
    int count = 1;
    while (temp > 1) {
      selectedDay.add(Duration(days: count));
      mon = selectedDay.subtract(Duration(days: count));
      temp--;
      count++;
    }
    if (mon.compareTo(monOfWeek) != 0) {
      monOfWeek = mon;
    }
    monOfLastWeek = mon.subtract(Duration(days: 7));
    changeProcess();
  }

  Stream<List<ShiftModel>> getShifts(DateTime mon) async* {
    var ShiftStream = FirebaseFirestore.instance
        .collection('worktime')
        .doc(DateTimeHelpers.dateTimeToDate(mon))
        .collection('shifts')
        .orderBy('timestart')
        .snapshots();
    List<ShiftModel> shifts = [];
    await for (var ShiftSnap in ShiftStream) {
      shifts.clear();
      for (var ShiftDoc in ShiftSnap.docs) {
        var ShiftMap = ShiftDoc.data() as Map<String, dynamic>;
        ShiftMap['id'] = ShiftDoc.id;
        var shift = ShiftModel.fromJson(ShiftMap);
        var workdaysSnap =
            await ShiftDoc.reference.collection('workdays').get();
        List<WorkdayModel> list = [];
        for (var dayDoc in workdaysSnap.docs) {
          var dayMap = dayDoc.data() as Map<String, dynamic>;
          dayMap['id'] = dayDoc.id;

          var day = WorkdayModel.fromJson(dayMap);
          day.currentNumberStaff ??= 0;
          day.maxNumberStaff ??= 1;
          list.add(day);
        }

        // shift.setWorkday(list);
        timeStart = DateTimeHelpers.timestampToTimeOfDay(shift.timeEnd!);
        List<WorkdayModel> sortList = [];
        for (var dayId in workdayId) {
          for (var day in list) {
            if (dayId.compareTo(day.id!) == 0) {
              sortList.add(day);
            }
          }
        }
        shift.setWorkday(sortList);
        shifts.add(shift);
      }

      yield shifts;
    }
  }

  addPos(bool isAddToWorkday) {
    if (isAddToWorkday) {
      _firestore
          .collection('worktime')
          .doc(DateTimeHelpers.dateTimeToDate(monOfWeek))
          .collection('shifts')
          .doc(currentShift)
          .collection('workdays')
          .doc(currentDay)
          .update({posName: num});
      getWorkdayPos(currentShift, currentDay);
    } else {
      Map<String, dynamic> data = {'name': posName, 'number': num};
      DatabaseMethods.addPostion(data);
      getPositionList();
    }
  }

  deletePostion(String id) {
    DatabaseMethods.deletePosition(id);
    getPositionList();
  }

  updateNumOfPosition(String id) {
    DatabaseMethods.updateNumberOfPosition(id, num);
    getPositionList();
  }

  Future<Null> getPositionList() async {
    positionList = await DatabaseMethods.getPositions();
  }

  Future<Null> increaseNumberPosition(String id) async {
    int number = 0;
    await _firestore.collection('positions').doc(id).get().then((value) {
      if (value.exists) {
        var pos = value.data() as Map<String, dynamic>;
        if (pos.containsKey('number')) {
          number = pos['number'];
        }
      }
    });
    number++;
    await DatabaseMethods.updateNumberOfPosition(id, number);
    getPositionList();
  }

  Future<Null> reduceNumberPosition(String id) async {
    int number = 0;
    await _firestore.collection('positions').doc(id).get().then((value) {
      if (value.exists) {
        var pos = value.data() as Map<String, dynamic>;
        if (pos.containsKey('number')) {
          number = pos['number'];
        }
      }
    });
    if (number > 0) {
      number--;
    }
    await DatabaseMethods.updateNumberOfPosition(id, number);
    getPositionList();
  }

  Future<Null> insertShift() async {
    DateTime date = DateTime.now();
    String shiftId = '';
    int maxNumberOfStaff = 0;
    Map<String, dynamic> dataWorkday = new Map<String, dynamic>();
    for (var element in positionList) {
      if (element.number! > 0) {
        dataWorkday[element.name!] = element.number!;
        maxNumberOfStaff += element.number!;
      }
    }
    dataWorkday['maxstaffnumber'] = maxNumberOfStaff;
    this.maxNumberOfStaff = maxNumberOfStaff;
    Map<String, dynamic> dataShift = {
      'name': shiftName,
      'timestart': DateTimeHelpers.dateTimeToTimestamp(
          DateTimeHelpers.timeOfDayToDateTime(date, timeStart)),
      'timeend': DateTimeHelpers.dateTimeToTimestamp(
          DateTimeHelpers.timeOfDayToDateTime(date, timeEnd)),
    };
    _firestore
        .collection('worktime')
        .doc(DateTimeHelpers.dateTimeToDate(monOfWeek))
        .collection('shifts')
        .add(dataShift)
        .then((value) async {
      shiftId = value.id;
      for (var id in workdayId) {
        _firestore
            .collection('worktime')
            .doc(DateTimeHelpers.dateTimeToDate(monOfWeek))
            .collection('shifts')
            .doc(shiftId)
            .collection('workdays')
            .doc(id)
            .set(dataWorkday);
      }
    });
  }

  deleteShift(String id) {
    if (id == '') return;
    FirebaseFirestore.instance
        .collection('worktime')
        .doc(DateTimeHelpers.dateTimeToDate(monOfWeek))
        .collection('shifts')
        .doc(id)
        .delete()
        .whenComplete(() => changeProcess());
  }

  setTypeOfList(int index) {
    /* switch (index) {
      case 0:
        typeOfDish = 'Tất cả';
        break;
      case 1:
        typeOfDish = 'Phục vụ';
        break;
      case 2:
        typeOfDish = 'Phụ bếp';
        break;
      case 3:
        typeOfDish = 'Lễ tân';
        break;
      case 4:
        typeOfDish = 'Bếp trưởng';
        break;
      case 5:
        typeOfDish = 'Bảo vệ';
        break;
      default:
        typeOfDish = 'Tất cả';
    }
    */
  }

  Future<Null> getWorkdayPos(String shiftId, String workdayId) async {
    // print('${shiftId},${workdayId}');
    int i, j;
    List<PositionModel> list = [];
    var posDoc = await FirebaseFirestore.instance
        .collection('worktime')
        .doc(DateTimeHelpers.dateTimeToDate(monOfWeek))
        .collection('shifts')
        .doc(shiftId)
        .collection('workdays')
        .doc(workdayId)
        .get();

    var posMap = posDoc.data() as Map<String, dynamic>;
    String id = posDoc.id;
    for (var element in posMap.keys) {
      if (element.compareTo('staffnumber') != 0 &&
          element.compareTo('maxstaffnumber') != 0) {
        Map<String, dynamic> data = {
          'name': element,
          'number': posMap[element],
          'id': id
        };
        list.add(PositionModel.fromJson(data));
      }
    }
    for (i = 0; i < list.length - 1; i++) {
      for (j = i + 1; j < list.length; j++) {
        if (list[i].name!.compareTo(list[j].name!) == 1) {
          PositionModel temp = list[i];
          list[i] = list[j];
          list[j] = temp;
        }
      }
    }

    workdayPos = list;
    if (workdayPos.length != 0) {
      chooseIndex = getChooseIndex();
      if (chooseIndex > workdayPos.length - 1)
        chooseIndex = workdayPos.length - 1;
      getStaffList(shiftId, workdayId, workdayPos[chooseIndex].name!);
      position = workdayPos[chooseIndex].name!;
      currenPosition = workdayPos[chooseIndex];
    } else {
      isLoadStaffList = false;
    }
  }

  Future<Null> getAllStaffOfPos(String position) async {
    // print('getAllStaffPos(${position})');
    List<UserModel> staffs = [];
    var staffsSnap = await _firestore.collection('users').get();
    for (var staffDoc in staffsSnap.docs) {
      var staffMap = staffDoc.data() as Map<String, dynamic>;
      staffMap['id'] = staffDoc.id;
      var staff = UserModel.fromJson(staffMap);
      staff.position ??= 'Chưa cập nhật';
      if (position.compareTo(staff.position!) == 0 &&
          !findStaffInSchedule(staff)) {
        staffs.add(staff);
      }
    }
    allStaffPos = staffs;
    // print(allStaffPos.length);
    getCurrentShiftData();
    //updateCurrentNumberOfStaff(currentShift);
    // refreshSchedule();
  }

  Future<Null> refreshSchedule(String shiftId) async {
    //  await updateCurrentNumberOfStaff(currentShift);
    String temp = DateTime.now().millisecondsSinceEpoch.toString();
    await _firestore
        .collection('worktime')
        .doc(DateTimeHelpers.dateTimeToDate(monOfWeek))
        .collection('shifts')
        .doc(shiftId)
        .update({'refresh': temp});
    // print('da goi ham');
  }

  bool findStaffInSchedule(UserModel staff) {
    for (var staffInSchedule in staffList) {
      if (staff.id!.compareTo(staffInSchedule.id!) == 0) return true;
    }
    return false;
  }

  Future<Null> addStaffToSchedule(
      String shiftId, String workdayId, String pos, String staffId) async {
    //  print('addStafftoSchedule(${shiftId},${workdayId},${pos},${staffId})');
    var staffRef = await _databaseMethods.getUserRefByUID(staffId);
    //print(workdayPos[chooseIndex].name!);

    _firestore
        .collection('worktime')
        .doc(DateTimeHelpers.dateTimeToDate(monOfWeek))
        .collection('shifts')
        .doc(shiftId)
        .collection('workdays')
        .doc(workdayId)
        .collection(pos)
        .doc(staffId)
        .set({'staff': staffRef, 'useradd': 1}).whenComplete(() {
      updateNumberOfStaff();
      // changeProcess();
      isDataChange = true;
    });
    getStaffList(shiftId, workdayId, pos);
  }

  Future<Null> deleteStaffFromSchedule(
      String shiftId, String workdayId, String pos, String staffId) async {
    await _firestore
        .collection('worktime')
        .doc(DateTimeHelpers.dateTimeToDate(monOfWeek))
        .collection('shifts')
        .doc(shiftId)
        .collection('workdays')
        .doc(workdayId)
        .collection(pos)
        .doc(staffId)
        .delete()
        .whenComplete(() {
      updateNumberOfStaff();

      // changeProcess();
      isDataChange = true;
    });
    getStaffList(shiftId, workdayId, pos);
  }

  Future<int> checkLength(String posName) async {
    var staffListSnap = await _firestore
        .collection('worktime')
        .doc(DateTimeHelpers.dateTimeToDate(monOfWeek))
        .collection('shifts')
        .doc(currentShift)
        .collection('workdays')
        .doc(currentDay)
        .collection(posName)
        .get();
    return staffListSnap.docs.length;
  }

  Future<Null> increaseNumberOfPosition(String pos, int num) async {
    num++;
    await _firestore
        .collection('worktime')
        .doc(DateTimeHelpers.dateTimeToDate(monOfWeek))
        .collection('shifts')
        .doc(currentShift)
        .collection('workdays')
        .doc(currentDay)
        .update({pos: num}).whenComplete(() {
      updateMaxNumberOfStaff();
      getWorkdayPos(currentShift, currentDay);
    });
  }

  Future<Null> deletePositionOfWorkday(String pos) async {
    await _firestore
        .collection('worktime')
        .doc(DateTimeHelpers.dateTimeToDate(monOfWeek))
        .collection('shifts')
        .doc(currentShift)
        .collection('workdays')
        .doc(currentDay)
        .update({pos: FieldValue.delete()}).whenComplete(() {
      updateMaxNumberOfStaff();
      getWorkdayPos(currentShift, currentDay);
    });
  }

  Future<Null> reduceNumberOfPosition(String pos, int num) async {
    if (num > 1) num--;
    await _firestore
        .collection('worktime')
        .doc(DateTimeHelpers.dateTimeToDate(monOfWeek))
        .collection('shifts')
        .doc(currentShift)
        .collection('workdays')
        .doc(currentDay)
        .update({pos: num}).whenComplete(() {
      updateMaxNumberOfStaff();
      getWorkdayPos(currentShift, currentDay);
    });
  }

  Future<Null> updateNumberOfPosition(String pos, int num) async {
    if (num > 0) {
      await _firestore
          .collection('worktime')
          .doc(DateTimeHelpers.dateTimeToDate(monOfWeek))
          .collection('shifts')
          .doc(currentShift)
          .collection('workdays')
          .doc(currentDay)
          .update({pos: num}).whenComplete(() => updateMaxNumberOfStaff());
    }
    getWorkdayPos(currentShift, currentDay);
  }

  int getChooseIndex() {
    int temp = 0, i;
    for (i = 0; i < workdayPos.length; i++) {
      if (currenNamePos.compareTo(workdayPos[i].name!) == 0) return i;
    }
    return temp;
  }

  changeProcess() {
    flag++;
    getSchedule(flag).asStream();
  }

  Future<Null> getSchedule(int f) async {
    // khoi tao list
    if (f == flag) loadingProcessing = 0;
    List<Position> positions = [];
    List<String> pos = [];
    if (f == flag) loadingProcessing = 3;
    // bat dau lay du lieu
    // lay ve so luong cac ca truc
    List<Shift> shifts = [];
    if (f == flag) loadingProcessing = 6;
    var shiftsSnap = await _firestore
        .collection('worktime')
        .doc(DateTimeHelpers.dateTimeToDate(monOfWeek))
        .collection('shifts')
        .get();
    // lap voi moi ca truc
    if (f == flag) loadingProcessing = 15;
    for (var shiftDoc in shiftsSnap.docs) {
      var shiftMap = shiftDoc.data() as Map<String, dynamic>;
      String shiftName = shiftMap['name'];
      Timestamp timeStart = shiftMap['timestart'];
      Timestamp timeEnd = shiftMap['timeend'];
      String shiftId = shiftDoc.id;
      var daysSnap = await shiftDoc.reference.collection('workdays').get();
      List<Day> days = [];
      if (loadingProcessing < 80 && f == flag) {
        loadingProcessing += 1;
      }
      for (var dayDoc in daysSnap.docs) {
        // voi moi ngay trong tuan
        var dayMap = dayDoc.data() as Map<String, dynamic>;
        String dayName = dayDoc.id;
        List<Staff> staffs = [];
        if (loadingProcessing < 80 && f == flag) {
          loadingProcessing += 1;
        }
        for (var ele in dayMap.keys) {
          // voi moi khoa trong nhung cai khoa cua ngay lam viec
          if (ele.compareTo('staffnumber') != 0 &&
              ele.compareTo('maxstaffnumber') != 0) {
            String positionName = ele;
            var staffsSnap =
                await dayDoc.reference.collection(positionName).get();
            if (loadingProcessing < 80 && f == flag) {
              loadingProcessing += 1;
            }
            for (var staffDoc in staffsSnap.docs) {
              var staffMap = staffDoc.data() as Map<String, dynamic>;
              DocumentReference staffRef = staffMap['staff'];
              var userDoc = await staffRef.get();
              var userMap = userDoc.data() as Map<String, dynamic>;
              String staffFullName = userMap['name']; // lay ten nhan vien
              int indexTemp = staffFullName.lastIndexOf(' ');
              String id = userDoc.id;
              String staffName = staffFullName.substring(indexTemp + 1);
              int staffSalary = userMap['salary']; // lay luong cua nhan vien
              Staff staff = new Staff(staffName, staffSalary, positionName, id);
              staffs.add(staff);
              if (!pos.contains(positionName)) pos.add(positionName);
              // in ra de kiem tra loi
              /* print(staff.name! +
                  ' ' +
                  staff.salary.toString() +
                  ' ' +
                  staff.postion!);*/
              // ket thuc in
              if (loadingProcessing < 80 && f == flag) {
                loadingProcessing += 1;
              }
            }
          }
        }
        Day day = new Day(dayName, staffs);
        days.add(day);
      }
      List<Day> sortDays = [];
      for (var dayId in workdayId) {
        for (var day in days) {
          if (dayId.compareTo(day.name!) == 0) {
            sortDays.add(day);
            if (loadingProcessing < 90 && f == flag) {
              loadingProcessing += 1;
            }
          }
        }
      }
      Shift shift = new Shift(shiftName, shiftId, timeStart, timeEnd, sortDays);
      /*print(shift.name);
      for (var day in shift.listDay!) {
        print(day.name);
        for (var staff in day.listStaff!) {
          print(staff.name! +
              ' ' +
              staff.salary.toString() +
              ' ' +
              staff.postion!);
        }
      }*/
      shifts.add(shift);
    }

    // phan chi theo pos
    if (f == flag) loadingProcessing = 91;
    for (var positionName in pos) {
      Position position = new Position(positionName);

      for (var shift in shifts) {
        bool stop = false;
        for (var day in shift.listDay!) {
          if (!stop) {
            for (var staff in day.listStaff!) {
              if (staff.postion!.compareTo(positionName) == 0) {
                position.inserShift(shift.copy());
                stop = true;
                break;
              }
            }
          }
        }
      }
      positions.add(position);
    }
    if (f == flag) loadingProcessing = 92;
    for (var position in positions) {
      for (var shift in position.listShift!) {
        for (var day in shift.listDay!) {
          List<Staff> list = [];
          for (var staff in day.listStaff!) {
            if (position.name!.compareTo(staff.postion!) == 0) {
              list.add(staff);
              if (loadingProcessing <= 99 && f == flag) {
                loadingProcessing++;
              }
            }
          }
          day.listStaff = list;
        }
      }
    }
    if (f == flag) {
      schedule = new Schedule(positions);
      loadingProcessing = 100;
    }
    /* for (var position in positions) {
      //
      print(position.name!);
      //
      for (var shift in position.listShift!) {
        //
        print(shift.name! + ' ' + shift.id!);
        print('bat dau:' + shift.timeStart.toString());
        print('ket thuc:' + shift.timeEnd.toString());
        //
        for (var day in shift.listDay!) {
          //
          print(day.name);
          //
          for (var staff in day.listStaff!) {
            print(staff.name! +
                ' ' +
                staff.salary.toString() +
                ' ' +
                staff.postion!);
          }
        }
      }
    }
    print('da thuc hien xong ham');
    loadingProcessing = 100;*/
  }

  getTimekeeping() {
    List<PositionTimekeeping> listPositionTimekeeping = [];
    for (var position in schedule.listPosition!) {
      // voi moi vi tri trong lich

      // khoi tao mot danh sach nhan vien
      List<StaffTimekeeping> listStaffTimekeeping = [];

      for (var shift in position.listShift!) {
        // voi moi ca truc tuong ung voi moi vi tri

        // tinh thoi gian trong ca lam viec
        int shiftTime;
        String start = DateTimeHelpers.timestampsToTime(shift.timeStart!);
        String end = DateTimeHelpers.timestampsToTime(shift.timeEnd!);
        int startHour = int.parse(start.substring(0, 2));
        int startMin = int.parse(start.substring(3));
        int endHour = int.parse(end.substring(0, 2));
        int endMin = int.parse(end.substring(3));
        if ((endHour * 60 + endMin) - (startHour * 60 + startMin) > 0) {
          shiftTime = (endHour * 60 + endMin) - (startHour * 60 + startMin);
        } else {
          shiftTime =
              24 * 60 - (startHour * 60 + startMin) + (endHour * 60 + endMin);
        }
        // ket thuc tinh thoi gian trong ca lam viec

        for (var day in shift.listDay!) {
          // voi moi ngay trong ca truc

          for (var staff in day.listStaff!) {
            // voi moi nhan vien trong ngay
            double totalSalary = shiftTime * staff.salary! / 60;

            // kiem tra xem nhan vien da co trong danh sach chua
            bool isHaveStaff = false;
            StaffTimekeeping tempStaff;
            List<DayTimekeeping> listDay = [];
            tempStaff = new StaffTimekeeping(staff.name!, staff.id!, listDay);
            for (var staffTimekeeping in listStaffTimekeeping) {
              tempStaff = staffTimekeeping;
              if (staff.id!.compareTo(staffTimekeeping.id) == 0) {
                isHaveStaff = true;
                break;
              }
            }
            // ket thuc kiem tra

            // them nhan vien va ngay lam viec vao danh sach
            if (isHaveStaff) {
              // voi truong hop nhan vien da co trong danh sach

              // kiem tra xem ngay da co trong danh sach nhan vien chưa
              bool isHaveDay = false;
              // ignore: unnecessary_new
              DayTimekeeping tempDay =
                  new DayTimekeeping(shiftTime, totalSalary.toInt(), day.name!);
              for (var dayTimekeeping in tempStaff.listDayTimekeeping) {
                if (dayTimekeeping.name.compareTo(day.name!) == 0) {
                  isHaveDay = true;
                  tempDay = dayTimekeeping;
                  break;
                }
              }
              // ket thuc kiem tra

              if (isHaveDay) {
                // truong hop ngay da co trong nhan vien
                tempDay.totalTime += shiftTime;
                tempDay.totalSalary += totalSalary.toInt();
              } else {
                // truong hop ngay chua co trong nhan vien
                tempStaff.listDayTimekeeping.add(tempDay);
              }
            } else {
              // voi truong hop nhan vien chua co trong danh sach
              List<DayTimekeeping> listDayTimekeeping = [];
              // ignore: unnecessary_new
              DayTimekeeping newDay =
                  new DayTimekeeping(shiftTime, totalSalary.toInt(), day.name!);
              listDayTimekeeping.add(newDay);
              // ignore: unnecessary_new
              StaffTimekeeping staffTime = new StaffTimekeeping(
                  staff.name!, staff.id!, listDayTimekeeping);
              listStaffTimekeeping.add(staffTime);
            }
          } //staff list
        } // day list
      } // shift list
      for (var staffTimekeeping in listStaffTimekeeping) {
        List<DayTimekeeping> sortDays = [];
        for (var dayName in workdayId) {
          bool isHaveDay = false;
          for (var day in staffTimekeeping.listDayTimekeeping) {
            if (day.name.compareTo(dayName) == 0) {
              sortDays.add(day);
              isHaveDay = true;
              break;
            }
          }
          if (!isHaveDay) {
            DayTimekeeping newDay = new DayTimekeeping(0, 0, dayName);
            sortDays.add(newDay);
          }
        }
        staffTimekeeping.listDayTimekeeping = sortDays;
      }
      PositionTimekeeping positionTimekeeping =
          new PositionTimekeeping(position.name!, listStaffTimekeeping);
      listPositionTimekeeping.add(positionTimekeeping);
    } // position list
    timekeeping = new Timekeeping(listPositionTimekeeping);
    print(
        '-----------------------------------------------------------------------------');
    for (var position in listPositionTimekeeping) {
      print(position.name);
      for (var staff in position.listStaffTimekeeping) {
        print(staff.name);
        for (var day in staff.listDayTimekeeping) {
          print(day.name);
          print('Tong gio lam: ' +
              day.totalTime.toString() +
              '; Tong tien luong: ' +
              day.totalSalary.toString());
        }
      }
    }
  }

  Future<Null> getStaffData() async {
    List<PositionAutoSchedule> listPosition = [];
    var staffsSnap = await _firestore.collection('users').get();
    for (var staffDoc in staffsSnap.docs) {
      var staffMap = staffDoc.data() as Map<String, dynamic>;
      if (staffMap.containsKey('salary') && staffMap.containsKey('position')) {
        int staffSalary = staffMap['salary'];
        String staffName = staffMap['name'];
        Timestamp startTime;
        Timestamp endTime;
        int timeStart = 0;
        int timeEnd = 0;
        List<String> listWorkday;
        if (staffMap.containsKey('cantimestart')) {
          startTime = staffMap['cantimestart'];
          timeStart = DateTimeHelpers.getTime(startTime);
        } else {
          timeStart = 0;
        }
        if (staffMap.containsKey('musttimeend')) {
          endTime = staffMap['musttimeend'];
          timeEnd = DateTimeHelpers.getTime(endTime);
        } else {
          timeEnd = 1440;
        }

        if (staffMap.containsKey('canworkdays')) {
          listWorkday = staffMap['canworkdays'].cast<String>();
        } else {
          listWorkday = [];
        }
        if (staffSalary != 0) {
          // thuc hien them posaddstaff vao tai day
          // kiem tra xem position co trong list pos chua
          StaffAutoSchedule staff = new StaffAutoSchedule(staffDoc.id,
              staffName, staffSalary, timeStart, timeEnd, listWorkday);
          staff.staffRef = staffDoc.reference;
          String nameOfPosition = staffMap['position'];

          List<StaffAutoSchedule> staffs = [];
          PositionAutoSchedule newPos =
              new PositionAutoSchedule(nameOfPosition, staffs);
          bool isHavePos = false;
          for (var position in listPosition) {
            if (position.name!.compareTo(nameOfPosition) == 0) {
              newPos = position;
              isHavePos = true;
              break;
            }
          } // ket thuc kiem tra
          if (isHavePos) {
            newPos.listStaff!.add(staff);
          } else {
            newPos.listStaff!.add(staff);
            listPosition.add(newPos);
          }
        }
      }
    }
    staffData = new AutoSchedule(listPosition);

    /* print(listPosition.length);
    for (var pos in listPosition) {
      print(pos.name!);
      for (var staff in pos.listStaff!) {
        print(
            staff.id! + '; luong cua nhan vien la: ' + staff.salary.toString());
        print('thoi gian co the bat dau: ' +
            staff.canTimeStart.toString() +
            '; thoi gian phai ket thuc' +
            staff.mustTimeEnd.toString());
        print('do dai cua danh sach: ' + staff.listWorkday!.length.toString());
      }
    }*/
  }

  Future<Null> autoSchedule() async {
    autoSchedudling = 0;
    await getStaffData();
    // khoi tao anh cua ca truc
    autoSchedudling = 1;
    var shiftsSnap = await _firestore
        .collection('worktime')
        .doc(DateTimeHelpers.dateTimeToDate(monOfWeek))
        .collection('shifts')
        .get();
    autoSchedudling = 2;
    // voi tung ca truc
    for (var shift in shiftsSnap.docs) {
      // tinh ra thoi gian lam viec trong ca
      if (autoSchedudling < 90) autoSchedudling += 1;
      var shiftMap = shift.data() as Map<String, dynamic>;

      Timestamp startTime = shiftMap['timestart'];

      Timestamp endTime = shiftMap['timeend'];

      int shiftTime;

      String start = DateTimeHelpers.timestampsToTime(startTime);

      String end = DateTimeHelpers.timestampsToTime(endTime);

      int startHour = int.parse(start.substring(0, 2));

      int startMin = int.parse(start.substring(3));

      int endHour = int.parse(end.substring(0, 2));

      int endMin = int.parse(end.substring(3));

      if ((endHour * 60 + endMin) - (startHour * 60 + startMin) > 0) {
        shiftTime = (endHour * 60 + endMin) - (startHour * 60 + startMin);
      } else {
        shiftTime =
            24 * 60 - (startHour * 60 + startMin) + (endHour * 60 + endMin);
      }
      // khoi tao anh cua ngay lam viec
      var workdaysSnap = await shift.reference.collection('workdays').get();
      if (autoSchedudling < 90) autoSchedudling++;
      // voi moi ngay trong ca truc
      for (var dayDoc in workdaysSnap.docs) {
        if (autoSchedudling < 90) autoSchedudling++;
        // khoi tao du lieu cua ngay truc
        print(dayDoc.id);
        var dayMap = dayDoc.data() as Map<String, dynamic>;
        int maxStaffNum = 0;
        int currentNumberOfStaff = 0;
        for (var pos in dayMap.keys) {
          if (pos.compareTo('staffnumber') != 0 &&
              pos.compareTo('maxstaffnumber') != 0) {
            int maxNum = dayMap[pos];
            maxStaffNum += maxNum;
            var staffsSnap = await dayDoc.reference.collection(pos).get();
            List<String> listStaffInPos = [];

            for (var staffDoc in staffsSnap.docs) {
              listStaffInPos.add(staffDoc.id);
            }

            PositionAutoSchedule positionAutoSchedule =
                staffData.getPosition(pos);
            int currentNum = staffsSnap.docs.length;
            currentNumberOfStaff += currentNum;
            if (positionAutoSchedule.listStaff!.length != 0) {
              positionAutoSchedule.checkAdd(listStaffInPos, shiftTime);
              for (int i = currentNum; i < maxNum; i++) {
                StaffAutoSchedule staffAutoSchedule = positionAutoSchedule
                    .getStaff(shiftTime, startTime, endTime, dayDoc.id);
                if (autoSchedudling < 90) autoSchedudling++;
                if (staffAutoSchedule.staffRef != null) {
                  dayDoc.reference
                      .collection(pos)
                      .doc(staffAutoSchedule.id)
                      .set({'staff': staffAutoSchedule.staffRef});
                  print(
                      'Da them nhan vien ten: ${staffAutoSchedule.name}; co tong so gio lam la ${staffAutoSchedule.timeOfShifts}; co luong la ${staffAutoSchedule.salary}');
                  currentNumberOfStaff += 1;
                }
              }
            }
            positionAutoSchedule.refreshStaff();
          }
        } //listKey

        dayDoc.reference.update({
          'maxstaffnumber': maxStaffNum,
          'staffnumber': currentNumberOfStaff
        });
      } // listDays
      refreshSchedule(shift.id);
    } // listShift
    if (autoSchedudling < 90) autoSchedudling += 5;
    autoSchedudling = 100;
    print('Da thuc hien xong ham');
  }

  Future<Null> getWorkTimeData() async {
    // thuc hien lay ve danh sach ca truc cua tuan truoc
    coppyPercent = 3;
    var shiftsSnap = await _firestore
        .collection('worktime')
        .doc(DateTimeHelpers.dateTimeToDate(monOfLastWeek))
        .collection('shifts')
        .get();
    coppyPercent = 4;
    List<ShiftWorktime> listShift = [];
    // voi moi ca truc cua tuan truoc
    for (var shiftDoc in shiftsSnap.docs) {
      // thuc hien lay du lieu cua ca truc
      List<WorkdayWorktime> listWorkday = [];
      var shiftMap = shiftDoc.data() as Map<String, dynamic>;
      String shiftName = shiftMap['name'];
      Timestamp timeStart = shiftMap['timestart'];
      Timestamp timeEnd = shiftMap['timeend'];
      // ket thuc lay du lieu

      // Lay du lieu ve cac ngay trong ca truc
      var workdaysSnap = await shiftDoc.reference.collection('workdays').get();
      // doi voi moi ngay trong ca truc
      for (var workdayDoc in workdaysSnap.docs) {
        String workdayId = workdayDoc.id;
        var workdayMap = workdayDoc.data() as Map<String, dynamic>;
        List<PositionWorktime> listPostion = [];
        for (var position in workdayMap.keys) {
          if (position.compareTo('staffnumber') != 0 &&
              position.compareTo('maxstaffnumber') != 0) {
            var staffsSnap =
                await workdayDoc.reference.collection(position).get();
            List<StaffWorktime> listStaff = [];
            for (var staffDoc in staffsSnap.docs) {
              var staffMap = staffDoc.data() as Map<String, dynamic>;
              if (staffMap.containsKey('useradd')) {
                DocumentReference staffRef = staffMap['staff'];
                String staffId = staffDoc.id;
                StaffWorktime newStaff = new StaffWorktime(staffId, staffRef);
                listStaff.add(newStaff);
              }
              if (coppyPercent < 70) coppyPercent++;
            }
            PositionWorktime newPosition =
                new PositionWorktime(position, workdayMap[position], listStaff);
            listPostion.add(newPosition);
            if (coppyPercent < 70) coppyPercent++;
          }
        } //Moi tu khoa trong ca truc
        WorkdayWorktime newWorkday =
            new WorkdayWorktime(workdayId, listPostion);
        listWorkday.add(newWorkday);
      } // voi moi ngay trong tuan
      ShiftWorktime newShift =
          new ShiftWorktime(shiftName, timeStart, timeEnd, listWorkday);
      listShift.add(newShift);
    } // voi moi  ca truc
    worktime = new Worktime(listShift);
    // in ra mang hinh de kiem tra
    /* print(listShift.length);
    for (var shift in worktime.listShift!) {
      print('ten ca truc: ${shift.name!}; gio bat dau: ' +
          shift.timeStart.toString() +
          '; gio ket thuc: ' +
          shift.timeEnd.toString());
      for (var workday in shift.listWorkday!) {
        print(workday.id!);
        print('so luong nhan vien toi da trong ca: ' +
            workday.maxNumber.toString());
        for (var position in workday.listPositon!) {
          print(position.name! + ':' + position.number.toString());
        }
      }
    }
    print('da thuc hien xong ham');*/
  }

  Future<Null> coppyShiftOfLastWeek() async {
    isLoadShifts = true;
    isChangeDay = false;
    coppyPercent = 0;
    await getWorkTimeData();
    for (var shift in worktime.listShift!) {
      Map<String, dynamic> shiftData = {
        'name': shift.name,
        'timestart': shift.timeStart,
        'timeend': shift.timeEnd
      };
      String shiftId = '';
      // up ca truc len firebase
      await _firestore
          .collection('worktime')
          .doc(DateTimeHelpers.dateTimeToDate(monOfWeek))
          .collection('shifts')
          .add(shiftData)
          .then((value) async {
        for (var workday in shift.listWorkday!) {
          shiftId = value.id;
          await _firestore
              .collection('worktime')
              .doc(DateTimeHelpers.dateTimeToDate(monOfWeek))
              .collection('shifts')
              .doc(value.id)
              .collection('workdays')
              .doc(workday.id)
              .set(workday.toData())
              .then((value) async {
            for (var position in workday.listPositon!) {
              for (var staff in position.listStaff!) {
                await _firestore
                    .collection('worktime')
                    .doc(DateTimeHelpers.dateTimeToDate(monOfWeek))
                    .collection('shifts')
                    .doc(shiftId)
                    .collection('workdays')
                    .doc(workday.id)
                    .collection(position.name!)
                    .doc(staff.id!)
                    .set({'staff': staff.staffRef, 'useradd': 1});
                if (coppyPercent < 95) coppyPercent++;
              }
              if (coppyPercent < 95) coppyPercent++;
            }
          });
        }
      });
    }
    coppyPercent = 100;
    isLoadShifts = false;
    changeProcess();
    isChangeDay = true;
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
