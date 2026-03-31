import 'package:flutter/material.dart';
import 'package:sora_manager/app/data/pdf/schedule_pdf.dart';
import 'package:sora_manager/app/data/services/size.dart';

import 'package:sora_manager/app/modules/worktime/controllers/worktime_controller.dart';

import 'package:printing/printing.dart';

class PrintWorktime extends StatelessWidget {
  PrintWorktime({Key? key, required this.controller}) : super(key: key);
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
              SchedulePdf.generatePdf(format, controller.schedule)),
    );
  }
}
