import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sora_manager/app/data/models/dish.dart';
import 'package:sora_manager/app/modules/dinnertables/views/constant.dart';
import 'package:sora_manager/app/modules/food/controllers/food_controller.dart';
import 'package:sora_manager/common/widgets/loaders/custom_loader.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FoodChart extends StatelessWidget {
  FoodChart({Key? key});
  final FoodController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
        margin: EdgeInsets.only(top: 30, bottom: 10, right: 10),
        decoration: cardStyle,
        child: controller.numberOfDish <= 1
            ? buildEmpScreen(context)
            : controller.isLoadCurrentDish || controller.isLoadListDish
                ? LoadingScreen(height: MediaQuery.of(context).size.height)
                : Row(
                    children: [
                      SizedBox(
                        width: 270,
                        child: SfCircularChart(
                          title: ChartTitle(
                              text: 'Biểu đồ số lượng món ăn đã được bán'),
                          legend: Legend(
                              isVisible: true,
                              position: LegendPosition.bottom,
                              overflowMode: LegendItemOverflowMode.wrap),
                          series: <CircularSeries>[
                            PieSeries<FoodData, String>(
                                dataSource: getDataOfQuantityChart(
                                    controller.currentDish),
                                xValueMapper: (FoodData data, _) => data.name,
                                yValueMapper: (FoodData data, _) =>
                                    data.quanlitySold,
                                dataLabelSettings:
                                    DataLabelSettings(isVisible: false))
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 270,
                        child: SfCircularChart(
                          title:
                              ChartTitle(text: 'Biểu đồ doanh thu của món ăn'),
                          legend: Legend(
                              isVisible: true,
                              position: LegendPosition.bottom,
                              overflowMode: LegendItemOverflowMode.wrap),
                          series: <CircularSeries>[
                            RadialBarSeries<FoodData, String>(
                                dataSource: getDataOfRevenueuChart(
                                    controller.currentDish),
                                xValueMapper: (FoodData data, _) => data.name,
                                yValueMapper: (FoodData data, _) =>
                                    data.quanlitySold,
                                dataLabelSettings:
                                    DataLabelSettings(isVisible: false))
                          ],
                        ),
                      ),
                    ],
                  )));
  }

  Widget buildEmpScreen(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 6.213,
          width: MediaQuery.of(context).size.width / 12.8,
          child: Image(
            image: AssetImage('assets/images/empty_icon.png'),
            fit: BoxFit.fill,
          ),
        ),
        Text(
          'Chưa có biểu đồ!',
          style: styleOfTitle,
        )
      ],
    ));
  }

  List<FoodData> getDataOfQuantityChart(DishModel currentDish) {
    if (currentDish.name != controller.nameOfMaxQuantity) {
      final List<FoodData> chartData = [
        FoodData(currentDish.name!, currentDish.soldQuantity!),
        FoodData(controller.nameOfMaxQuantity, controller.maxQuantity),
        FoodData(
            'Others',
            controller.totalOfQuantity -
                currentDish.soldQuantity! -
                controller.maxQuantity),
      ];
      return chartData;
    } else {
      final List<FoodData> chartData = [
        FoodData(controller.nameOfMaxQuantity, controller.maxQuantity),
        FoodData('Others', controller.totalOfQuantity - controller.maxQuantity),
      ];
      return chartData;
    }
  }

  List<FoodData> getDataOfRevenueuChart(DishModel currentDish) {
    if (currentDish.name != controller.nameOfMaxRevenue) {
      final List<FoodData> chartData = [
        FoodData(
            currentDish.name!, currentDish.soldQuantity! * currentDish.price!),
        FoodData(controller.nameOfMaxRevenue, controller.maxRevenue),
        FoodData(
            'Others',
            controller.totalOfRevenue -
                currentDish.soldQuantity! * currentDish.price! -
                controller.maxRevenue),
      ];
      return chartData;
    } else {
      final List<FoodData> chartData = [
        FoodData(controller.nameOfMaxRevenue, controller.maxRevenue),
        FoodData('Others', controller.totalOfRevenue - controller.maxRevenue),
      ];
      return chartData;
    }
  }
}

class FoodData {
  FoodData(this.name, this.quanlitySold);
  final String name;
  final int quanlitySold;
}
