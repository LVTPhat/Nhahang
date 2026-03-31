import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sora_manager/app/data/helper/datetime_helpers.dart';

class AutoSchedule {
  List<PositionAutoSchedule>? listPosition;
  AutoSchedule(List<PositionAutoSchedule> positions) {
    listPosition = positions;
  }
  PositionAutoSchedule getPosition(String name) {
    List<StaffAutoSchedule> staffs = [];
    PositionAutoSchedule temp = new PositionAutoSchedule(name, staffs);
    for (var pos in listPosition!) {
      if (pos.name!.compareTo(name) == 0) {
        temp = pos;
      }
    }
    return temp;
  }
}

class PositionAutoSchedule {
  String? name;
  List<StaffAutoSchedule>? listStaff;
  PositionAutoSchedule(String na, List<StaffAutoSchedule> staffs) {
    name = na;
    listStaff = staffs;
  }
  StaffAutoSchedule getStaff(int time, Timestamp shiftTimeStart,
      Timestamp shiftTimeEnd, String workday) {
    List<String> listTemp = [];
    // ignore: unnecessary_new
    StaffAutoSchedule temp =
        new StaffAutoSchedule('isnull', 'thien', 999999999, 0, 0, listTemp);
    temp.addTimeWork(999999999);
    for (var staff in listStaff!) {
      if (staff.checkStaff(shiftTimeStart, shiftTimeEnd, workday)) {
        if (staff.timeOfShifts < temp.timeOfShifts && !staff.isAdd) {
          temp = staff;
        } else {
          if (staff.timeOfShifts == temp.timeOfShifts) {
            if (staff.salary! < temp.salary! && !staff.isAdd) {
              temp = staff;
              print(
                  'Do hai nhan vien gio lam bang nhau nen chon ${staff.name}');
            }
          }
        }
      }
    }
    temp.addTimeWork(time);
    temp.isAdd = true;
    return temp;
  }

  refreshStaff() {
    for (var staff in listStaff!) {
      staff.isAdd = false;
    }
  }

  checkAdd(List<String> staffs, int shiftTime) {
    for (var staff in listStaff!) {
      for (var id in staffs) {
        if (id.compareTo(staff.id!) == 0) {
          staff.isAdd = true;
          staff.timeOfShifts += shiftTime;
        }
      }
    }
  }
}

class StaffAutoSchedule {
  String? id, name;
  DocumentReference? staffRef;
  int? salary;
  int timeOfShifts = 0;
  bool isAdd = false;
  int? canTimeStart, mustTimeEnd;
  List<String>? listWorkday;

  StaffAutoSchedule(String i, String na, int sa, int startTime, int endTime,
      List<String> workdays) {
    id = i;
    salary = sa;
    name = na;
    canTimeStart = startTime;
    mustTimeEnd = endTime;
    listWorkday = workdays;
  }

  bool checkStaff(
      Timestamp timeShiftStart, Timestamp timeShiftEnd, String workday) {
    if (canTimeStart == null) {
      // thoi gian bat dau luc nao cung duoc khong can xet nua
      if (mustTimeEnd == null) {
        // thoi gian ket thuc luc nao cung duoc khong can xet
        if (listWorkday!.length == 0) {
          // la ngay nao cung duoc khong can xe nua
          return true;
        } else {
          // phai kiem tra xe ngay lam viec co trong ngay dang ky khong
          for (var day in listWorkday!) {
            if (day.compareTo(workday) == 0) {
              return true;
            }
          }
          return false;
        }
      } else {
        // kiem tra lai thoi gian ket thuc cua nhan vien phai lon hon thoi gian ket thuc cua ca truc
        if (mustTimeEnd! >= getTime(timeShiftEnd)) {
          // thoi gian cua ca truc hop le roi
          if (listWorkday!.length == 0) {
            // la ngay nao cung duoc khong can xe nua
            return true;
          } else {
            // phai kiem tra xe ngay lam viec co trong ngay dang ky khong
            for (var day in listWorkday!) {
              if (day.compareTo(workday) == 0) {
                return true;
              }
            }
            return false;
          }
        } else {
          // chua du dieu kien gio phai tan ca
          return false;
        }
      }
    } else {
      // chi co the bat dau khi thoi gian cua nha vien nho hon thoi gian cua ca truc
      if (canTimeStart! <= getTime(timeShiftStart)) {
        // thoi gian bat dau phu hop voi dieu kien roi
        if (mustTimeEnd == null) {
          // thoi gian ket thuc luc nao cung duoc khong can xet
          if (listWorkday!.length == 0) {
            // la ngay nao cung duoc khong can xe nua
            return true;
          } else {
            // phai kiem tra xe ngay lam viec co trong ngay dang ky khong
            for (var day in listWorkday!) {
              if (day.compareTo(workday) == 0) {
                return true;
              }
            }
            return false;
          }
        } else {
          // kiem tra lai thoi gian ket thuc cua nhan vien phai lon hon thoi gian ket thuc cua ca truc
          if (mustTimeEnd! >= getTime(timeShiftEnd)) {
            // thoi gian cua ca truc hop le roi
            if (listWorkday!.length == 0) {
              // la ngay nao cung duoc khong can xe nua
              return true;
            } else {
              // phai kiem tra xe ngay lam viec co trong ngay dang ky khong
              for (var day in listWorkday!) {
                if (day.compareTo(workday) == 0) {
                  return true;
                }
              }
              return false;
            }
          } else {
            // chua du dieu kien gio phai tan ca
            return false;
          }
        }
      } else {
        return false;
      }
    }
  }

  int getTime(Timestamp timestamp) {
    String time = DateTimeHelpers.timestampsToTime(timestamp);
    int hour = int.parse(time.substring(0, 2));
    int min = int.parse(time.substring(3));
    return hour * 60 + min;
  }

  addTimeWork(int time) {
    timeOfShifts += time;
  }

  int getTimeWork() => timeOfShifts;
  bool expensiveThan(int otherSalary) => salary! > otherSalary;
  int getSalary() => salary!;
}
