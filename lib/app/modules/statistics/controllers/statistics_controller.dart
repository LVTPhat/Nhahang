import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sora_manager/app/modules/statistics/controllers/data.dart';
import 'package:sora_manager/common/constant.dart';

class StatisticsController extends GetxController {
  final _firebase = FirebaseFirestore.instance;
  int maxDay = 0, totalRevenue = 0;
  late TableData maxRevenueTable;

  RxList<FlSpot> _flspotList = new List<FlSpot>.empty(growable: true).obs;
  List<FlSpot> get flspotList => _flspotList.value;
  set flspotList(value) => _flspotList.value = value;

  RxList<Data> _listData = new List<Data>.empty(growable: true).obs;
  List<Data> get listData => _listData.value;
  set listData(value) => _listData.value = value;

  RxList<String> _yearList = new List<String>.empty(growable: true).obs;
  List<String> get yearList => _yearList.value;
  set yearList(value) => _yearList.value = value;

  RxList<String> _monthList = new List<String>.empty(growable: true).obs;
  List<String> get monthList => _monthList.value;
  set monthList(value) => _monthList.value = value;

  RxList<TableData> _tableList = new List<TableData>.empty(growable: true).obs;
  List<TableData> get tableList => _tableList.value;
  set tableList(value) => _tableList.value = value;

  RxList<FlSpot> _spotOfYearList = new List<FlSpot>.empty(growable: true).obs;
  List<FlSpot> get spotOfYearList => _spotOfYearList.value;
  set spotOfYearList(value) => _spotOfYearList.value = value;

  Rx<int> _minRevenue = 0.obs;
  int get minRevenue => _minRevenue.value;
  set minRevenue(value) => _minRevenue.value = value;

  Rx<String> _yearChoosed = DateTime.now().year.toString().obs;
  String get yearChoosed => _yearChoosed.value;
  set yearChoosed(value) => _yearChoosed.value = value;

  Rx<String> _monthChoosed = 'Tất cả'.obs;
  String get monthChoosed => _monthChoosed.value;
  set monthChoosed(value) => _monthChoosed.value = value;

  Rx<int> _maxRevenue = 0.obs;
  int get maxRevenue => _maxRevenue.value;
  set maxRevenue(value) => _maxRevenue.value = value;

  Rx<int> _maxRevenueOfYear = 0.obs;
  int get maxRevenueOfYear => _maxRevenueOfYear.value;
  set maxRevenueOfYear(value) => _maxRevenueOfYear.value = value;

  Rx<int> _minRevenueOfYear = 0.obs;
  int get minRevenueOfYear => _minRevenueOfYear.value;
  set minRevenueOfYear(value) => _minRevenueOfYear.value = value;

  Rx<bool> _isLoadChartOfYear = true.obs;
  bool get isLoadChartOfYear => _isLoadChartOfYear.value;
  set isLoadChartOfYear(value) => _isLoadChartOfYear.value = value;

  Rx<bool> _isLoadingChartData = true.obs;
  bool get isLoadingChartData => _isLoadingChartData.value;
  set isLoadingChartData(value) => _isLoadingChartData.value = value;

  Rx<bool> _isLoadTableList = true.obs;
  bool get isLoadTableList => _isLoadTableList.value;
  set isLoadTableList(value) => _isLoadTableList.value = value;

  Future<Null> getChartData(int month, int year) async {
    String yearId = 'statistics-year' + year.toString();
    String monthId = 'statistics-month' + month.toString();
    isLoadingChartData = true;
    minRevenue = 9999999999999;
    maxRevenue = -99999999999999;
    List<FlSpot> spots = [];
    var staSnap = await _firebase
        .collection('statistics')
        .doc(yearId)
        .collection('months')
        .doc(monthId)
        .collection('days')
        .get();
    for (var doc in staSnap.docs) {
      String temp = doc.id;
      int x = int.parse(temp.substring(14));
      var map = doc.data() as Map<String, dynamic>;
      int y = map['totalrevenue'];
      if (y.toDouble() / 1000000 > maxRevenue)
        maxRevenue = (y.toDouble() / 1000000).toInt();
      if (y.toDouble() / 1000000 < minRevenue)
        minRevenue = (y.toDouble() / 1000000).toInt();
      FlSpot newFlSpot = FlSpot(x.toDouble(), y.toDouble() / 1000000);
      spots.add(newFlSpot);
    }
    for (int i = 0; i < spots.length - 1; i++) {
      for (int j = i + 1; j < spots.length; j++) {
        if (spots[j].x < spots[i].x) {
          FlSpot temp = spots[i];
          spots[i] = spots[j];
          spots[j] = temp;
        }
      }
    }
    flspotList = spots;
    minRevenue -= 10;
    maxRevenue += 10;
    isLoadingChartData = false;
    maxDay = getMaxDay(month, year);
  }

