import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sora_manager/app/data/helper/custom_scroll_behavior.dart';
import 'package:sora_manager/app/data/helper/datetime_helpers.dart';
import 'package:sora_manager/app/modules/staffs/controllers/staffs_controller.dart';
import 'package:sora_manager/app/modules/staffs/views/contant.dart';

class TimeOfStaff extends StatelessWidget {
  TimeOfStaff({Key? key, required this.workdayCheck}) : super(key: key);
  final StaffsController controller = Get.find();
  final List<bool> workdayCheck;
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(children: [
                  Container(
                      margin: EdgeInsets.only(left: 40),
                      width: 180,
                      child: Text(
                        'Giờ có thể vào ca:',
                        style: contentKey,
                      )),
                  TextButton(
                      onPressed: () => pickTimeStart(context),
                      child: Text(
                        controller.isReadTimeStart
                            ? DateTimeHelpers.timeOfDayToTime(
                                controller.timeStart)
                            : 'Không',
                        style: contentKey,
                      ),
                      style: btnTinmeStyle),
                ]),
                Row(children: [
                  Container(
                      margin: EdgeInsets.only(left: 40),
                      width: 180,
                      child: Text(
                        'Giờ phải tan ca:',
                        style: contentKey,
                      )),
                  TextButton(
                      onPressed: () => pickTimeEnd(context),
                      child: Text(
                        controller.isReadTimeEnd
                            ? DateTimeHelpers.timeOfDayToTime(
                                controller.timeEnd)
                            : 'Không',
                        style: contentKey,
                      ),
                      style: btnTinmeStyle),
                ]),
                Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Text(
                    'Ngày nhân viên có thể làm việc: ',
                    style: contentKey,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  height: 80,
                  child: ScrollConfiguration(
                    behavior: MyCustomScrollBehavior(),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        buildWorkday(context, 0, 'Thứ hai'),
                        buildWorkday(context, 1, 'Thứ ba'),
                        buildWorkday(context, 2, 'Thứ tư'),
                        buildWorkday(context, 3, 'Thứ năm'),
                        buildWorkday(context, 4, 'Thứ sáu'),
                        buildWorkday(context, 5, 'Thứ bảy'),
                        buildWorkday(context, 6, 'Chủ nhật'),
                      ],
                    ),
                  ),
                )
              ]),
        ));
  }

  Future pickTimeStart(BuildContext context) async {
    final newTime = await showTimePicker(
        context: context, initialTime: controller.timeStart);
    if (newTime == null) return;
    controller.timeStart = newTime;
    controller.isReadTimeStart = true;
  }

  Future pickTimeEnd(BuildContext context) async {
    final newTime =
        await showTimePicker(context: context, initialTime: controller.timeEnd);
    if (newTime == null) return;
    controller.timeEnd = newTime;
    controller.isReadTimeEnd = true;
  }

  Widget buildWorkday(BuildContext context, int index, String key) {
    return InkWell(
      onTap: () {
        controller.onClickWorkdayInWorkdayList(index);
      },
      child: Container(
          margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
          height: 60,
          width: 100,
          decoration: workdayCheck[index] ? wdCardStyleInChoosed : wdCardStyle,
          child: Center(
            child: Text(
              key,
              style: contentKey,
            ),
          )),
    );
  }
}
