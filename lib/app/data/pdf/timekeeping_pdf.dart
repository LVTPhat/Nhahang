import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import 'package:sora_manager/app/data/models/timekeeping.dart';

class TimekeepingPdf {
  static Future<Uint8List> generatePdf(
      PdfPageFormat format, Timekeeping timekeeping) async {
    final pdf = Document(version: PdfVersion.pdf_1_5, compress: true);
    var data = await rootBundle.load("assets/fonts/arial.ttf");
    var myFont = Font.ttf(data);

    pdf.addPage(
      MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          ListView.builder(
            itemCount: timekeeping.listPositionTimekeeping.length,
            itemBuilder: (context, index) {
              return buildPostionTimekeeping(
                  timekeeping.listPositionTimekeeping[index], myFont);
            },
          ),
        ],
      ),
    );
    return pdf.save();
  }

  static Widget buildPostionTimekeeping(
      PositionTimekeeping position, Font font) {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        width: double.infinity,
        child: Column(children: [
          Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text('Bảng chấm công của ' + position.name,
                  style: TextStyle(font: font))),
          buildTableData(font),
          ListView.builder(
            itemCount: position.listStaffTimekeeping.length,
            itemBuilder: (context, index) {
              return buildStaffRowData(
                  position.listStaffTimekeeping[index], font);
            },
          ),
        ]));
  }

  static Widget buildStaffRowData(
      StaffTimekeeping staffTimekeeping, Font font) {
    int totalSalary = 0;
    for (var day in staffTimekeeping.listDayTimekeeping) {
      totalSalary += day.totalSalary;
    }
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
        width: double.infinity,
        child: Row(children: [
          Container(
              width: 60,
              child: Center(
                  child: Text(staffTimekeeping.name,
                      style: TextStyle(font: font)))),
          ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 30.0,
              ),
              child: Expanded(
                child: Container(
                    width: widthOfCell,
                    decoration: BoxDecoration(border: border),
                    child: Center(
                        child: Text(
                            staffTimekeeping.listDayTimekeeping[0].totalSalary
                                    .toString() +
                                ' VNĐ',
                            style: TextStyle(font: font, fontSize: 8)))),
              )),
          ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 30.0,
              ),
              child: Expanded(
                child: Container(
                    width: widthOfCell,
                    decoration: BoxDecoration(border: border),
                    child: Center(
                        child: Text(
                            staffTimekeeping.listDayTimekeeping[1].totalSalary
                                    .toString() +
                                ' VNĐ',
                            style: TextStyle(font: font, fontSize: 8)))),
              )),
          ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 30.0,
              ),
              child: Expanded(
                child: Container(
                    width: widthOfCell,
                    decoration: BoxDecoration(border: border),
                    child: Center(
                        child: Text(
                            staffTimekeeping.listDayTimekeeping[2].totalSalary
                                    .toString() +
                                ' VNĐ',
                            style: TextStyle(font: font, fontSize: 8)))),
              )),
          ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 30.0,
              ),
              child: Expanded(
                child: Container(
                    width: widthOfCell,
                    decoration: BoxDecoration(border: border),
                    child: Center(
                        child: Text(
                            staffTimekeeping.listDayTimekeeping[3].totalSalary
                                    .toString() +
                                ' VNĐ',
                            style: TextStyle(font: font, fontSize: 8)))),
              )),
          ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 30.0,
              ),
              child: Expanded(
                child: Container(
                    width: widthOfCell,
                    decoration: BoxDecoration(border: border),
                    child: Center(
                        child: Text(
                            staffTimekeeping.listDayTimekeeping[4].totalSalary
                                    .toString() +
                                ' VNĐ',
                            style: TextStyle(font: font, fontSize: 8)))),
              )),
          ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 30.0,
              ),
              child: Expanded(
                child: Container(
                    width: widthOfCell,
                    decoration: BoxDecoration(border: border),
                    child: Center(
                        child: Text(
                            staffTimekeeping.listDayTimekeeping[5].totalSalary
                                    .toString() +
                                ' VNĐ',
                            style: TextStyle(font: font, fontSize: 8)))),
              )),
          ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 30.0,
              ),
              child: Expanded(
                child: Container(
                    width: widthOfCell,
                    decoration: BoxDecoration(border: border),
                    child: Center(
                        child: Text(
                            staffTimekeeping.listDayTimekeeping[6].totalSalary
                                    .toString() +
                                ' VNĐ',
                            style: TextStyle(font: font, fontSize: 8)))),
              )),
          ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 30.0,
              ),
              child: Expanded(
                child: Container(
                    width: widthOfCell + 10,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                              width: 1,
                            ),
                            left: BorderSide(
                              width: 1,
                            ),
                            right: BorderSide(width: 1))),
                    child: Center(
                        child: Text(totalSalary.toString() + ' VNĐ',
                            style: TextStyle(font: font, fontSize: 8)))),
              )),
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
              decoration: BoxDecoration(border: border)),
          Container(
              width: widthOfCell + 10,
              child: Center(
                  child: Text('Tổng cộng', style: TextStyle(font: font))),
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
                      right: BorderSide(width: 1)))),
        ]));
  }
}
