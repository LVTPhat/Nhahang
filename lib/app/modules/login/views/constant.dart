import 'package:flutter/cupertino.dart';
import 'package:sora_manager/app/data/services/size.dart';
import 'package:sora_manager/common/constant.dart';

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

final loginStyle = BoxDecoration(
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
  borderRadius: BorderRadius.circular(10),
  boxShadow: [
    BoxShadow(
      offset: Offset(0, 5),
      blurRadius: 10,
      color: blue7.withOpacity(0.3),
    ),
  ],
);

final styleOfTitle = TextStyle(
  color: violet7,
  fontSize: Resize.getSizeChar(18),
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w600,
);
