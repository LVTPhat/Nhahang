import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sora_manager/app/modules/staffs/controllers/staffs_controller.dart';
import 'package:sora_manager/app/modules/staffs/views/contant.dart';
import 'package:sora_manager/common/constant.dart';
import 'package:sora_manager/common/widgets/background.dart';
import 'package:sora_manager/common/widgets/custom_textformfield.dart';

class AddStaff extends StatelessWidget {
  final StaffsController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.signupFormKey,
      child: Container(
        decoration: staffCardStyle,
        width: 380,
        height: 500,
        child: Stack(
          children: [
            // ClipRRect(
            //  borderRadius: BorderRadius.all(Radius.circular(30)),
            //  child: Background(height: MediaQuery.of(context).size.height)),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Thêm nhân viên',
                    style: TextStyle(
                      color: violet7,
                      fontSize: 23,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  buildNameFormField(),
                  buildEmailFormField(),
                  buildPhoneFormField(),
                  buildChooseHaveAcc(),
                  Flexible(
                    child: Row(
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
                                controller.resetData();
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
                                controller.checkSignUp(controller.isHaveAcc);
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      decoration: buildDecorationTextFormField(
        hintText: "Họ và tên",
        icon: Icons.person,
      ),
      keyboardType: TextInputType.name,
      cursorColor: violet7,
      style: styleOfTitle,
      onSaved: (value) {
        controller.name = value!;
      },
      validator: (value) {
        return controller.validateName(value!);
      },
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      decoration: buildDecorationTextFormField(
        hintText: "Email",
        icon: Icons.email,
      ),
      keyboardType: TextInputType.emailAddress,
      cursorColor: violet7,
      style: styleOfTitle,
      onSaved: (value) {
        controller.email = value!;
      },
      validator: (value) {
        return controller.validateEmail(value!);
      },
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      decoration: buildDecorationTextFormField(
        hintText: "Số điện thoại",
        icon: Icons.phone,
      ),
      cursorColor: violet7,
      style: styleOfTitle,
      keyboardType: TextInputType.phone,
      onSaved: (value) {
        controller.phone = value!;
      },
      validator: (value) {
        return controller.validatePhone(value!);
      },
    );
  }

  Widget buildChooseHaveAcc() {
    return Row(
      children: [
        Obx(
          () => Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: primaryColor,
                    width: 1,
                  ),
                  color: controller.bgCheckBoxAdd),
              child: InkWell(
                onTap: () {
                  controller.isHaveAcc = !controller.isHaveAcc;
                  if (controller.isHaveAcc) {
                    controller.bgCheckBoxAdd = primaryColor;
                  } else {
                    controller.bgCheckBoxAdd = Colors.white;
                  }
                },
                child: controller.isHaveAcc
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.check,
                          size: 16,
                          color: Colors.white,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.check_box_outline_blank,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            'Cấp tài khoản cho nhân viên',
            style: informationText,
          ),
        ),
      ],
    );
  }
}
