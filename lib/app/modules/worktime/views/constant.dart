import 'package:flutter/material.dart';
import 'package:sora_manager/app/data/services/size.dart';
import 'package:sora_manager/app/modules/worktime/views/components/workday_detail.dart';
import 'package:sora_manager/common/constant.dart';

final bgColorOfRate = Colors.grey[300];
final fgColorOfRate = primaryColor;

final styleOfTitle = TextStyle(
  color: primaryColor,
  fontSize: Resize.getSizeChar(18),
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w600,
);

final styleOfHint = TextStyle(
  color: violet3,
  fontSize: Resize.getSizeChar(18),
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w600,
);

final normalText = TextStyle(
  color: Colors.grey[700],
  fontSize: Resize.getSizeChar(16),
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
  borderRadius: BorderRadius.circular(30),
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
  fontSize: Resize.getSizeChar(16),
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w300,
);

final TextStyle txtButtonStyle = TextStyle(
  color: Colors.white,
  fontSize: Resize.getSizeChar(20),
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
  fontSize: Resize.getSizeChar(20),
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w300,
);

final TextStyle txtOfInsertContent = TextStyle(
    color: Color.fromARGB(255, 36, 36, 36),
    fontSize: Resize.getSizeChar(23),
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400);
final btnStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(keyOrHintColor),
);

// rang buoc cua lich

final boderOfWeekdays = Border(
  left: BorderSide(
    //
    color: violet7,
    width: 1,
  ),
  top: BorderSide(
    //
    color: violet7,
    width: 1,
  ),
  bottom: BorderSide(
    color: violet7,
    width: 1,
  ),
);

final boderOfLastWeeKdays = Border(
  left: BorderSide(
    //
    color: violet7,
    width: 1,
  ),
  top: BorderSide(
    //
    color: violet7,
    width: 1,
  ),
  bottom: BorderSide(
    color: violet7,
    width: 1,
  ),
  right: BorderSide(
    color: violet7,
    width: 1,
  ),
);

final boderOfShift = Border(
  left: BorderSide(
    //
    color: violet7,
    width: 1,
  ),
  bottom: BorderSide(
    color: violet7,
    width: 1,
  ),
);

final boderOfLastShift = Border(
  left: BorderSide(
    //
    color: violet7,
    width: 1,
  ),
  bottom: BorderSide(
    color: violet7,
    width: 1,
  ),
  right: BorderSide(
    color: violet7,
    width: 1,
  ),
);

final styleOfShiftCard = BoxDecoration(
    color: Colors.transparent,
    border: Border(
        bottom: BorderSide(
      color: violet7,
      width: 1,
    )));

final boderLast = BorderRadius.only(topRight: Radius.circular(10));

final boderOfFirst = BoxDecoration(border: boderOfWeekdays);

final boderOfLast =
    BoxDecoration(border: boderOfLastWeeKdays, borderRadius: boderLast);
final boderOfNormal = BoxDecoration(
  border: boderOfWeekdays,
);

final scheduleStyle = BoxDecoration(
  color: Colors.green[50],
  borderRadius: BorderRadius.circular(10),
  boxShadow: [
    BoxShadow(
      offset: Offset(0, 5),
      blurRadius: 10,
      color: Colors.grey.withOpacity(0.3),
    ),
  ],
);

// text of schedule

final textDay = TextStyle(
    fontSize: Resize.getSizeChar(24),
    fontWeight: FontWeight.w600,
    color: violet7);

final textDayOfWeek = TextStyle(
    fontSize: Resize.getSizeChar(18),
    fontWeight: FontWeight.w500,
    color: violet7);

final nameShift = TextStyle(
    fontSize: Resize.getSizeChar(22),
    fontWeight: FontWeight.w500,
    color: violet7);
final infoShift = TextStyle(
    fontSize: Resize.getSizeChar(18),
    fontWeight: FontWeight.w300,
    color: violet7);
// phan chen them ca lam viec

final insertDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
      topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
  boxShadow: [
    BoxShadow(
      offset: Offset(0, 5),
      blurRadius: 10,
      color: Color.fromARGB(255, 119, 118, 118).withOpacity(0.3),
    ),
  ],
);

final titleInsert = TextStyle(
  color: violet7,
  fontSize: Resize.getSizeChar(25),
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
);

final contentKey = TextStyle(
  color: violet7,
  fontSize: Resize.getSizeChar(20),
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
);

final titleContent = TextStyle(
  color: violet7,
  fontSize: Resize.getSizeChar(23),
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

final posNameStyle = TextStyle(
  color: violet7,
  fontSize: Resize.getSizeChar(20),
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w600,
);

final errorStyle = TextStyle(
  color: Colors.red,
  fontSize: Resize.getSizeChar(14),
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w300,
);

final workdayBottomStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
      topRight: Radius.circular(15), topLeft: Radius.circular(15)),
  boxShadow: [
    BoxShadow(
      offset: Offset(0, 5),
      blurRadius: 10,
      color: Color.fromARGB(255, 119, 118, 118).withOpacity(0.3),
    ),
  ],
);

final choosedStyle = BoxDecoration(
  color: blue2,
  borderRadius: BorderRadius.circular(30),
  border: Border.all(color: blue4),
  boxShadow: [
    BoxShadow(
      offset: Offset(0, 5),
      blurRadius: 5,
      color: blue7.withOpacity(0.3),
    ),
  ],
);

final unChoosedStyle = BoxDecoration(
  color: blue1,
  borderRadius: BorderRadius.circular(30),
  boxShadow: [
    BoxShadow(
      offset: Offset(0, 5),
      blurRadius: 5,
      color: blue7.withOpacity(0.3),
    ),
  ],
);

final styleInSchedule = TextStyle(
  color: violet7,
  fontSize: Resize.getSizeChar(18),
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w300,
);

final btnDecoration = BoxDecoration(
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

final buttonTitleStyle = TextStyle(
  color: violet7,
  fontSize: Resize.getSizeChar(19),
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w500,
);

final buttonContentStyle = TextStyle(
  color: violet4,
  fontSize: Resize.getSizeChar(15),
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w300,
);
final inforText = TextStyle(
  color: violet7,
  fontSize: Resize.getSizeChar(16),
  fontFamily: 'Roboto',
);

final dateTimeText = TextStyle(
  color: violet7,
  fontSize: Resize.getSizeChar(16),
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

final scheduleCardStyle = BoxDecoration(
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

final customBtnStyle = BoxDecoration(
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
      violet1,
      blue1,
    ],
  ),
);

final wdayStyle = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: [
      0.1,
      0.4,
      0.6,
    ],
    colors: [
      blue1,
      violet1,
      pink1,
    ],
  ),
  boxShadow: [
    BoxShadow(
      offset: Offset(0, 5),
      blurRadius: 10,
      color: violet7.withOpacity(0.3),
    ),
  ],
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

final styleOfName = TextStyle(
  color: primaryColor,
  fontSize: Resize.getSizeChar(18),
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w600,
);

final styleOfInfor = TextStyle(
  color: violet7,
  fontSize: Resize.getSizeChar(18),
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w500,
);
