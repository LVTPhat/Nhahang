import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sora_manager/app/data/helper/datetime_helpers.dart';
import 'package:sora_manager/app/data/models/workday.dart';
import 'package:sora_manager/app/data/services/size.dart';
import 'package:sora_manager/app/modules/worktime/controllers/worktime_controller.dart';
import 'package:sora_manager/app/modules/worktime/views/components/workday_detail.dart';

import 'package:sora_manager/app/modules/worktime/views/constant.dart';
import 'package:sora_manager/common/constant.dart';

class ShiftView extends StatelessWidget {
  ShiftView(
      {Key? key,
      required this.workdays,
      required this.controller,
      required this.id,
      required this.name,
      required this.timeStart,
      required this.contextOf,
      required this.timeEnd})
      : super(key: key);
  final String name, id;
  final Timestamp timeStart, timeEnd;
  final BuildContext contextOf;
  final WorktimeController controller;
  final List<WorkdayModel> workdays;
  @override
  Widget build(BuildContext context) {
    //  controller.updateCurrentNumberOfStaff(id);
    return Container(
        height: Resize.getSizeBaseOnHeight(100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                decoration: styleOfShiftCard,
                child: IntrinsicWidth(
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: Resize.getSizeBaseOnWidth(20)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                name,
                                style: nameShift,
                              ),
                              Text(
                                DateTimeHelpers.timestampsToTime(timeStart) +
                                    '-' +
                                    DateTimeHelpers.timestampsToTime(timeEnd),
                                style: infoShift,
                              ),
                            ]),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: Resize.getSizeBaseOnHeight(6),
                                right: Resize.getSizeBaseOnWidth(6)),
                            child: InkWell(
                              onTap: () {
                                controller.deleteShift(id);
                              },
                              child: Icon(
                                Icons.cancel,
                                color: violet7,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            buildWeekdays(context, false, 'monday', 0),
            buildWeekdays(context, false, 'tuesday', 1),
            buildWeekdays(context, false, 'wednesday', 2),
            buildWeekdays(context, false, 'thursday', 3),
            buildWeekdays(context, false, 'friday', 4),
            buildWeekdays(context, false, 'saturday', 5),
            buildWeekdays(context, true, 'sunday', 6),
          ],
        ));
  }

  Widget buildWeekdays(
      BuildContext context, bool isLass, String key, int index) {
    return InkWell(
      onTap: () {
        if (key.compareTo(controller.currentDay) != 0 && !controller.openW) {
          controller.currentShiftName = name;
          controller.currentShiftTime =
              DateTimeHelpers.timestampsToTime(timeStart) +
                  '-' +
                  DateTimeHelpers.timestampsToTime(timeEnd);
          controller.currentShift = id;
          controller.currentDay = key;
          controller.getTimeOfShift(timeStart, timeEnd);
          Scaffold.of(contextOf).showBottomSheet((context) => WorkdayDetail(
                controller: controller,
              ));
          controller.openW = true;
          controller.numberOfStaff = workdays[index].currentNumberStaff!;
          controller.maxNumberOfStaff = workdays[index].maxNumberStaff!;
          controller.getday(key, controller.weekday[index]);
          controller.isDataChange = false;
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: !isLass ? boderOfShift : boderOfLastShift),
        height: Resize.getSizeBaseOnHeight(100),
        width: Resize.getSizeBaseOnWidth(100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                getCurrentNumberOfStaff(index).toString() +
                    '/' +
                    getMaxNumberOfStaff(index).toString() +
                    ' nv',
                style: styleInSchedule,
              ),
            ),
            SizedBox(
              width: Resize.getSizeBaseOnWidth(90),
              height: Resize.getSizeBaseOnHeight(30),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: LinearProgressIndicator(
                  value: getCurrentNumberOfStaff(index) /
                      getMaxNumberOfStaff(index),
                  valueColor: AlwaysStoppedAnimation(blue3),
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int getCurrentNumberOfStaff(int index) {
    try {
      return workdays[index].currentNumberStaff!;
    } catch (e) {
      return 0;
    }
  }

  int getMaxNumberOfStaff(int index) {
    try {
      return workdays[index].maxNumberStaff!;
    } catch (e) {
      return controller.maxNumberOfStaff;
    }
  }
}
