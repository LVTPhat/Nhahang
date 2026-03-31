import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  List<Position>? listPosition;
  Schedule(List<Position> positions) {
    listPosition = positions;
  }
}

class Position {
  String? name;
  List<Shift>? listShift;
  Position(String na) {
    name = na;
    listShift = [];
  }
  inserShift(Shift shift) {
    listShift!.add(shift);
  }
}

class Shift {
  String? name, id;
  Timestamp? timeStart, timeEnd;
  List<Day>? listDay;
  Shift(String na, String i, Timestamp start, Timestamp end, List<Day> days) {
    name = na;
    id = i;
    timeStart = start;
    timeEnd = end;
    listDay = days;
  }
  Shift copy() {
    List<Day> list = [];
    for (var day in this.listDay!) {
      list.add(day.copy());
    }
    return new Shift(
        this.name!, this.id!, this.timeStart!, this.timeEnd!, list);
    // return this;
  }
}

class Day {
  String? name;
  List<Staff>? listStaff;
  Day(String na, List<Staff> staffs) {
    name = na;
    listStaff = staffs;
  }
  Day copy() {
    List<Staff> list = [];
    for (var staff in this.listStaff!) {
      list.add(staff.copy());
    }
    return new Day(this.name!, list);
  }
}

class Staff {
  String? name, postion, id;
  double? salary;
  Staff(String na, int sa, String pos, String i) {
    name = na;
    salary = sa.toDouble();
    postion = pos;
    id = i;
  }
  Staff copy() {
    return new Staff(this.name!, this.salary!.toInt(), this.postion!, this.id!);
  }
}
