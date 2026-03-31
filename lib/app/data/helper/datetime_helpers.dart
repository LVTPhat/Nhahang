import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeHelpers {
  static String timestampsToDate(Timestamp timestamp) {
    var datetime = DateTime.fromMicrosecondsSinceEpoch(
        timestamp.microsecondsSinceEpoch,
        isUtc: false);
    return DateFormat('dd-MM-yyyy').format(datetime);
  }

  static DateTime timestampsToDateTime(Timestamp timestamp) {
    return DateTime.fromMicrosecondsSinceEpoch(
        timestamp.microsecondsSinceEpoch);
  }

  static String timestampsToTime(Timestamp timestamp) {
    var datetime =
        DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch);

    return DateFormat('HH:mm').format(datetime);
  }

  static TimeOfDay timestampToTimeOfDay(Timestamp timestamp) {
    var datetime =
        DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch);
    return TimeOfDay(hour: datetime.hour, minute: datetime.minute);
  }

  static String dateTimeToDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  static String dateTimeToTime(DateTime date) {
    return DateFormat('HH:mm').format(date).padLeft(2, '0');
  }

  static DateTime timeOfDayToDateTime(DateTime date, TimeOfDay time) {
    return new DateTime(
        date.year, date.month, date.day, time.hour, time.minute);
  }

  static Timestamp dateTimeToTimestamp(DateTime datetime) {
    return Timestamp.fromDate(datetime);
  }

  static String dateTimeToDateOfWeek(DateTime datetime) {
    String dow = DateFormat('EEE').format(datetime);
    return dow;
  }

  static bool isBeforeNow(DateTime date) {
    final now = DateTime.now();
    return date.isBefore(now);
  }

  static String getDateTimeNow() {
    String dateTime = '';
    DateTime date = DateTime.now();
    dateTime = '${date.day} Tháng ${date.month}, ${date.year}';
    return dateTime;
  }

  static String timeOfDayToTime(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  static int getTime(Timestamp timestamp) {
    String time = DateTimeHelpers.timestampsToTime(timestamp);
    int hour = int.parse(time.substring(0, 2));
    int min = int.parse(time.substring(3));
    return hour * 60 + min;
  }

  static Timestamp dateTimeNowToTimestamp() {
    DateTime datetime = DateTime.now();
    return Timestamp.fromDate(datetime);
  }
}
