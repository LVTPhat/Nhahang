import 'package:flutter/material.dart';
import 'package:sora_manager/common/constant.dart';

final bgColorOfRate = Colors.grey[300];
final fgColorOfRate = primaryColor;

final styleOfTitle = TextStyle(
  color: primaryColor,
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
  color: Colors.grey[700],
  fontSize: 16,
  fontFamily: 'Roboto',
);

final textFeildBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(color: pink1));

final cardStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(30),
  boxShadow: [
    BoxShadow(
      offset: Offset(0, 5),
      blurRadius: 10,
      color: Colors.grey.withOpacity(0.3),
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
      color: violet7.withOpacity(0.3),
    ),
  ],
);
final TextStyle txtStyle = TextStyle(
  color: Color.fromARGB(255, 48, 48, 48),
  fontSize: 16,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w300,
);

final TextStyle txtButtonStyle = TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w300,
);

final bottomSheetStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
      topRight: Radius.circular(30), topLeft: Radius.circular(30)),
  boxShadow: [
    BoxShadow(
      offset: Offset(0, 5),
      blurRadius: 10,
      color: Color.fromARGB(255, 119, 118, 118).withOpacity(0.3),
    ),
  ],
);

final TextStyle txtDropDownStyle = TextStyle(
  color: Colors.black,
  fontSize: 20,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w300,
);

final TextStyle txtOfInsertContent = TextStyle(
    color: Color.fromARGB(255, 36, 36, 36),
    fontSize: 23,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400);
final btnStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(keyOrHintColor),
);
// Kieu chu tren the nhan vien

final styleOfName = TextStyle(
  color: primaryColor,
  fontSize: 18,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w600,
);

final styleOfInfor = TextStyle(
  color: violet7,
  fontSize: 18,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w500,
);

// rang buoc cua current staff

final nameText = TextStyle(
  color: primaryColor,
  fontSize: 22,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w600,
);

final informationText = TextStyle(
  color: primaryColor,
  fontSize: 19,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w500,
);

final keyText = TextStyle(
  color: violet4,
  fontSize: 19,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w500,
);

InputDecoration _buildDecorationTextFormField(
    {required String hintText, required IconData icon}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 10),
    hintText: hintText,
    focusColor: primaryColor,
    prefixIcon: Icon(
      icon,
      color: primaryColor,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: primaryColor,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: primaryColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: secondaryColor),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: secondaryColor),
    ),
  );
}

final contentKey = TextStyle(
  color: violet7,
  fontSize: 20,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
);

final btnTinmeStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(blue1),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(color: primaryColor))));
final wdCardStyle = BoxDecoration(
  color: blue1,
  borderRadius: BorderRadius.circular(10),
  boxShadow: [
    BoxShadow(
      offset: Offset(0, 5),
      blurRadius: 5,
      color: blue7.withOpacity(0.3),
    ),
  ],
);

final wdCardStyleInChoosed = BoxDecoration(
  color: blue2,
  borderRadius: BorderRadius.circular(10),
  boxShadow: [
    BoxShadow(
      offset: Offset(0, 5),
      blurRadius: 5,
      color: blue7.withOpacity(0.3),
    ),
  ],
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

final staffCardStyle = BoxDecoration(
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

final inforText = TextStyle(
  color: violet7,
  // fontSize: 16,
  fontFamily: 'Roboto',
);

final dateTimeText = TextStyle(
  color: violet7,
  fontSize: 16,
  fontFamily: 'Roboto',
);
