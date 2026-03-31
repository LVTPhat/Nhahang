import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sora_manager/app/modules/statistics/controllers/data.dart';
import 'package:sora_manager/app/modules/statistics/controllers/statistics_controller.dart';
import 'package:sora_manager/app/modules/statistics/views/constant.dart';
import 'package:sora_manager/app/modules/worktime/views/constant.dart';
import 'package:sora_manager/common/constant.dart';

class TablesCharView extends StatelessWidget {
  TablesCharView({Key? key, required this.controller}) : super(key: key);
  final StatisticsController controller;
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          margin: EdgeInsets.only(top: 35),
          height: 325,
          width: 395,
          decoration: scheduleCardStyle,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 280,
                    height: 280,
                    padding: const EdgeInsets.all(15),
                    child: PieChart(PieChartData(
                      sections: getSections(),
                    )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: IndicatorsWidget(datas: controller.listData),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                'Biểu đồ thống kê doanh thu',
                style: textTitleChart,
              )
            ],
          ),
        ));
  }

  List<PieChartSectionData> getSections() => controller.listData
      .asMap()
      .map<int, PieChartSectionData>((index, data) {
        final double radius = index == 0 ? 50 : 40;
        final value = PieChartSectionData(
          color: data.color,
          value: data.percent,
          radius: radius,
          title: data.percent!.toStringAsFixed(1) + '%',
          titleStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xfffffffff)),
        );
        return MapEntry(index, value);
      })
      .values
      .toList();
}

class IndicatorsWidget extends StatelessWidget {
  IndicatorsWidget({Key? key, required this.datas}) : super(key: key);
  final List<Data> datas;
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: datas
            .map((data) => Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: buildIndicator(color: data.color, text: data.name),
                ))
            .toList());
  }

  buildIndicator({Color? color, String? text}) {
    bool isSquare = false;
    double size = 16;
    Color textColor = violet5;
    return Row(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 8),
        Text(text!,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: textColor))
      ],
    );
  }
}
