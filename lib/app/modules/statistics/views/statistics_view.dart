import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sora_manager/app/data/helper/custom_scroll_behavior.dart';
import 'package:sora_manager/app/data/helper/datetime_helpers.dart';
import 'package:sora_manager/app/modules/statistics/controllers/statistics_controller.dart';
import 'package:sora_manager/app/modules/statistics/views/components/card_table_view.dart';
import 'package:sora_manager/app/modules/statistics/views/components/chart_of_year_view.dart';
import 'package:sora_manager/app/modules/statistics/views/components/chart_view.dart';
import 'package:sora_manager/app/modules/statistics/views/components/tables_chart_view.dart';
import 'package:sora_manager/app/modules/statistics/views/constant.dart';
import 'package:sora_manager/app/modules/worktime/views/constant.dart';
import 'package:sora_manager/common/constant.dart';
import 'package:sora_manager/common/widgets/custom_navigationbar.dart';
import 'package:sora_manager/common/widgets/loaders/custom_loader.dart';
import 'package:sora_manager/common/widgets/notification_icon.dart';

class StatisticsView extends GetView<StatisticsController> {
  @override
  var _controller = TextEditingController();
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    controller.getYearList();
    controller.initMonthList();
    controller.getTableList(1, 1, 2021);
    return Container(
      decoration: bgStyle,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomNavigationBar(
                height: MediaQuery.of(context).size.height,
                index: 5,
              ),
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Container(
                      margin: EdgeInsets.only(top: height / 50.1),
                      height: height / 12.2,
                      child: Padding(
                        padding: EdgeInsets.only(right: width / 51),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: width / 5.1,
                              decoration: searchStyle,
                              child: TextField(
                                  cursorColor: violet7,
                                  onChanged: (value) {},
                                  controller: _controller,
                                  style: styleOfTitle,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        _controller.clear();
                                      },
                                      icon: Icon(
                                        Icons.clear,
                                        color: violet7,
                                      ),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: violet7,
                                    ),
                                    prefixIconColor: violet7,
                                    hintText: 'Tìm kiếm',
                                    hintStyle: styleOfHint,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 20),
                                    border: textFeildBorder,
                                    enabledBorder: textFeildBorder,
                                    focusedBorder: textFeildBorder,
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide:
                                            BorderSide(color: secondaryColor)),
                                    disabledBorder: textFeildBorder,
                                  )),
                            ), //ket thuc khung tim kiem
                            Container(
                              width: width / 7.68,
                              child: Row(children: [
                                Icon(
                                  Icons.calendar_today_rounded,
                                  color: violet7,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width / 153.6),
                                  child: Text(
                                    DateTimeHelpers.getDateTimeNow(),
                                    style: dateTimeText,
                                  ),
                                )
                              ]),
                            ),
                            Container(
                              width: width / 4.8,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.message_outlined,
                                    color: violet7,
                                  ),
                                  NotificationIcon(),
                                  Container(
                                    width: width / 6.4,
                                    child: Row(
                                      children: [
                                        Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: AssetImage(
                                                    'assets/images/admin_avatar.jpg'),
                                              ),
                                            )),
                                        Flexible(
                                          child: Container(
                                            height: height / 12.4,
                                            margin: EdgeInsets.only(
                                                left: width / 109.71),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Võ Tứ Thiên',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: inforText,
                                                ),
                                                Text(
                                                  'thien@admin.com',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: inforText,
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ), // Ket thuc top nav
                    Expanded(
                      child: Scaffold(
                        backgroundColor: Colors.transparent,
                        body: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: width / 30.72 - 10,
                                  right: width / 23.63 + 20,
                                  top: height / 25),
                              height: double.infinity,
                              width: 850,
                              child: Scaffold(
                                  backgroundColor: Colors.transparent,
                                  body: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: width / 102.4, bottom: 30),
                                        child: Text(
                                          'Bảng thống kê',
                                          style: TextStyle(
                                            color: violet7,
                                            fontSize: 23,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      Container(
                                          width: double.infinity,
                                          height: 540,
                                          decoration: scheduleCardStyle,
                                          child: Column(
                                            children: [
                                              Obx(() => controller.monthChoosed
                                                          .compareTo(
                                                              'Tất cả') ==
                                                      0
                                                  ? ChartOfYearView(
                                                      year: int.parse(controller
                                                          .yearChoosed))
                                                  : ChartView(
                                                      month: int.parse(
                                                          controller
                                                              .monthChoosed
                                                              .substring(6)),
                                                      year: int.parse(controller
                                                          .yearChoosed))),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    'Thống kê trong năm: ',
                                                    style: keyTextStyle,
                                                  ),
                                                  Obx(() =>
                                                      DropdownButton<String>(
                                                        items: controller
                                                            .yearList
                                                            .map((String year) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: year,
                                                            child: Text(
                                                              year,
                                                              style:
                                                                  informationText,
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onChanged: (value) {
                                                          controller
                                                                  .yearChoosed =
                                                              value;
                                                          // gán giá tri tại day
                                                          //controller.newPosition = value!;
                                                          controller
                                                              .getMonthList(
                                                                  value!);
                                                        },
                                                        menuMaxHeight: 150,
                                                        hint: DropdownMenuItem<
                                                                String>(
                                                            value: controller
                                                                .yearChoosed,
                                                            child: Text(
                                                                controller
                                                                    .yearChoosed,
                                                                style:
                                                                    informationText)),
                                                      )),
                                                  Text(
                                                    'Tháng:',
                                                    style: keyTextStyle,
                                                  ),
                                                  Obx(() =>
                                                      DropdownButton<String>(
                                                        items: controller
                                                            .monthList
                                                            .map(
                                                                (String month) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: month,
                                                            child: Text(
                                                              month,
                                                              style:
                                                                  informationText,
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onChanged: (value) {
                                                          controller
                                                                  .monthChoosed =
                                                              value;
                                                          // gán giá tri tại day
                                                        },
                                                        menuMaxHeight: 150,
                                                        hint: DropdownMenuItem<
                                                                String>(
                                                            value: controller
                                                                .monthChoosed,
                                                            child: Text(
                                                                controller
                                                                    .monthChoosed,
                                                                style:
                                                                    informationText)),
                                                      )),
                                                ],
                                              )
                                            ],
                                          ))
                                    ],
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  right: width / 30.72 - 10, top: height / 25),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: width / 102.4),
                                    child: Text(
                                      'Thống kê doanh thu bàn ăn',
                                      style: TextStyle(
                                        color: violet7,
                                        fontSize: 23,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  TablesCharView(
                                    controller: controller,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 25, left: 15, bottom: 15),
                                    child: Text('Danh sách bàn ăn',
                                        style: TextStyle(
                                          color: violet7,
                                          fontSize: 20,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w300,
                                        )),
                                  ),
                                  Obx(() => Container(
                                        height: 140,
                                        width: 395,
                                        child: controller.isLoadTableList
                                            ? LoadingScreen(height: height)
                                            : ScrollConfiguration(
                                                behavior:
                                                    MyCustomScrollBehavior(),
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  controller:
                                                      ScrollController(),
                                                  itemCount: controller
                                                      .tableList.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        controller.getDataTable(
                                                            controller
                                                                    .tableList[
                                                                index]);
                                                      },
                                                      child: CardTableView(
                                                          totalRevenue:
                                                              controller
                                                                  .totalRevenue,
                                                          name: controller
                                                              .tableList[index]
                                                              .name,
                                                          revenue: controller
                                                              .tableList[index]
                                                              .revenue),
                                                    );
                                                  },
                                                ),
                                              ),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]))
            ],
          )),
    );
  }
}
