import 'package:flutter/cupertino.dart';

class Data {
  final String? name;

  final double? percent;

  final Color? color;

  Data({this.name, this.percent, this.color});
}

class TableData {
  final String? name;
  final int? revenue;
  TableData({this.name, this.revenue});
}
