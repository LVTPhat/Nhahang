import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sora_manager/app/modules/dinnertables/controllers/dinnertables_controller.dart';
import 'package:sora_manager/app/modules/dinnertables/views/constant.dart';
import 'package:sora_manager/common/constant.dart';

class AddTable extends StatelessWidget {
  AddTable({Key? key});

  final DinnertablesController controller = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Form(
          key: _formKey,
          child: Container(
            height: 200,
            decoration: bottomSheetStyle,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    'Thêm bàn ăn',
                    style: TextStyle(
                      color: violet7,
                      fontSize: 25,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 15, left: 20),
                            child: Text(
                              'Tên bàn ăn:',
                              style: TextStyle(
                                color: violet7,
                                fontSize: 23,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          TextFormField(
                              cursorColor: violet7,
                              onSaved: (value) {
                                controller.newName = value!;
                              },
                              validator: (value) {
                                if (value == '') return 'Hãy nhập tên bàn!';
                              },
                              style: styleOfTitle,
                              decoration: InputDecoration(
                                prefixIconColor: primaryColor,
                                hintText: 'VD: Bàn 1',
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
                                  borderSide: BorderSide(color: secondaryColor),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(color: secondaryColor),
                                ),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 15, left: 20),
                            child: Text(
                              'Số khách tối đa:',
                              style: TextStyle(
                                color: violet7,
                                fontSize: 23,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Row(children: [
                            Container(
                              width: 150,
                              child: TextFormField(
                                  cursorColor: violet7,
                                  onSaved: (value) {
                                    controller.newCapacity = int.parse(value!);
                                  },
                                  validator: (value) {
                                    if (value == '') return 'Hãy nhập sức chứa';
                                    if (!GetUtils.isNum(value!))
                                      return 'Không hợp lệ!';
                                  },
                                  style: styleOfTitle,
                                  decoration: InputDecoration(
                                    prefixIconColor: primaryColor,
                                    hintText: 'VD: 10',
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
                                      borderSide:
                                          BorderSide(color: primaryColor),
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
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text('Người',
                                  style: TextStyle(
                                    color: violet7,
                                    fontSize: 23,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                  )),
                            )
                          ]),
                        ],
                      ),
                    ),
                    Container(
                      width: 300,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 15, left: 20),
                              child: Text(
                                'Trạng thái bàn ăn:',
                                style: TextStyle(
                                  color: violet7,
                                  fontSize: 23,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    activeColor: violet6,
                                    value: controller.isBooked,
                                    onChanged: (value) {
                                      controller.changeIsBooked();
                                    }),
                                Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Đã được đặt:',
                                    style: TextStyle(
                                      color: violet7,
                                      fontSize: 23,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ]),
                    ),
                    Container(
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            child: Container(
                              height: 60,
                              width: 60,
                              child: ElevatedButton(
                                  style: btnStyle,
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Icon(Icons.cancel)),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            child: Container(
                              height: 60,
                              width: 60,
                              child: ElevatedButton(
                                  style: btnStyle,
                                  onPressed: () {
                                    if (!_formKey.currentState!.validate())
                                      return;
                                    _formKey.currentState!.save();
                                    controller.addDinnerTable();
                                    Get.back();
                                  },
                                  child: Icon(Icons.check)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
