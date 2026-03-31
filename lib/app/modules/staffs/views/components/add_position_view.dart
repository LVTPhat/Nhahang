import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sora_manager/app/modules/staffs/controllers/staffs_controller.dart';

import 'package:sora_manager/app/modules/worktime/views/constant.dart';
import 'package:sora_manager/common/constant.dart';

class AddPositionView extends StatelessWidget {
  AddPositionView({Key? key}) : super(key: key);
  final StaffsController controller = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        height: 200,
        width: 360,
        decoration: cardStyle,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: Stack(
            children: [
              // Background(height: MediaQuery.of(context).size.height),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Thêm vị trí',
                      style: titleInsert,
                    ),
                    TextFormField(
                        cursorColor: keyOrHintColor,
                        onSaved: (value) {
                          controller.posName = value!;
                        },
                        validator: (value) {
                          if (value == '') return 'Hãy nhâp vào tên vị trí!';
                        },
                        style: styleOfTitle,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.border_color_sharp,
                            color: primaryColor,
                          ),
                          prefixIconColor: primaryColor,
                          hintText: 'Tên vị trí',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: Container(
                            height: 40,
                            width: 120,
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
                            height: 40,
                            width: 120,
                            child: ElevatedButton(
                              style: acceptBtnStyle,
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) return;
                                _formKey.currentState!.save();

                                controller.addPosition();
                                controller.getListPos();
                                controller.getPositionList();
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
