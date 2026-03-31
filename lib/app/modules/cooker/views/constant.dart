import 'package:flutter/material.dart';
import 'package:sora_manager/common/constant.dart';

final dishCard = BoxDecoration(
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

final navbarStyle = BoxDecoration(
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
  boxShadow: [
    BoxShadow(
      offset: Offset(0, 5),
      blurRadius: 10,
      color: blue3.withOpacity(0.3),
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

final textFeildBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(color: pink1));

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

// dinh dang chua the mong an
final textTitle = TextStyle(
  color: violet7,
  fontSize: 28,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w600,
);

final textNormal = TextStyle(
  color: violet7,
  fontSize: 24,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w500,
);

final inforTxt = TextStyle(
  color: violet7,
  fontSize: 23,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
);

final bgColorOfRate = violet1;
final fgColorOfRate = violet6;

final textButton = TextStyle(
  color: Colors.white,
  fontSize: 23,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
);
