import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sora_manager/app/modules/staffs/controllers/staffs_controller.dart';
import 'package:sora_manager/app/modules/staffs/views/contant.dart';
import 'package:sora_manager/common/constant.dart';

class UpdateInformation extends StatelessWidget {
  UpdateInformation({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final textFeildBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: primaryColor));
  final StaffsController controller = Get.find();
  // final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
          key: _formKey,
          child: Center(child: buildView(context)),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Container(
                height: 50,
                width: 50,
                child: FloatingActionButton.extended(
                  heroTag: 'btnClose',
                  onPressed: () {
                    controller.isUpdate = false;
                    controller.isChooseImage = false;
                  },
                  label: Icon(Icons.close),
                  backgroundColor: violet7,
                ),
              ),
            ),
            Container(
              height: 50,
              width: 50,
              child: FloatingActionButton.extended(
                heroTag: 'btnDone',
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;
                  _formKey.currentState!.save();

                  controller.uploadImage();
                  controller.isUpdate = false;
                },
                label: Icon(Icons.done),
                backgroundColor: violet7,
              ),
            ),
          ],
        ));
  }

  Widget buildView(BuildContext context) => Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios_new)),
          Center(
            child: Container(
              height: 212,
              margin: EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => InkWell(
                        onTap: () {
                          controller.pickImage();
                        },
                        child: controller.isChooseImage
                            ? Container(
                                margin: EdgeInsets.only(right: 20),
                                width: 112,
                                height: 112,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: Image.memory(controller.image).image,
                                  ),
                                ))
                            : Container(
                                margin: EdgeInsets.only(right: 20),
                                width: 112,
                                height: 112,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        controller.currentUser.avatar ??
                                            controller.cloudImage),
                                  ),
                                )),
                      )),
                  Container(
                    width: 300,
                    child: TextFormField(
                      cursorColor: keyOrHintColor,
                      style: informationText,
                      initialValue: controller.initName,
                      onSaved: (value) {
                        if (value != '') controller.newName = value!;
                      },
                      validator: (value) {
                        if (value == '' &&
                            controller.newName == 'VD: Võ Tứ Thiên')
                          return 'Hãy nhập vào tên của bạn!';
                      },
                      decoration: InputDecoration(
                        hintText: controller.newName,
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
                    controller.currentUser.email ?? "",
                    style: informationText,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 125,
                          child: Text(
                            'SĐT',
                            style: keyText,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            cursorColor: keyOrHintColor,
                            keyboardType: TextInputType.phone,
                            initialValue: controller.initPhone,
                            style: informationText,
                            onSaved: (value) {
                              if (value != '') controller.newPhone = value!;
                            },
                            validator: (value) {
                              if (value == '' &&
                                  controller.newPhone == 'VD: 0971008616')
                                return 'Hãy nhập vào số điện thoại của bạn!';
                              if (value != '' &&
                                  !GetUtils.isPhoneNumber(value!)) {
                                return 'Số điện thoại không hợp lệ!';
                              }
                            },
                            decoration: InputDecoration(
                              hintText: controller.newPhone,
                              hintStyle: keyText,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 20),
                              border: textFeildBorder,
                              enabledBorder: textFeildBorder,
                              focusedBorder: textFeildBorder,
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: secondaryColor)),
                              disabledBorder: textFeildBorder,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 125,
                          child: Text(
                            'Giới tính',
                            style: keyText,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Obx(
                                () => Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                          color: primaryColor,
                                          width: 1,
                                        ),
                                        color: controller.bgCheckBox),
                                    child: InkWell(
                                      onTap: () {
                                        controller.sex = !controller.sex;
                                        if (controller.sex) {
                                          controller.bgCheckBox = primaryColor;
                                          controller.newSex = 'Nam';
                                        } else {
                                          controller.bgCheckBox = Colors.white;
                                          controller.newSex = 'Nữ';
                                        }
                                      },
                                      child: controller.sex
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.check,
                                                size: 16,
                                                color: Colors.white,
                                              ),
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                  'Nam',
                                  style: informationText,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 125,
                          child: Text(
                            'Địa chỉ',
                            style: keyText,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            cursorColor: keyOrHintColor,
                            initialValue: controller.initAddress,
                            style: informationText,
                            onSaved: (value) {
                              if (value != '') controller.newAddress = value!;
                            },
                            validator: (value) {
                              if (value == '' &&
                                  controller.newAddress ==
                                      'VD: Ninh Kiều, Cần Thơ')
                                return 'Hãy nhập vào địa chỉ của bạn';
                              if (value != '' &&
                                  !GetUtils.isLengthGreaterThan(value, 2)) {
                                return 'Địa chỉ không hợp lệ!';
                              }
                            },
                            decoration: InputDecoration(
                              hintText: controller.newAddress,
                              hintStyle: keyText,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 20),
                              border: textFeildBorder,
                              enabledBorder: textFeildBorder,
                              focusedBorder: textFeildBorder,
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: secondaryColor)),
                              disabledBorder: textFeildBorder,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 125,
                          child: Text(
                            'Ngày sinh',
                            style: keyText,
                          ),
                        ),
                        Obx(() => TextButton(
                            onPressed: () => pickDate(context),
                            child: Text(
                              controller.getText(controller.date),
                              style: informationText,
                            )))
                      ],
                    ),
                  ]),
            ),
          ),
        ],
      ));
  Future pickDate(BuildContext context) async {
    final initialDate = controller.date;
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 70),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (newDate == null) return;
    controller.date = newDate;
  }
}
