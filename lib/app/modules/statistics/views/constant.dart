import 'package:flutter/material.dart';
import 'package:sora_manager/common/constant.dart';

final textInChart = TextStyle(
  color: primaryColor,
  fontSize: 18,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
);

final chartStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10),
  boxShadow: [
    BoxShadow(
      offset: Offset(0, 5),
      blurRadius: 10,
      color: Colors.grey.withOpacity(0.3),
    ),
  ],
);

final textTitleChart = TextStyle(
  color: primaryColor,
  fontSize: 22,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w500,
);

final informationText = TextStyle(
  color: primaryColor,
  fontSize: 19,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w500,
);

final keyTextStyle = TextStyle(
  color: violet4,
  fontSize: 20,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
);

final tableName = TextStyle(
  color: violet7,
  fontSize: 20,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
);

final revenueStyle = TextStyle(
  color: violet7,
  fontSize: 20,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w500,
);

final noteStyle = TextStyle(
  color: violet4,
  fontSize: 16,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w500,
);
