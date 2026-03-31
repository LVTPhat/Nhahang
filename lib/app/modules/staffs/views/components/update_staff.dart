import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sora_manager/app/data/helper/datetime_helpers.dart';
import 'package:sora_manager/app/data/models/position.dart';
import 'package:sora_manager/app/modules/staffs/controllers/staffs_controller.dart';
import 'package:sora_manager/app/modules/staffs/views/components/add_position_view.dart';
import 'package:sora_manager/app/modules/staffs/views/contant.dart';
import 'package:sora_manager/common/constant.dart';
import 'package:sora_manager/common/widgets/custom_notification.dart';

class UpdateStaff extends StatelessWidget {
  UpdateStaff({Key? key, this.position, this.dateGetJob, this.salary})
      : super(key: key);
  final String? position;
  final Timestamp? dateGetJob;
  final int? salary;
  final StaffsController controller = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final textFeildBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: primaryColor));
  @override
  Widget build(BuildContext context) {
    controller.initUpdateStaff();
    initValue();
    return Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 95),
          child: FloatingActionButton(
              heroTag: 'buttonUpdateStaffInfor',
              onPressed: () {
                if (!_formKey.currentState!.validate()) return;
                _formKey.currentState!.save();
                controller.updateStaff();
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        child: CustomNotification(
                          onAgreeButton: () {
                            Get.back();
                          },
                          title: 'Thông báo',
                          content:
                              'Thông tin về công việc của nhân viên đã được cập nhật',
                        ),
                      );
                    });
              },
              backgroundColor: violet7,
              child: Icon(Icons.check)),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 160,
                        child: Text(
                          'Chức vụ',
                          style: keyText,
                        ),
                      ),
                      Obx(() => DropdownButton<String>(
                            items: controller.listPos.map((PositionModel pos) {
                              return DropdownMenuItem<String>(
                                value: pos.name,
                                child: Text(
                                  pos.name!,
                                  style: informationText,
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              controller.hint = value;
                              // gán giá tri tại day
                              controller.newPosition = value!;
                            },
                            menuMaxHeight: 150,
                            hint: DropdownMenuItem<String>(
                                value: controller.hint,
                                child: Text(controller.hint,
                                    style: informationText)),
                          )),
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                      backgroundColor: Colors.transparent,
                                      child: AddPositionView());
                                });
                          },
                          icon: Icon(
                            Icons.add,
                            color: violet6,
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 160,
                        child: Text(
                          'Ngày Nhận việc',
                          style: keyText,
                        ),
                      ),
                      Obx(() => TextButton(
                          onPressed: () => pickDate(context),
                          child: Text(
                            controller.getText(controller.dateGetJob),
                            style: informationText,
                          )))
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 160,
                        child: Text(
                          'Mức lương/tiếng',
                          style: keyText,
                        ),
                      ),
                      Container(
                        width: 120,
                        padding: EdgeInsets.only(right: 10),
                        child: TextFormField(
                          cursorColor: keyOrHintColor,
                          keyboardType: TextInputType.phone,
                          initialValue: controller.initSalary == 0
                              ? ''
                              : controller.initSalary.toString(),
                          style: informationText,
                          onSaved: (value) {
                            if (value != '')
                              controller.newSalary = int.parse(value!);
                          },
                          validator: (value) {
                            if (value == '')
                              return 'Hãy nhập vào lương của bạn';
                            if (!GetUtils.isNum(value!)) {
                              return 'Lương không hợp lệ!';
                            }
                          },
                          decoration: InputDecoration(
                            hintText: '...',
                            hintStyle: keyText,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 20),
                            border: textFeildBorder,
                            enabledBorder: textFeildBorder,
                            focusedBorder: textFeildBorder,
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: secondaryColor)),
                            disabledBorder: textFeildBorder,
                          ),
                        ),
                      ),
                      Text(
                        'VĐN',
                        style: informationText,
                      )
                    ],
                  ),
                ]),
          ),
        ));
  }

  Future pickDate(BuildContext context) async {
    final initialDate = controller.dateGetJob;
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 70),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (newDate == null) return;
    controller.dateGetJob = newDate;
  }

  initValue() {
    controller.hint = position!;
    controller.dateGetJob = dateGetJob != null
        ? DateTimeHelpers.timestampsToDateTime(dateGetJob!)
        : DateTime.now();
    controller.initSalary = salary!;
  }
}
