import 'package:flutter/material.dart';
import 'package:sora_manager/common/constant.dart';

final bgColorOfRate = violet1;
final fgColorOfRate = violet6;

final styleOfTitle = TextStyle(
  color: violet7,
  fontSize: 18,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w600,
);

final styleOfHint = TextStyle(
  color: violet3,
  fontSize: 18,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w600,
);

final normalText = TextStyle(
  color: violet7,
  fontSize: 18,
  fontFamily: 'Roboto',
);

final textFeildBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(color: pink1));

final cardStyle = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: [
      0.1,
      0.4,
      0.6,
    ],
    colors: [
      pink2,
      violet2,
      blue1,
    ],
  ),
  //color: pink2,
  borderRadius: BorderRadius.circular(30),
  boxShadow: [
    BoxShadow(
      offset: Offset(0, 5),
      blurRadius: 10,
      color: violet7.withOpacity(0.3),
    ),
  ],
);

final searchStyle = BoxDecoration(
  color: pink1,
  borderRadius: BorderRadius.circular(100),
  boxShadow: [
    BoxShadow(
      offset: Offset(0, 5),
      blurRadius: 10,
      color: pink4.withOpacity(0.3),
    ),
  ],
);
final TextStyle txtStyle = TextStyle(
  color: blue7,
  fontSize: 16,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w300,
);

// Style of text of Notification component

final TextStyle nameInNo = TextStyle(
  color: violet7,
  fontSize: 20,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w700,
);

final TextStyle datetimeInNO = TextStyle(
    color: violet7,
    fontSize: 13,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w300,
    fontStyle: FontStyle.italic);

final TextStyle contentInNO = TextStyle(
  color: violet4,
  fontSize: 18,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w500,
);

final dateTimeText = TextStyle(
  color: violet7,
  fontSize: 16,
  fontFamily: 'Roboto',
);

final inforText = TextStyle(
  color: violet7,
  // fontSize: 16,
  fontFamily: 'Roboto',
);

final bgStyle = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: [
      0.1,
      0.4,
      0.6,
    ],
    colors: [
      pink1,
      violet1,
      blue1,
    ],
  ),
);

final tableCardStyle = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: [
      0.1,
      0.4,
      0.6,
    ],
    colors: [
      blue2,
      blue1,
      blue1,
    ],
  ),
  borderRadius: BorderRadius.circular(30),
  boxShadow: [
    BoxShadow(
      offset: Offset(0, 5),
      blurRadius: 10,
      color: blue7.withOpacity(0.3),
    ),
  ],
);

final styleOfTableName = TextStyle(
  color: violet7,
  fontSize: 18,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w600,
);
