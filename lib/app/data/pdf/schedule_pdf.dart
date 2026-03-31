import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:sora_manager/app/data/helper/datetime_helpers.dart';
import 'package:sora_manager/app/data/models/schedule.dart';

class SchedulePdf {
  static const double inch = 72.0;
  static const double cm = inch / 2.54;
  static Future<Uint8List> generatePdf(
      PdfPageFormat format, Schedule schedule) async {
    final pdf = Document(version: PdfVersion.pdf_1_5, compress: true);
    var data = await rootBundle.load("assets/fonts/arial.ttf");
    var myFont = Font.ttf(data);

    pdf.addPage(
      MultiPage(
        pageFormat: PdfPageFormat(21.0 * cm, 29.7 * cm,
            marginTop: 2.0 * cm,
            marginBottom: 2.0 * cm,
            marginRight: 2.0 * cm,
            marginLeft: 2.0 * cm),
        build: (context) => [
          Container(
              width: double.infinity,
              child: ListView.builder(
                  itemCount: schedule.listPosition!.length,
                  itemBuilder: (context, index) {
                    return buildPostionSchedule(
                        schedule.listPosition![index], myFont);
                  }))
        ],
      ),
    );
    return pdf.save();
  }

  static Widget buildPostionSchedule(Position position, Font font) {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        width: double.infinity,
        child: Column(children: [
          Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text('Lịch làm việc của ' + position.name!,
                  style: TextStyle(font: font))),
          buildTableData(font),
          ListView.builder(
            itemCount: position.listShift!.length,
            itemBuilder: (context, index) {
              return buildShiftRowData(position.listShift![index], font);
            },
          ),
        ]));
  }

  static Widget buildShiftRowData(Shift shift, Font font) {
    int maxNumOfStaff = 0, numOfStaff = 0;
    for (var day in shift.listDay!) {
      numOfStaff = 0;
      for (var staff in day.listStaff!) {
        numOfStaff++;
      }
      if (numOfStaff > maxNumOfStaff) maxNumOfStaff = numOfStaff;
    }
    print(maxNumOfStaff);
    final double widthOfCell = 60;
    final border = Border(
      bottom: BorderSide(
        width: 1,
      ),
      left: BorderSide(
        width: 1,
      ),
    );
    return Container(
        height: maxNumOfStaff == 1 ? 25 : maxNumOfStaff * 14 + 10,
        width: double.infinity,
        child: Row(children: [
          Container(
              width: 60,
              child: Column(children: [
                Text(shift.name!, style: TextStyle(font: font)),
                Text(
                    DateTimeHelpers.timestampsToTime(shift.timeStart!) +
                        '-' +
                        DateTimeHelpers.timestampsToTime(shift.timeEnd!),
                    style: TextStyle(font: font, fontSize: 10))
              ])),
          ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 30.0,
              ),
              child: Expanded(
                child: Container(
                    width: widthOfCell,
                    decoration: BoxDecoration(border: border),
                    child: Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: ListView.builder(
                        itemCount: shift.listDay![0].listStaff!.length,
                        itemBuilder: (context, index) {
                          return Text(shift.listDay![0].listStaff![index].name!,
                              style: TextStyle(font: font));
                        },
                      ),
                    )),
              )),
          ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 30.0,
              ),
              child: Expanded(
                child: Container(
                    width: widthOfCell,
                    decoration: BoxDecoration(border: border),
                    child: Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: ListView.builder(
                        itemCount: shift.listDay![1].listStaff!.length,
                        itemBuilder: (context, index) {
                          return Text(shift.listDay![1].listStaff![index].name!,
                              style: TextStyle(font: font));
                        },
                      ),
                    )),
              )),
          ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 30.0,
              ),
              child: Expanded(
                child: Container(
                    width: widthOfCell,
                    decoration: BoxDecoration(border: border),
                    child: Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: ListView.builder(
                        itemCount: shift.listDay![2].listStaff!.length,
                        itemBuilder: (context, index) {
                          return Text(shift.listDay![2].listStaff![index].name!,
                              style: TextStyle(font: font));
                        },
                      ),
                    )),
              )),
          ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 30.0,
              ),
              child: Expanded(
                child: Container(
                    width: widthOfCell,
                    decoration: BoxDecoration(border: border),
                    child: Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: ListView.builder(
                        itemCount: shift.listDay![3].listStaff!.length,
                        itemBuilder: (context, index) {
                          return Text(shift.listDay![3].listStaff![index].name!,
                              style: TextStyle(font: font));
                        },
                      ),
                    )),
              )),
          ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 30.0,
              ),
              child: Expanded(
                child: Container(
                    width: widthOfCell,
                    decoration: BoxDecoration(border: border),
                    child: Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: ListView.builder(
                        itemCount: shift.listDay![4].listStaff!.length,
                        itemBuilder: (context, index) {
                          return Text(shift.listDay![4].listStaff![index].name!,
                              style: TextStyle(font: font));
                        },
                      ),
                    )),
              )),
          ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 30.0,
              ),
              child: Expanded(
                child: Container(
                    width: widthOfCell,
                    decoration: BoxDecoration(border: border),
                    child: Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: ListView.builder(
                        itemCount: shift.listDay![5].listStaff!.length,
                        itemBuilder: (context, index) {
                          return Text(shift.listDay![5].listStaff![index].name!,
                              style: TextStyle(font: font));
                        },
                      ),
                    )),
              )),
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 30.0,
            ),
            child: Container(
                width: widthOfCell,
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(width: 1),
                  right: BorderSide(
                    width: 1,
                  ),
                  left: BorderSide(
                    width: 1,
                  ),
                )),
                child: Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: ListView.builder(
                    itemCount: shift.listDay![6].listStaff!.length,
                    itemBuilder: (context, index) {
                      return Text(shift.listDay![6].listStaff![index].name!,
                          style: TextStyle(font: font));
                    },
                  ),
                )),
          ),
        ]));
  }

  static Widget buildTableData(Font font) {
    final double widthOfCell = 60;
    final border = Border(
      top: BorderSide(
        width: 1,
      ),
      bottom: BorderSide(
        width: 1,
      ),
      left: BorderSide(
        width: 1,
      ),
    );
    return Container(
        margin: EdgeInsets.only(left: 60),
        width: double.infinity,
        height: 25,
        child: Row(children: [
          Container(
              width: widthOfCell,
              child:
                  Center(child: Text('Thứ hai', style: TextStyle(font: font))),
              decoration: BoxDecoration(border: border)),
          Container(
              width: widthOfCell,
              child:
                  Center(child: Text('Thứ ba', style: TextStyle(font: font))),
              decoration: BoxDecoration(border: border)),
          Container(
              width: widthOfCell,
              child:
                  Center(child: Text('Thứ tư', style: TextStyle(font: font))),
              decoration: BoxDecoration(border: border)),
          Container(
              width: widthOfCell,
              child:
                  Center(child: Text('Thứ năm', style: TextStyle(font: font))),
              decoration: BoxDecoration(border: border)),
          Container(
              width: widthOfCell,
              child:
                  Center(child: Text('Thứ sáu', style: TextStyle(font: font))),
              decoration: BoxDecoration(border: border)),
          Container(
              width: widthOfCell,
              child:
                  Center(child: Text('Thứ bảy', style: TextStyle(font: font))),
              decoration: BoxDecoration(border: border)),
          Container(
              width: widthOfCell,
              child:
                  Center(child: Text('Chủ nhật', style: TextStyle(font: font))),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 1,
                  ),
                  bottom: BorderSide(
                    width: 1,
                  ),
                  left: BorderSide(
                    width: 1,
                  ),
                  right: BorderSide(
                    width: 1,
                  ),
                ),
              )),
        ]));
  }
}
