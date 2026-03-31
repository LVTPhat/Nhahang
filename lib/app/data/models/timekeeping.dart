class Timekeeping {
  List<PositionTimekeeping> listPositionTimekeeping = [];
  Timekeeping(List<PositionTimekeeping> listPTK) {
    listPositionTimekeeping = listPTK;
  }
}

class PositionTimekeeping {
  String name = '';
  List<StaffTimekeeping> listStaffTimekeeping = [];
  PositionTimekeeping(String na, List<StaffTimekeeping> listSTK) {
    listStaffTimekeeping = listSTK;
    name = na;
  }
}

class StaffTimekeeping {
  String name = '', id = '';
  List<DayTimekeeping> listDayTimekeeping = [];
  StaffTimekeeping(String na, String i, List<DayTimekeeping> listDTK) {
    name = na;
    listDayTimekeeping = listDTK;
    id = i;
  }
}

class DayTimekeeping {
  String name = '';
  int totalTime = 0;
  int totalSalary = 0;
  DayTimekeeping(int tTime, int tSalary, String na) {
    totalSalary = tSalary;
    totalTime = tTime;
    name = na;
  }
}
