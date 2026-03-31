import 'package:flutter/material.dart';
import 'package:sora_manager/app/data/pdf/timekeeping_pdf.dart';
import 'package:sora_manager/app/data/services/size.dart';
import 'package:sora_manager/app/modules/worktime/controllers/worktime_controller.dart';

import 'package:printing/printing.dart';

class PrintTimekeeping extends StatelessWidget {
  PrintTimekeeping({Key? key, required this.controller}) : super(key: key);
  final WorktimeController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Resize.getSizeBaseOnWidth(1000),
      height: double.infinity,
      color: Colors.white,
      child: PdfPreview(
          //canChangePageFormat: false,
          // canChangeOrientation: false,
          canDebug: false,
          build: (format) =>
              TimekeepingPdf.generatePdf(format, controller.timekeeping)),
    );
  }
}
