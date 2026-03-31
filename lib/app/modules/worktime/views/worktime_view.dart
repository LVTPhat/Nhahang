import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sora_manager/app/data/helper/datetime_helpers.dart';
import 'package:sora_manager/app/data/services/size.dart';

import 'package:sora_manager/app/modules/worktime/views/components/custom_button.dart';
import 'package:sora_manager/app/modules/worktime/views/components/custom_dialog.dart';
import 'package:sora_manager/app/modules/worktime/views/components/insert_shift.dart';
import 'package:sora_manager/app/modules/worktime/views/components/print_timekeeping_view.dart';
import 'package:sora_manager/app/modules/worktime/views/components/print_worktime_view.dart';
import 'package:sora_manager/app/modules/worktime/views/components/schedule.dart';
import 'package:sora_manager/app/modules/worktime/views/constant.dart';

import 'package:sora_manager/common/constant.dart';
import 'package:sora_manager/common/widgets/custom_navigationbar.dart';
import 'package:sora_manager/common/widgets/notification_icon.dart';
import 'package:table_calendar/table_calendar.dart';
import '../controllers/worktime_controller.dart';

class WorktimeView extends GetView<WorktimeController> {
  @override
  var _controller = TextEditingController();
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Resize.currentHeight = height;
    Resize.currentWidth = width;
    controller.initWorkdayId();
    return Container(
      decoration: bgStyle,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomNavigationBar(
                height: MediaQuery.of(context).size.height,
                index: 4,
              ),
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Container(
                      margin:
                          EdgeInsets.only(top: Resize.getSizeBaseOnHeight(15)),
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
                                            width:
                                                Resize.getSizeBaseOnWidth(40),
                                            height:
                                                Resize.getSizeBaseOnHeight(40),
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
                        drawerScrimColor: Colors.transparent,
                        endDrawer: InsertShift(),
                        key: controller.key,
                        body: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: Resize.getSizeBaseOnWidth(40),
                                  right: Resize.getSizeBaseOnWidth(85),
                                  top: height / 25),
                              height: double.infinity,
                              width: Resize.getSizeBaseOnWidth(850),
                              child: Scaffold(
                                backgroundColor: Colors.transparent,
                                body: Row(
                                  children: [
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: width / 102.4),
                                            child: Text(
                                              'Bảng phân công',
                                              style: TextStyle(
                                                color: violet7,
                                                fontSize:
                                                    Resize.getSizeChar(23),
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          Schedule(
                                            controller: controller,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 20),
                                            height:
                                                Resize.getSizeBaseOnHeight(140),
                                            width:
                                                Resize.getSizeBaseOnWidth(850),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 15),
                                                  child: Text(
                                                    'Tùy chọn',
                                                    style: TextStyle(
                                                      color: violet7,
                                                      fontSize:
                                                          Resize.getSizeChar(
                                                              23),
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Obx(() => CustomButton(
                                                          percent: controller
                                                              .autoSchedudling,
                                                          color: pink7,
                                                          buttonName:
                                                              'Lập lịch tự động',
                                                          buttonContent:
                                                              'Lịch sẽ được lập tự động dựa vào dữ liệu trước đó',
                                                          onTap: () async {
                                                            if (controller
                                                                    .autoSchedudling ==
                                                                100) {
                                                              await controller
                                                                  .autoSchedule();
                                                              controller
                                                                  .changeProcess();
                                                            }
                                                            // controller.getStaffData();
                                                          },
                                                          icon: Icons
                                                              .calendar_today,
                                                        )),
                                                    Obx(() => CustomButton(
                                                          percent: controller
                                                              .loadingProcessing,
                                                          color: violet7,
                                                          buttonName:
                                                              'In lich làm việc',
                                                          buttonContent:
                                                              'Xem trước và in lịch làm việc theo tuần của nhân viên',
                                                          onTap: () {
                                                            if (controller
                                                                    .loadingProcessing ==
                                                                100) {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return Dialog(
                                                                        backgroundColor:
                                                                            Colors
                                                                                .transparent,
                                                                        child:
                                                                            PrintWorktime(
                                                                          controller:
                                                                              controller,
                                                                        ));
                                                                  });
                                                            }
                                                          },
                                                          icon: Icons
                                                              .local_print_shop,
                                                        )),
                                                    Obx(() => CustomButton(
                                                          percent: controller
                                                              .loadingProcessing,
                                                          color: blue7,
                                                          buttonName:
                                                              'In bảng chấm Công',
                                                          buttonContent:
                                                              'Xem và in thông tin về tiền lương của nhân viên theo tuần',
                                                          onTap: () {
                                                            if (controller
                                                                    .loadingProcessing ==
                                                                100) {
                                                              controller
                                                                  .getTimekeeping();
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return Dialog(
                                                                        backgroundColor:
                                                                            Colors
                                                                                .transparent,
                                                                        child:
                                                                            PrintTimekeeping(
                                                                          controller:
                                                                              controller,
                                                                        ));
                                                                  });
                                                            }
                                                          },
                                                          icon: Icons
                                                              .assignment_outlined,
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                                      'Lịch làm việc',
                                      style: TextStyle(
                                        color: violet7,
                                        fontSize: Resize.getSizeChar(23),
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: Resize.getSizeBaseOnHeight(30)),
                                    decoration: scheduleCardStyle,
                                    height: Resize.getSizeBaseOnHeight(540),
                                    width: Resize.getSizeBaseOnWidth(395),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Divider(
                                          thickness: 1,
                                        ),
                                        Obx(() => SizedBox(
                                              height:
                                                  Resize.getSizeBaseOnHeight(
                                                      395),
                                              width: Resize.getSizeBaseOnWidth(
                                                  360),
                                              child: TableCalendar(
                                                startingDayOfWeek:
                                                    StartingDayOfWeek.monday,
                                                firstDay:
                                                    DateTime.utc(2010, 10, 16),
                                                lastDay:
                                                    DateTime.utc(2030, 3, 14),
                                                focusedDay: controller.focusDay,
                                                selectedDayPredicate: (day) {
                                                  return isSameDay(
                                                      controller.selectedDay,
                                                      day);
                                                },
                                                onDaySelected:
                                                    (selectedDay, focusDay) {
                                                  if (controller.isChangeDay) {
                                                    controller.selectedDay =
                                                        selectedDay;
                                                    controller.getMonOfWeek();
                                                    controller.focusDay =
                                                        focusDay;
                                                  } else {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return Dialog(
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            child: CustomDialog(
                                                              onAgreeButton:
                                                                  () {
                                                                Get.back();
                                                              },
                                                              title:
                                                                  'Không thể đổi ngày',
                                                              content:
                                                                  'Quá trình sao chép đang được thực hiện!',
                                                            ),
                                                          );
                                                        });
                                                  } // update `_focusedDay` here as well
                                                },
                                              ),
                                            )),
                                        Divider(
                                          thickness: 1,
                                        ),
                                      ],
                                    ),
                                  ),
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
