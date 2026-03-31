import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sora_manager/app/data/helper/custom_scroll_behavior.dart';
import 'package:sora_manager/app/data/models/shift.dart';
import 'package:sora_manager/app/data/services/size.dart';
import 'package:sora_manager/app/modules/worktime/controllers/worktime_controller.dart';
import 'package:sora_manager/app/modules/worktime/views/components/shift.dart';
import 'package:sora_manager/app/modules/worktime/views/constant.dart';
import 'package:sora_manager/common/constant.dart';
import 'package:sora_manager/common/widgets/empty_screen.dart';
import 'package:sora_manager/common/widgets/loaders/custom_loader.dart';

class Schedule extends StatelessWidget {
  Schedule({Key? key, required this.controller}) : super(key: key);
  late BuildContext contextOf;
  final WorktimeController controller;
  @override
  Widget build(BuildContext context) {
    contextOf = context;
    controller.getMonOfWeek();
    // controller.changeProcess();
    return Container(
      margin: EdgeInsets.only(
          top: Resize.getSizeBaseOnHeight(35),
          bottom: Resize.getSizeBaseOnHeight(10)),
      width: Resize.getSizeBaseOnWidth(850),
      height: Resize.getSizeBaseOnHeight(370),
      // color: Colors.red[50],
      decoration: scheduleCardStyle,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: 'btnCopyShift',
                  backgroundColor: violet7,
                  onPressed: () {
                    // thuc hien sao chep lich o day
                    if (controller.coppyPercent == 100)
                      controller.coppyShiftOfLastWeek();
                  },
                  child: Stack(
                    children: [
                      Center(child: Icon(Icons.copy_sharp)),
                      Obx(() => Center(
                            child: CircularProgressIndicator(
                              value: controller.coppyPercent / 100,
                              color: controller.coppyPercent == 100
                                  ? violet7
                                  : violet3,
                            ),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: Resize.getSizeBaseOnWidth(10)),
                  child: FloatingActionButton(
                    heroTag: 'btnAddShift',
                    backgroundColor: violet7,
                    onPressed: () {
                      controller.isInsertShift = true;
                      controller.key.currentState!.openEndDrawer();
                    },
                    child: Icon(Icons.add),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                Obx(() => buildWeek(
                    context,
                    controller.getWeek(controller.focusDay),
                    controller.focusDay)),
                Obx(() => Expanded(
                      child: controller.isLoadShifts
                          ? LoadingScreen(
                              height: MediaQuery.of(context).size.height)
                          : ScrollConfiguration(
                              behavior: MyCustomScrollBehavior(),
                              child: buildShift(context, controller.monOfWeek)),
                    )),
              ],
            )),
      ),
    );
  }

  Widget buildWeek(
      BuildContext context, List<DateTime> week, DateTime focusDay) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        buildWeekdays(context, true, false, 'Thứ hai', week[0].day),
        buildWeekdays(context, false, false, 'Thứ ba', week[1].day),
        buildWeekdays(context, false, false, 'Thứ tư', week[2].day),
        buildWeekdays(context, false, false, 'Thứ năm', week[3].day),
        buildWeekdays(context, false, false, 'Thứ sáu', week[4].day),
        buildWeekdays(context, false, false, 'Thứ bảy', week[5].day),
        buildWeekdays(context, false, true, 'Chủ nhật', week[6].day),
      ],
    );
  }

  Widget buildWeekdays(BuildContext context, bool isFirst, bool isLass,
      String dayOfWeek, int day) {
    return Container(
      decoration: isFirst
          ? boderOfFirst
          : isLass
              ? boderOfLast
              : boderOfNormal,
      height: Resize.getSizeBaseOnHeight(90),
      width: Resize.getSizeBaseOnWidth(100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            dayOfWeek,
            style: textDayOfWeek,
          ),
          Text(
            day.toString(),
            style: textDay,
          ),
        ],
      ),
    );
  }

  Widget buildShift(BuildContext context, DateTime mon) {
    Size size = MediaQuery.of(context).size;
    var streamBuilder = StreamBuilder<List<ShiftModel>>(
        stream: controller.getShifts(mon),
        builder: (BuildContext context,
            AsyncSnapshot<List<ShiftModel>> shiftsSnapshot) {
          if (shiftsSnapshot.hasError)
            return new Text('Error: ${shiftsSnapshot.error}');
          switch (shiftsSnapshot.connectionState) {
            case ConnectionState.waiting:
              return LoadingScreen(height: size.height);
            default:
              if (shiftsSnapshot.data!.isEmpty) {
                return EmptyScreen(content: 'Chưa tìm thấy ca làm việc nào!');
              }
              return ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: shiftsSnapshot.data!.map((ShiftModel shift) {
                    return InkWell(
                      child: ShiftView(
                        workdays: shift.workdays!,
                        controller: controller,
                        contextOf: contextOf,
                        id: shift.id!,
                        name: shift.name!,
                        timeStart: shift.timeStart!,
                        timeEnd: shift.timeEnd!,
                      ),
                      onTap: () {},
                    );
                  }).toList());
          }
        });
    return streamBuilder;
  }
}
