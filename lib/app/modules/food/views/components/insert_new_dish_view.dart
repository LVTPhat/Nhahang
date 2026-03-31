import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sora_manager/app/modules/food/controllers/food_controller.dart';
import 'package:sora_manager/app/modules/food/views/constant.dart';
import 'package:sora_manager/common/constant.dart';
import 'package:sora_manager/common/widgets/custom_notification.dart';

class InsertDish extends StatelessWidget {
  InsertDish({Key? key});

  final FoodController controller = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    controller.initType();
    controller.resetImage();
    return Obx(() => Form(
          key: _formKey,
          child: Container(
            height: 240,
            decoration: bottomSheetStyle,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    'Thêm món ăn',
                    style: TextStyle(
                      color: violet7,
                      fontSize: 25,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Text(
                            'Hình ảnh:',
                            style: txtOfInsertContent,
                          ),
                        ),
                        InkWell(
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(color: primaryColor, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(13)),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 7),
                                  blurRadius: 20,
                                  color: Colors.grey.withOpacity(0.23),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    child: controller.image.length == 0
                                        ? Image(
                                            image: AssetImage(
                                                'assets/images/no_image.jpg'),
                                            fit: BoxFit.fitHeight,
                                          )
                                        : Image.memory(
                                            controller.image,
                                            fit: BoxFit.fill,
                                          ),
                                  ),
                                ),
                                Center(
                                    child: Icon(
                                  Icons.upload,
                                  size: 50,
                                  color: Color.fromARGB(189, 68, 66, 66),
                                )),
                              ],
                            ),
                          ),
                          onTap: () {
                            controller.pickImage();
                          },
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Text(
                            'Thông tin chi tiết:',
                            style: txtOfInsertContent,
                          ),
                        ),
                        Container(
                          width: 1000,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 300,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(bottom: 15, left: 20),
                                      child: Text(
                                        'Tên món ăn:',
                                        style: txtOfInsertContent,
                                      ),
                                    ),
                                    TextFormField(
                                        //  initialValue: controller.currentTable.tableName,
                                        cursorColor: violet7,
                                        onSaved: (value) {
                                          //    controller.newName = value!;
                                          controller.newDishName = value;
                                        },
                                        validator: (value) {
                                          if (value == '')
                                            return 'Hãy nhập tên món ăn!';
                                        },
                                        style: styleOfTitle,
                                        decoration: InputDecoration(
                                          prefixIconColor: primaryColor,
                                          hintText: 'VD: Sushi',
                                          hintStyle: styleOfHint,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 0, horizontal: 20),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide(
                                              color: primaryColor,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide:
                                                BorderSide(color: primaryColor),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide(
                                                color: secondaryColor),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide(
                                                color: secondaryColor),
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
                                      padding:
                                          EdgeInsets.only(bottom: 15, left: 20),
                                      child: Text(
                                        'Giá của món ăn:',
                                        style: txtOfInsertContent,
                                      ),
                                    ),
                                    Row(children: [
                                      Container(
                                        width: 150,
                                        child: TextFormField(
                                            cursorColor: violet7,
                                            //  initialValue: controller
                                            //  .currentTable.capacity!
                                            //   .toString(),
                                            onSaved: (value) {
                                              //   controller.newCapacity = int.parse(value!);
                                              controller.newDishPrice =
                                                  int.parse(value!);
                                            },
                                            validator: (value) {
                                              if (value == '')
                                                return 'Hãy nhập giá';
                                              if (!GetUtils.isNum(value!))
                                                return 'Không hợp lệ!';
                                            },
                                            style: styleOfTitle,
                                            decoration: InputDecoration(
                                              prefixIconColor: primaryColor,
                                              hintText: 'VD: 135000',
                                              hintStyle: styleOfHint,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0,
                                                      horizontal: 20),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: BorderSide(
                                                  color: primaryColor,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide:
                                                    BorderSide(color: violet7),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: BorderSide(
                                                    color: secondaryColor),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: BorderSide(
                                                    color: secondaryColor),
                                              ),
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text('VNĐ',
                                            style: txtOfInsertContent),
                                      )
                                    ]),
                                  ],
                                ),
                              ),
                              Container(
                                width: 220,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 15, left: 20),
                                        child: Text(
                                          'Loại món ăn:',
                                          style: TextStyle(
                                            color: violet7,
                                            fontSize: 23,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      Obx(() => DropdownButton<String>(
                                            items: controller.listType
                                                .map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style: txtDropDownStyle,
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              controller.hint = value;
                                              // gán giá tri tại day
                                              controller.newDishType = value;
                                            },
                                            menuMaxHeight: 150,
                                            hint: DropdownMenuItem<String>(
                                                value: controller.hint,
                                                child: Text(controller.hint,
                                                    style: txtDropDownStyle)),
                                          ))
                                    ]),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 130,
                      child: Column(
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
                                    if (controller.image.length != 0) {
                                      controller.uploadImage(true);
                                      Get.back();
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Dialog(
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: CustomNotification(
                                                onAgreeButton: () {
                                                  Get.back();
                                                },
                                                title: 'Nhắc nhỡ',
                                                content:
                                                    'Bạn chưa thêm hình cho món ăn!!',
                                              ),
                                            );
                                          });
                                    }
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
