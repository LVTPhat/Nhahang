import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sora_manager/app/modules/statistics/controllers/statistics_controller.dart';
import 'package:sora_manager/app/modules/statistics/views/components/linetitles.dart';
import 'package:sora_manager/app/modules/statistics/views/constant.dart';
import 'package:sora_manager/common/constant.dart';
import 'package:sora_manager/common/widgets/loaders/custom_loader.dart';

final StatisticsController controller = Get.find();

class ChartView extends StatelessWidget {
  ChartView({Key? key, required this.month, required this.year})
      : super(key: key);
  final int month, year;
  List<Color> gradientColors = [
    blue4,
    violet4,
  ];
  @override
  Widget build(BuildContext context) {
    controller.getChartData(month, year);
    return Obx(() => Container(
          height: 470,
          child: Column(
            children: [
              Container(
                  width: double.infinity,
                  height: 380,
                  margin: EdgeInsets.all(20),
                  child: controller.isLoadingChartData
                      ? LoadingScreen(
                          height: MediaQuery.of(context).size.height)
                      : LineChart(LineChartData(
                          lineTouchData: LineTouchData(
                            touchCallback: (event, reponse) {
                              if (reponse == null ||
                                  reponse.lineBarSpots == null) return;
                              if (event is FlTapUpEvent) {
                                final value = reponse.lineBarSpots![0].x;
                                controller.getTableList(
                                    value.toInt(), month, year);
                              }
                            },
                          ),
                          titlesData: LineTitles.getTitleData(),
                          minX: 1,
                          maxX: controller.maxDay.toDouble(),
                          minY: controller.minRevenue.toDouble(),
                          maxY: controller.maxRevenue.toDouble(),
                          lineBarsData: [
                            LineChartBarData(
                                spots: controller.flspotList,
                                isCurved: true,
                                gradient: LinearGradient(
                                  colors: gradientColors,
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                belowBarData: BarAreaData(
                                  show: true,
                                  gradient: LinearGradient(
                                    colors: gradientColors
                                        .map((color) => color.withOpacity(0.3))
                                        .toList(),
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ))
                          ],
                        ))),
              Text(
                'Bảng thống kê doanh thu tháng ' +
                    month.toString() +
                    ' năm ' +
                    year.toString(),
                style: textTitleChart,
              )
            ],
          ),
        ));
  }
}
