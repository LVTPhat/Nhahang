import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sora_manager/app/modules/dinnertables/controllers/dinnertables_controller.dart';
import 'package:sora_manager/app/modules/dinnertables/views/constant.dart';

class CurrentTable extends StatelessWidget {
  CurrentTable({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);
  final DinnertablesController controller = Get.find();
  final double height, width;
  @override
  Widget build(BuildContext context) {
    controller.newGuestNum = controller.currentTable.guestNumber;
    return ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
        child: Obx(
          () => Container(
              width: width,
              height: height,
              child: Row(
                children: [
                  Container(
                    width: 225,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30)),
                      child: Image(
                        image: AssetImage(
                            getImageLink(controller.currentTable.tableStatus!)),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          controller.currentTable.tableName.toString() +
                              ' (' +
                              controller.newGuestNum.toInt().toString() +
                              '/' +
                              controller.currentTable.capacity.toString() +
                              ')',
                          style: styleOfTableName,
                        ),
                        SliderTheme(
                            data: SliderThemeData(
                              thumbColor: Colors.white,
                              valueIndicatorColor: Colors.teal,
                              valueIndicatorTextStyle: TextStyle(fontSize: 10),
                              overlayColor: Color.fromARGB(55, 136, 133, 133),
                              minThumbSeparation: 100,
                              trackHeight: 20,
                              inactiveTrackColor: bgColorOfRate,
                              activeTrackColor: fgColorOfRate,
                            ),
                            child: Slider(
                              // activeColor: fgColorOfRate,
                              // inactiveColor: bgColorOfRate,
                              //  divisions: controller.currentTable.capacity!,
                              max: controller.currentTable.capacity!.toDouble(),

                              value: controller.newGuestNum,
                              onChanged: (value) async {
                                if (value > 1) {
                                  controller.newGuestNum = value;
                                  await controller
                                      .updateGuestNum(value.toInt());
                                  await controller
                                      .updateTableStatus(value.toInt());
                                  controller.currentTable.guestNumber =
                                      value.toInt();
                                } else {
                                  if (controller.numOfDishOnTable == 0) {
                                    controller.newGuestNum = value;
                                    await controller
                                        .updateGuestNum(value.toInt());
                                    await controller
                                        .updateTableStatus(value.toInt());
                                    controller.currentTable.guestNumber =
                                        value.toInt();
                                  }
                                }
                              },
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 36,
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/price.png'),
                                  backgroundColor: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Text(
                                  controller.currentTableTotalPice != 0 &&
                                          controller.currentTableStatus !=
                                              'Trống'
                                      ? controller.currentTableTotalPice
                                              .toString() +
                                          ' VĐN'
                                      : 'Bàn chưa gọi món',
                                  style: normalText,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 36,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/images/payment_status.jpg'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Text(
                                  controller.currentTable.paymentStatus!,
                                  style: normalText,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 36,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/images/table_status.png'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Text(
                                  controller.currentTableStatus,
                                  style: normalText,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ));
  }

  String getImageLink(String status) {
    switch (status) {
      case 'Đã được đặt':
        return 'assets/images/booked_table.jpg';
      case 'Trống':
        return 'assets/images/empty_table.jpg';
    }
    return 'assets/images/eating_table.jpg';
  }
}