  Future<Null> getYearData(int year) async {
    isLoadChartOfYear = true;
    minRevenueOfYear = 9999999999999;
    maxRevenueOfYear = -99999999999999;
    List<FlSpot> spots = [];
    String yearId = 'statistics-year' + year.toString();
    var yearSnap = await _firebase
        .collection('statistics')
        .doc(yearId)
        .collection('months')
        .get();
    for (var monthDoc in yearSnap.docs) {
      String temp = monthDoc.id;
      var map = monthDoc.data() as Map<String, dynamic>;
      int x = int.parse(temp.substring(16));
      int y = map['totalrevenue'];
      FlSpot newSpot = FlSpot(x.toDouble(), y.toDouble() / 1000000);
      if (y.toDouble() / 1000000 > maxRevenueOfYear)
        maxRevenueOfYear = (y.toDouble() / 1000000).toInt();
      if (y.toDouble() / 1000000 < minRevenueOfYear)
        minRevenueOfYear = (y.toDouble() / 1000000).toInt();
      spots.add(newSpot);
    }
    for (int i = 0; i < spots.length - 1; i++) {
      for (int j = i + 1; j < spots.length; j++) {
        if (spots[j].x < spots[i].x) {
          FlSpot temp = spots[i];
          spots[i] = spots[j];
          spots[j] = temp;
        }
      }
    }
    minRevenueOfYear -= 100;
    maxRevenueOfYear += 100;
    spotOfYearList = spots;
    isLoadChartOfYear = false;
  }

  Future<Null> getYearList() async {
    List<String> years = [];
    var yearSnap = await _firebase.collection('statistics').get();
    for (var doc in yearSnap.docs) {
      String temp = doc.id;
      String year = temp.substring(15);
      years.add(year);
    }
    yearList = years;
  }

  initMonthList() {
    getMonthList(yearChoosed);
  }

  Future<Null> getMonthList(String year) async {
    String yearId = 'statistics-year' + year;
    List<String> months = [];
    months.add('Tất cả');
    var monthSnap = await _firebase
        .collection('statistics')
        .doc(yearId)
        .collection('months')
        .get();
    for (var doc in monthSnap.docs) {
      String temp = doc.id;
      String month = 'Tháng ' + temp.substring(16);
      months.add(month);
    }
    for (int i = 1; i < months.length - 1; i++) {
      for (int j = i + 1; j < months.length; j++) {
        if (int.parse(months[j].substring(6)) <
            int.parse(months[i].substring(6))) {
          String temp = months[i];
          months[i] = months[j];
          months[j] = temp;
        }
      }
    }
    monthList = months;
    monthChoosed = 'Tất cả';
  }

  int getMaxDay(int month, int year) {
    switch (month) {
      case 1:
        return 31;
      case 3:
        return 31;
      case 4:
        return 30;
      case 5:
        return 31;
      case 6:
        return 30;
      case 7:
        return 31;
      case 8:
        return 31;
      case 9:
        return 30;
      case 10:
        return 31;
      case 11:
        return 30;
      case 12:
        return 31;
      default:
        return ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0))
            ? 29
            : 28;
    }
  }

  Future<Null> createData() async {
    for (int i = 4; i <= 4; i++) {
      String monthId = 'statistics-month' + i.toString();
      int totalmonth = 0;
      for (int j = 1; j <= 5; j++) {
        String dayId = 'statistics-day' + j.toString();
        int total = 0;
        for (int k = 0; k <= 10; k++) {
          String name = 'Bàn ' + k.toString();
          Random random = new Random();
          int randomNumber = random.nextInt(20) + 20;
          int revenue = randomNumber * 100000;
          total += revenue;
          await _firebase
              .collection('statistics')
              .doc('statistics-year2022')
              .collection('months')
              .doc(monthId)
              .collection('days')
              .doc(dayId)
              .collection('tables')
              .add({'name': name, 'revenue': revenue});
        }
        await _firebase
            .collection('statistics')
            .doc('statistics-year2022')
            .collection('months')
            .doc(monthId)
            .collection('days')
            .doc(dayId)
            .set({'totalrevenue': total});
        totalmonth += total;
      }
      await _firebase
          .collection('statistics')
          .doc('statistics-year2022')
          .collection('months')
          .doc(monthId)
          .set({'totalrevenue': totalmonth});
    }
  }

  Future<Null> getTableList(int day, int month, int year) async {
    isLoadTableList = true;
    int maxReveue = 0;
    totalRevenue = 0;
    String dayId = 'statistics-day' + day.toString();
    String monthId = 'statistics-month' + month.toString();
    String yearId = 'statistics-year' + year.toString();
    List<TableData> tables = [];
    var tableSnap = await _firebase
        .collection('statistics')
        .doc(yearId)
        .collection('months')
        .doc(monthId)
        .collection('days')
        .doc(dayId)
        .collection('tables')
        .get();
    for (var tableDoc in tableSnap.docs) {
      var tableMap = tableDoc.data() as Map<String, dynamic>;
      String tableName = tableMap['name'];
      int tableRevenue = tableMap['revenue'];
      TableData newTable = TableData(name: tableName, revenue: tableRevenue);
      if (maxRevenue <= tableRevenue) {
        maxRevenueTable = newTable;
      }
      totalRevenue += tableRevenue;
      tables.add(newTable);
    }
    tableList = tables;
    isLoadTableList = false;
    if (!tableList.isEmpty) {
      getDataTable(tableList[0]);
    }
  }

  Future<Null> getDataTable(TableData table) async {
    print('Co goi ham get data table ');
    double currentTablePercent = table.revenue!.toDouble() / totalRevenue * 100;
    double maxRevenuePercent =
        maxRevenueTable.revenue!.toDouble() / totalRevenue * 100;
    double othersPercent = 100 - currentTablePercent - maxRevenuePercent;
    List<Data> datas = [
      Data(name: table.name, percent: currentTablePercent, color: blue5),
      Data(
          name: maxRevenueTable.name,
          percent: maxRevenuePercent,
          color: violet5),
      Data(name: 'Còn lại', percent: othersPercent, color: pink5)
    ];
    listData = datas;
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
