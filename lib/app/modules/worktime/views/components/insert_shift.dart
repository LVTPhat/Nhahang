import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sora_manager/app/data/helper/custom_scroll_behavior.dart';
import 'package:sora_manager/app/data/helper/datetime_helpers.dart';
import 'package:sora_manager/app/data/services/size.dart';

import 'package:sora_manager/app/modules/worktime/controllers/worktime_controller.dart';
import 'package:sora_manager/app/modules/worktime/views/components/add_position.dart';
import 'package:sora_manager/app/modules/worktime/views/components/card_staff.dart';
import 'package:sora_manager/app/modules/worktime/views/components/card_staff_add.dart';
import 'package:sora_manager/app/modules/worktime/views/components/pos_card_of_workday.dart';
import 'package:sora_manager/app/modules/worktime/views/components/position_card.dart';
import 'package:sora_manager/app/modules/worktime/views/constant.dart';
import 'package:sora_manager/common/constant.dart';
import 'package:sora_manager/common/widgets/background.dart';
import 'package:sora_manager/common/widgets/empty_screen.dart';

class InsertShift extends StatelessWidget {
  final WorktimeController controller = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    controller.getPositionList();
    if (controller.isInsertShift) {
      return Form(
        key: _formKey,
        child: Container(
          width: Resize.getSizeBaseOnWidth(470),
          decoration: scheduleCardStyle,
          child: Stack(
            children: [
              //  Background(height: MediaQuery.of(context).size.height),
              Container(
                margin: EdgeInsets.only(
                    left: Resize.getSizeBaseOnWidth(30),
                    right: Resize.getSizeBaseOnWidth(30)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: Text(
                          'Thêm ca làm việc',
                          style: titleInsert,
                        ),
                      ),
                      Text(
                        'Thông tin ca làm việc',
                        style: titleContent,
                      ),
                      Row(
                        children: [
                          Container(
                              width: 180,
                              child: Text(
                                'Tên ca làm việc:',
                                style: contentKey,
                              )),
                          Flexible(
                            child: TextFormField(
                                cursorColor: keyOrHintColor,
                                onSaved: (value) {
                                  controller.shiftName = value!;
                                },
                                validator: (value) {
                                  if (value == '') return 'Hãy nhập tên ca!';
                                },
                                style: styleOfTitle,
                                decoration: InputDecoration(
                                  prefixIconColor: primaryColor,
                                  hintText: 'VD: Ca sáng',
                                  hintStyle: styleOfHint,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 20),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      color: primaryColor,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(color: primaryColor),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: secondaryColor),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: secondaryColor),
                                  ),
                                )),
                          ),
                        ],
                      ),
                      Row(children: [
                        Container(
                            width: Resize.getSizeBaseOnWidth(180),
                            child: Text(
                              'Giờ bắt đầu:',
                              style: contentKey,
                            )),
                        Obx(
                          () => TextButton(
                              onPressed: () => pickTimeStart(context),
                              child: Text(
                                DateTimeHelpers.timeOfDayToTime(
                                    controller.timeStart),
                                style: contentKey,
                              ),
                              style: btnTinmeStyle),
                        )
                      ]),
                      Row(children: [
                        Container(
                            width: Resize.getSizeBaseOnWidth(180),
                            child: Text(
                              'Giờ kết thúc:',
                              style: contentKey,
                            )),
                        Obx(
                          () => TextButton(
                              onPressed: () => pickTimeEnd(context),
                              child: Text(
                                DateTimeHelpers.timeOfDayToTime(
                                    controller.timeEnd),
                                style: contentKey,
                              ),
                              style: btnTinmeStyle),
                        ),
                      ]),
                      Text(
                        'Số lượng nhân viên theo chức vụ',
                        style: titleContent,
                      ),
                      Container(
                        height: Resize.getSizeBaseOnHeight(230),
                        width: Resize.getSizeBaseOnWidth(400),
                        child: Scaffold(
                            backgroundColor: Colors.transparent,
                            floatingActionButton: Container(
                              width: Resize.getSizeBaseOnWidth(45),
                              height: Resize.getSizeBaseOnHeight(45),
                              child: FloatingActionButton(
                                heroTag: 'btn2',
                                backgroundColor: violet6,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                            backgroundColor: Colors.transparent,
                                            child: AddPosition(
                                              isAddToWorkDay: false,
                                            ));
                                      });
                                },
                                child: Icon(Icons.add),
                              ),
                            ),
                            body: Obx(() => controller.positionList.length == 0
                                ? EmptyScreen(content: 'Chưa có chức vụ nào!')
                                : ScrollConfiguration(
                                    behavior: MyCustomScrollBehavior(),
                                    child: ListView.builder(
                                      controller: ScrollController(),
                                      itemCount: controller.positionList.length,
                                      itemBuilder: (context, index) {
                                        return PositionCard(
                                            controller: controller,
                                            num: controller
                                                .positionList[index].number,
                                            id: controller
                                                .positionList[index].id,
                                            name: controller
                                                .positionList[index].name);
                                      },
                                    ),
                                  ))),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            child: Container(
                              height: Resize.getSizeBaseOnHeight(40),
                              width: Resize.getSizeBaseOnWidth(120),
                              child: ElevatedButton(
                                style: refuseBtnStyle,
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text(
                                  'Hủy bỏ',
                                  style: txtButtonStyle,
                                ),
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            child: Container(
                              height: Resize.getSizeBaseOnHeight(40),
                              width: Resize.getSizeBaseOnWidth(120),
                              child: ElevatedButton(
                                style: acceptBtnStyle,
                                onPressed: () {
                                  if (!_formKey.currentState!.validate())
                                    return;
                                  _formKey.currentState!.save();
                                  controller.insertShift();
                                  Get.back();
                                },
                                child: Text(
                                  'thêm',
                                  style: txtButtonStyle,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
            ],
          ),
        ),
      );
    } else {
      // Tuy chinh so luong nhan vien trong ca
      return Container(
        width: Resize.getSizeBaseOnWidth(470),
        decoration: scheduleCardStyle,
        child: Stack(
          children: [
            //Background(height: MediaQuery.of(context).size.height),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Tùy chỉnh nhân viên trong ca',
                  style: titleInsert,
                ),
                Container(
                  width: Resize.getSizeBaseOnWidth(460),
                  height: Resize.getSizeBaseOnHeight(80),
                  child: Scaffold(
                      backgroundColor: Colors.transparent,
                      floatingActionButton: Container(
                        width: Resize.getSizeBaseOnWidth(45),
                        height: Resize.getSizeBaseOnHeight(45),
                        child: FloatingActionButton(
                          heroTag: 'btn3',
                          backgroundColor: violet6,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                      backgroundColor: Colors.transparent,
                                      child: AddPosition(
                                        isAddToWorkDay: true,
                                      ));
                                });
                          },
                          child: Icon(Icons.add),
                        ),
                      ),
                      body: Obx(() => ScrollConfiguration(
                            behavior: MyCustomScrollBehavior(),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              controller: ScrollController(),
                              itemCount: controller.workdayPos.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  hoverColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.green[50],
                                  onTap: () {
                                    controller.chooseIndex = index;
                                    controller.currenNamePos =
                                        controller.workdayPos[index].name!;
                                    controller.currenPosition =
                                        controller.workdayPos[index];
                                    controller.position =
                                        controller.workdayPos[index].name!;
                                    controller.getStaffList(
                                        controller.currentShift,
                                        controller.currentDay,
                                        controller.workdayPos[index].name!);
                                  },
                                  child: PositionCardOfWorkday(
                                      controller: controller,
                                      index: index,
                                      num: controller.workdayPos[index].number,
                                      id: controller.workdayPos[index].id,
                                      name: controller.workdayPos[index].name),
                                );
                              },
                            ),
                          ))),
                ),
                Text(
                  'Danh sách nhân viên trong ca trực',
                  style: contentKey,
                ),
                Container(
                  height: Resize.getSizeBaseOnHeight(210),
                  width: Resize.getSizeBaseOnWidth(400),
                  //  color: Colors.blue[50],
                  child: Obx(() => controller.staffList.length == 0
                      ? EmptyScreen(content: 'Danh sách trống!')
                      : ScrollConfiguration(
                          behavior: MyCustomScrollBehavior(),
                          child: ListView.builder(
                            controller: ScrollController(),
                            itemCount: controller.staffList.length,
                            itemBuilder: (context, index) {
                              return CardStaff(
                                controller: controller,
                                id: controller.staffList[index].id,
                                name: controller.staffList[index].name,
                                phone: controller.staffList[index].phone,
                                avatar: controller.staffList[index].avatar,
                                position: controller.staffList[index].position,
                              );
                            },
                          ),
                        )),
                ),
                Text(
                  'Danh sách nhân viên theo vị trí',
                  style: contentKey,
                ),
                Container(
                  height: Resize.getSizeBaseOnHeight(210),
                  width: Resize.getSizeBaseOnWidth(400),
                  // color: Colors.blue[50],
                  child: Obx(() => controller.allStaffPos.length == 0
                      ? EmptyScreen(content: 'Danh sách rỗng!')
                      : ScrollConfiguration(
                          behavior: MyCustomScrollBehavior(),
                          child: ListView.builder(
                            controller: ScrollController(),
                            itemCount: controller.allStaffPos.length,
                            itemBuilder: (context, index) {
                              return CardStaffAdd(
                                controller: controller,
                                id: controller.allStaffPos[index].id,
                                name: controller.allStaffPos[index].name,
                                phone: controller.allStaffPos[index].phone,
                                avatar: controller.allStaffPos[index].avatar,
                                position:
                                    controller.allStaffPos[index].position,
                              );
                            },
                          ),
                        )),
                )
              ],
            )
          ],
        ),
      );
    }
  }

  Future pickTimeStart(BuildContext context) async {
    final newTime = await showTimePicker(
        context: context, initialTime: controller.timeStart);
    if (newTime == null) return;
    controller.timeStart = newTime;
  }

  Future pickTimeEnd(BuildContext context) async {
    final newTime =
        await showTimePicker(context: context, initialTime: controller.timeEnd);
    if (newTime == null) return;
    controller.timeEnd = newTime;
  }
}
