import 'package:flutter/material.dart';
import 'package:sora_manager/app/data/pdf/bill_pdf.dart';
import 'package:sora_manager/app/modules/dinnertables/controllers/dinnertables_controller.dart';

import 'package:printing/printing.dart';

class PrintBill extends StatelessWidget {
  PrintBill({Key? key, required this.controller}) : super(key: key);
  final DinnertablesController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: double.infinity,
      color: Colors.white,
      child: PdfPreview(
          onPrinted: (context) {
            controller.payForTable();
          },
          canDebug: false,
          build: (format) => BillPdf.generatePdf(
              format, controller.listDish, controller.currentTable.tableName!)),
    );
  }
}
