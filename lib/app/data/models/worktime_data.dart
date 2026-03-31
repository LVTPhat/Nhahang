import 'package:cloud_firestore/cloud_firestore.dart';

class Worktime {
  List<ShiftWorktime>? listShift;
  Worktime(List<ShiftWorktime> shifts) {
    listShift = shifts;
  }
}

class ShiftWorktime {
  String? name;
  Timestamp? timeStart, timeEnd;
  List<WorkdayWorktime>? listWorkday;
  ShiftWorktime(String na, Timestamp start, Timestamp end,
      List<WorkdayWorktime> workdays) {
    name = na;
    timeStart = start;
    timeEnd = end;
    listWorkday = workdays;
  }
}

class WorkdayWorktime {
  String? id;
  int maxNumber = 0, currentNumber = 0;
  List<PositionWorktime>? listPositon;
  WorkdayWorktime(String i, List<PositionWorktime> positions) {
    id = i;
    listPositon = positions;
    getMaxNumber();
  }
  getMaxNumber() {
    for (var position in listPositon!) {
      maxNumber += position.number!;
      currentNumber += position.listStaff!.length;
    }
  }

  Map<String, dynamic> toData() {
    Map<String, dynamic> dataWorkday = new Map<String, dynamic>();
    for (var element in listPositon!) {
      dataWorkday[element.name!] = element.number!;
    }
    dataWorkday['maxstaffnumber'] = maxNumber;
    dataWorkday['staffnumber'] = currentNumber;
    return dataWorkday;
  }
}

class PositionWorktime {
  String? name;
  int? number;
  List<StaffWorktime>? listStaff;
  PositionWorktime(String na, int num, List<StaffWorktime> staffs) {
    name = na;
    number = num;
    listStaff = staffs;
  }
}

class StaffWorktime {
  String? id;
  DocumentReference? staffRef;
  StaffWorktime(String i, DocumentReference ref) {
    id = i;
    staffRef = ref;
  }
}
