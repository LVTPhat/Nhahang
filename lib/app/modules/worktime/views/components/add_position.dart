import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sora_manager/app/data/services/size.dart';
import 'package:sora_manager/app/modules/worktime/controllers/worktime_controller.dart';
import 'package:sora_manager/app/modules/worktime/views/constant.dart';
import 'package:sora_manager/common/constant.dart';

class AddPosition extends StatelessWidget {
  AddPosition({Key? key, required this.isAddToWorkDay}) : super(key: key);
  final WorktimeController controller = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final bool isAddToWorkDay;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        height: Resize.getSizeBaseOnHeight(300),
        width: Resize.getSizeBaseOnWidth(360),
        decoration: cardStyle,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: Stack(
            children: [
              // Background(height: MediaQuery.of(context).size.height),
              Container(
                margin: EdgeInsets.only(
                    left: Resize.getSizeBaseOnWidth(20),
                    right: Resize.getSizeBaseOnWidth(20)),
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
                          //controller.newName = value!;
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
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: Resize.getSizeBaseOnWidth(20)),
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
                      children: [
                        Container(
                          width: Resize.getSizeBaseOnWidth(200),
                          child: TextFormField(
                              cursorColor: keyOrHintColor,
                              onSaved: (value) {
                                controller.num = int.parse(value!);
                              },
                              validator: (value) {
                                if (value == '')
                                  return 'Hãy nhâp vào số lượng!';
                                if (!GetUtils.isNum(value!))
                                  return 'Số không hợp lệ!';
                              },
                              style: styleOfTitle,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.donut_small,
                                  color: primaryColor,
                                ),
                                prefixIconColor: primaryColor,
                                hintText: 'Số lượng',
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
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: Resize.getSizeBaseOnWidth(20)),
                          child: Text(
                            'Nhân viên',
                            style: contentKey,
                          ),
                        ),
                      ],
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
                                if (!_formKey.currentState!.validate()) return;
                                _formKey.currentState!.save();
                                controller.addPos(isAddToWorkDay);
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
