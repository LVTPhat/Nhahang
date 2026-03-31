import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sora_manager/app/modules/statistics/controllers/statistics_controller.dart';
import 'package:sora_manager/app/modules/statistics/views/components/linetitle_of_year.dart';
import 'package:sora_manager/app/modules/statistics/views/constant.dart';
import 'package:sora_manager/common/constant.dart';
import 'package:sora_manager/common/widgets/loaders/custom_loader.dart';

class ChartOfYearView extends StatelessWidget {
  ChartOfYearView({Key? key, required this.year}) : super(key: key);
  final int year;
  List<Color> gradientColors = [
    blue4,
    violet4,
  ];
  final StatisticsController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    // controller.getChartData(month, year);
    controller.getYearData(year);
    return Obx(() => Container(
          height: 470,
          child: Column(
            children: [
              Container(
                  width: double.infinity,
                  height: 380,
                  margin: EdgeInsets.all(20),
                  child: controller.isLoadChartOfYear
                      ? LoadingScreen(
                          height: MediaQuery.of(context).size.height)
                      : LineChart(LineChartData(
                          titlesData: LineTitlesOfYear.getTitleData(),
                          minX: 1,
                          maxX: 12,
                          minY: controller.minRevenueOfYear.toDouble(),
                          maxY: controller.maxRevenueOfYear.toDouble(),
                          lineBarsData: [
                            LineChartBarData(
                                spots: controller.spotOfYearList,
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
                'Bảng thống kê doanh thu năm ' + year.toString(),
                style: textTitleChart,
              )
            ],
          ),
        ));
  }
}
