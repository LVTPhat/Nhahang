import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sora_manager/app/modules/statistics/controllers/statistics_controller.dart';
import 'package:sora_manager/app/modules/statistics/views/constant.dart';

final StatisticsController controller = Get.find();

class LineTitlesOfYear {
  static getTitleData() => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
            sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          interval: 1,
          getTitlesWidget: bottomTitlesWidget,
        )),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
            axisNameSize: 30,
            axisNameWidget: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                'Doanh thu (tr)',
                style: textInChart,
              ),
            ),
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 50,
              interval: 1,
              getTitlesWidget: leftTitlesWidget,
            )),
      );

  static Widget bottomTitlesWidget(double value, TitleMeta meta) {
    String text = '';
    if (value % 1 == 0) {
      text = value.toString();
    }

    if (value == 1) text = 'Tháng 1';

    return Padding(
      padding: EdgeInsets.only(
        top: 10,
      ),
      child: Text(
        text,
        style: textInChart,
      ),
    );
  }

  static Widget leftTitlesWidget(double value, TitleMeta meta) {
    String text = '';
    if (value % 100 == 0) {
      text = value.toString();
    }
    return Padding(
      padding: EdgeInsets.only(
        top: 10,
      ),
      child: Text(
        text,
        style: textInChart,
      ),
    );
  }
}
