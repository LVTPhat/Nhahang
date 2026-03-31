import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sora_manager/app/data/helper/custom_scroll_behavior.dart';
import 'package:sora_manager/app/data/services/size.dart';
import 'package:sora_manager/app/modules/worktime/controllers/worktime_controller.dart';
import 'package:sora_manager/app/modules/worktime/views/components/card_staff.dart';
import 'package:sora_manager/app/modules/worktime/views/constant.dart';
import 'package:sora_manager/common/constant.dart';
import 'package:sora_manager/common/widgets/empty_screen.dart';
import 'package:sora_manager/common/widgets/loaders/custom_loader.dart';

class WorkdayDetail extends StatelessWidget {
  WorkdayDetail({Key? key, required this.controller}) : super(key: key);

  @override
  final contentKeyWidth = Resize.getSizeBaseOnWidth(210);
  final WorktimeController controller;
  Widget build(BuildContext context) {
    //controller.chooseIndex = 0;
    controller.currentShiftSalary = 0;
    controller.currentNumberOfStaff = 0;

    controller.getWorkdayPos(controller.currentShift, controller.currentDay);
    return Obx(() => Container(
          height: Resize.getSizeBaseOnHeight(380),
          //  margin: EdgeInsets.only(top: bo),
          decoration: wdayStyle,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Chi tiết ca làm việc trong ngày ' + controller.day,
                    style: titleInsert,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: Resize.getSizeBaseOnWidth(360),
                        height: Resize.getSizeBaseOnHeight(300),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Thông tin ca làm việc', style: titleContent),
                            Container(
                              width: Resize.getSizeBaseOnHeight(360),
                              height: Resize.getSizeBaseOnHeight(260),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: contentKeyWidth,
                                        child: Text(
                                          'Tên ca làm việc:',
                                          style: contentKey,
                                        ),
                                      ),
                                      Text(controller.currentShiftName,
                                          style: contentKey)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: contentKeyWidth,
                                        child: Text(
                                          'giờ bắt đầu-kết thúc:',
                                          style: contentKey,
                                        ),
                                      ),
                                      Text(
                                        controller.currentShiftTime,
                                        style: contentKey,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: contentKeyWidth,
                                        child: Text(
                                          'Số lượng nhân viên:',
                                          style: contentKey,
                                        ),
                                      ),
                                      Text(
                                        controller.currentNumberOfStaff
                                                .toString() +
                                            ' nhân viên',
                                        style: contentKey,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: contentKeyWidth,
                                        child: Text(
                                          'Lương của nhân viên:',
                                          style: contentKey,
                                        ),
                                      ),
                                      Text(
                                        controller.currentShiftSalary
                                                .toString() +
                                            ' VNĐ',
                                        style: contentKey,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: Resize.getSizeBaseOnHeight(300),
                        width: Resize.getSizeBaseOnWidth(360),
                        //   color: Colors.green[50],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Danh sách nhân viên trong ca',
                                style: titleContent),
                            Container(
                              margin: EdgeInsets.only(
                                  left: Resize.getSizeBaseOnWidth(15),
                                  right: Resize.getSizeBaseOnWidth(15),
                                  top: Resize.getSizeBaseOnHeight(10),
                                  bottom: Resize.getSizeBaseOnHeight(10)),
                              height: Resize.getSizeBaseOnHeight(35),
                              child: ScrollConfiguration(
                                behavior: MyCustomScrollBehavior(),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  controller: ScrollController(),
                                  itemCount: controller.workdayPos.length,
                                  itemBuilder: (context, index) {
                                    return buildNavBarItem(
                                        context,
                                        controller.workdayPos[index].name!,
                                        index);
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Scaffold(
                                  backgroundColor: Colors.transparent,
                                  floatingActionButton: Container(
                                    width: Resize.getSizeBaseOnWidth(45),
                                    height: Resize.getSizeBaseOnHeight(45),
                                    child: FloatingActionButton(
                                      heroTag: 'btn4',
                                      backgroundColor: violet7,
                                      onPressed: () {
                                        controller.isInsertShift = false;
                                        controller.key.currentState!
                                            .openEndDrawer();
                                      },
                                      child: Icon(
                                        Icons.mode,
                                      ),
                                    ),
                                  ),
                                  body: controller.isLoadStaffList
                                      ? LoadingScreen(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height)
                                      : controller.staffList.length == 0
                                          ? EmptyScreen(
                                              content: 'Chưa có nhân viên nào!')
                                          : ScrollConfiguration(
                                              behavior:
                                                  MyCustomScrollBehavior(),
                                              child: ListView.builder(
                                                controller: ScrollController(),
                                                itemCount:
                                                    controller.staffList.length,
                                                itemBuilder: (context, index) {
                                                  return CardStaff(
                                                    controller: controller,
                                                    id: controller
                                                        .staffList[index].id,
                                                    name: controller
                                                        .staffList[index].name,
                                                    phone: controller
                                                        .staffList[index].phone,
                                                    avatar: controller
                                                        .staffList[index]
                                                        .avatar,
                                                    position: controller
                                                        .staffList[index]
                                                        .position,
                                                  );
                                                },
                                              ),
                                            )),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: Resize.getSizeBaseOnHeight(12),
                        right: Resize.getSizeBaseOnWidth(12)),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        controller.isLoadStaffList = true;
                        controller.openW = false;
                        controller.currentDay = '';
                        if (controller.isDataChange) {
                          controller.changeProcess();
                        }
                      },
                      child: Icon(
                        Icons.cancel,
                        color: violet7,
                        size: Resize.getSizeChar(40),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget buildNavBarItem(BuildContext context, String type, int index) {
    return Obx(() => GestureDetector(
          onTap: () {
            controller.chooseIndex = index;
            controller.currenNamePos = controller.workdayPos[index].name!;
            controller.currenPosition = controller.workdayPos[index];
            print('name: ${controller.workdayPos[index].name!}');
            controller.position = type;
            controller.getStaffList(
                controller.currentShift, controller.currentDay, type);
          },
          child: Container(
            height: Resize.getSizeBaseOnHeight(30),
            width: Resize.getSizeBaseOnWidth(120),
            decoration: index == controller.chooseIndex
                ? BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 4, color: primaryColor)),
                    gradient: LinearGradient(colors: [
                      primaryColor.withOpacity(0.3),
                      primaryColor.withOpacity(0.015)
                    ], begin: Alignment.bottomCenter, end: Alignment.topCenter))
                : BoxDecoration(),
            /*child: Icon(
          icon,
          color:
              index == controller.chooseIndex ? primaryColor : keyOrHintColor,
          size: index == controller.chooseIndex ? 32 : 26,
        ),*/
            child: Center(
              child: Text(type,
                  style: TextStyle(
                      color: violet7,
                      fontSize: index == controller.chooseIndex ? 21 : 19)),
            ),
          ),
        ));
  }
}
