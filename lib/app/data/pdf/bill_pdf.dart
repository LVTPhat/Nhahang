import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:sora_manager/app/data/models/dish_on_table.dart';

class BillPdf {
  static const double inch = 72.0;
  static const double cm = inch / 2.54;
  static Future<Uint8List> generatePdf(PdfPageFormat format,
      List<DishOnTableModel> listDish, String tableName) async {
    final pdf = Document(version: PdfVersion.pdf_1_5, compress: true);
    var data = await rootBundle.load("assets/fonts/arial.ttf");
    var dataBold = await rootBundle.load("assets/fonts/arial_bold.ttf");
    var dataItalic = await rootBundle.load("assets/fonts/arial_italic.ttf");
    var dataItalicBold =
        await rootBundle.load("assets/fonts/arial_bold_italic.ttf");
    var myFont = Font.ttf(data);
    var fontBold = Font.ttf(dataBold);
    var fontItalic = Font.ttf(dataItalic);
    var fontBoldItalic = Font.ttf(dataItalicBold);
    final double sizeHeight = 3 / 4 * listDish.length + 7;
    pdf.addPage(
      MultiPage(
        pageFormat: PdfPageFormat(8.0 * cm, sizeHeight * cm,
            marginTop: 1.0 * cm,
            marginBottom: 0.5 * cm,
            marginRight: 0.5 * cm,
            marginLeft: 0.5 * cm),
        build: (context) => [
          Container(
            width: double.infinity,
            child: Column(children: [
              Text('NHÀ HÀNG SORA',
                  style: TextStyle(font: fontBold, fontSize: 14)),
              Padding(
                  padding: EdgeInsets.only(top: 2, bottom: 6),
                  child: Text('Đường 3/2, Q.Ninh Kiều, TP.Cần Thơ',
                      style: TextStyle(font: myFont, fontSize: 9))),
              Text('Phiếu thanh toán',
                  style: TextStyle(font: fontBold, fontSize: 12)),
              Padding(
                  padding: EdgeInsets.only(top: 6, bottom: 2),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(tableName,
                            style: TextStyle(font: fontBold, fontSize: 10)),
                        Text('T.toán lúc: ' + getPayTime(),
                            style: TextStyle(font: fontItalic, fontSize: 9)),
                      ])),
              buildTitileOfBill(myFont),
              Text('-------------------------------------------------',
                  style: TextStyle(font: myFont)),
              ListView.builder(
                itemCount: listDish.length,
                itemBuilder: (context, index) {
                  return buildDishs(listDish[index], myFont);
                },
              ),
              Text('-------------------------------------------------',
                  style: TextStyle(font: myFont)),
              buildTotal(getTotal(listDish), fontBold),
              Text('Chúc quý khách vui vẻ, hẹn gặp lại!',
                  style: TextStyle(font: fontBoldItalic, fontSize: 9)),
            ]),
          )
        ],
      ),
    );
    return pdf.save();
  }

  static Widget buildTotal(int total, Font font) {
    final TextStyle contentStyle =
        TextStyle(font: font, fontSize: 10, fontWeight: FontWeight.bold);
    return Padding(
        padding: EdgeInsets.only(top: 2, bottom: 8),
        child: Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Text('Tổng cộng:', style: contentStyle),
              Text(total.toString(), style: contentStyle)
            ])));
  }

  static Widget buildTitileOfBill(Font font) {
    final TextStyle contentStyle = TextStyle(font: font, fontSize: 9);
    return Padding(
        padding: EdgeInsets.only(top: 4, bottom: 2),
        child: Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Container(
                width: 90,
                child: Text('Tên món', style: contentStyle),
              ),
              Container(
                width: 20,
                child: Text('SL'.toString(), style: contentStyle),
              ),
              Container(
                width: 40,
                child: Text('ĐG'.toString(), style: contentStyle),
              ),
              Container(width: 50, child: Text('T.Tiền', style: contentStyle))
            ])));
  }

  static Widget buildDishs(DishOnTableModel dish, Font font) {
    final TextStyle contentStyle = TextStyle(font: font, fontSize: 9);
    return Padding(
        padding: EdgeInsets.only(top: 4, bottom: 4),
        child: Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Container(
                width: 90,
                child: Text(dish.name!, style: contentStyle),
              ),
              Container(
                width: 20,
                child: Text(dish.amount!.toString(), style: contentStyle),
              ),
              Container(
                width: 40,
                child: Text(dish.price!.toString(), style: contentStyle),
              ),
              Container(
                  width: 50,
                  child: Text((dish.price! * dish.amount!).toString(),
                      style: contentStyle))
            ])));
  }

  static int getTotal(List<DishOnTableModel> dishs) {
    int total = 0;
    for (var dish in dishs) {
      total += dish.amount! * dish.price!;
    }
    return total;
  }

  static String getPayTime() {
    String time = '';
    DateTime temp = DateTime.now();
    time = '${temp.hour}:${temp.minute} ${temp.day}/${temp.month}/${temp.year}';
    return time;
  }
}
