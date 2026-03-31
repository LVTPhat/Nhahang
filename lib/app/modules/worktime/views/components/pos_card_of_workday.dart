import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sora_manager/app/data/services/size.dart';
import 'package:sora_manager/app/modules/worktime/controllers/worktime_controller.dart';
import 'package:sora_manager/app/modules/worktime/views/components/shift.dart';
import 'package:sora_manager/app/modules/worktime/views/constant.dart';
import 'package:sora_manager/common/constant.dart';
import 'package:sora_manager/common/widgets/custom_notification.dart';

class PositionCardOfWorkday extends StatelessWidget {
  PositionCardOfWorkday(
      {Key? key,
      this.name,
      this.id,
      this.num,
      this.index,
      required this.controller})
      : super(key: key);
  var _controller = TextEditingController();
  final String? name, id;
  final int? num, index;
  final WorktimeController controller;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
        child: Obx(
          () => Container(
              decoration: controller.chooseIndex == index
                  ? choosedStyle
                  : unChoosedStyle,
              margin: EdgeInsets.only(
                  left: Resize.getSizeBaseOnWidth(10),
                  right: Resize.getSizeBaseOnWidth(10),
                  top: Resize.getSizeBaseOnHeight(10),
                  bottom: Resize.getSizeBaseOnHeight(10)),
              width: Resize.getSizeBaseOnWidth(240),
              height: Resize.getSizeBaseOnHeight(60),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                          child: Center(
                              child: Text(
                        name ?? '',
                        style: posNameStyle,
                      ))),
                      Padding(
                        padding: EdgeInsets.only(
                            right: Resize.getSizeBaseOnWidth(20)),
                        child: Container(
                          width: Resize.getSizeBaseOnWidth(120),
                          child: Stack(
                            children: [
                              Container(
                                height: Resize.getSizeBaseOnHeight(80),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        // giam so luong
                                        if (num! >
                                            await controller
                                                .checkLength(name!)) {
                                          controller.reduceNumberOfPosition(
                                              name!, num!);
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
                                                    title:
                                                        'Không thể giảm số lượng',
                                                    content:
                                                        'Bạn không thể giảm số lượng thấp hơn số nhân viên hiện tại!!',
                                                  ),
                                                );
                                              });
                                        }
                                      },
                                      child: Icon(
                                        Icons.arrow_left,
                                        color: violet6,
                                        size: Resize.getSizeChar(49),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // tang so luong

                                        controller.increaseNumberOfPosition(
                                            name!, num!);
                                      },
                                      child: Icon(
                                        Icons.arrow_right,
                                        color: violet6,
                                        size: Resize.getSizeChar(49),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Center(
                                child: Container(
                                  width: Resize.getSizeBaseOnWidth(50),
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    controller: _controller,
                                    cursorColor: keyOrHintColor,
                                    style: styleOfTitle,
                                    decoration: InputDecoration(
                                      hintText: num != null
                                          ? num.toString()
                                          : '0', // sua Hint o day
                                      prefixIconColor: primaryColor,
                                      hintStyle: styleOfTitle,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 8),
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
                                    ),
                                    onSubmitted: (value) async {
                                      if (GetUtils.isNum(value)) {
                                        controller.num = int.parse(value);
                                        //controller.updateNumOfPosition(id ?? '');
                                        controller.updateNumberOfPosition(
                                            name!, int.parse(value));
                                      } else {
                                        _controller.clear();
                                      }
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      /*Container(
                    width: 70,
                    height: 120,
                    child: InkWell(
                      onTap: () {
                        // xoa bo o day
                      },
                      child: Icon(
                        Icons.cancel,
                        color: keyOrHintColor,
                        size: 40,
                      ),
                    ),
                  ),
                  */
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: Resize.getSizeBaseOnHeight(6),
                            right: Resize.getSizeBaseOnWidth(6)),
                        child: InkWell(
                          onTap: () async {
                            if (await controller.checkLength(name!) == 0) {
                              controller.deletePositionOfWorkday(name!);
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      backgroundColor: Colors.transparent,
                                      child: CustomNotification(
                                        onAgreeButton: () {
                                          Get.back();
                                        },
                                        title: 'Không thể xóa',
                                        content:
                                            'Bạn không thể xóa nếu vị trí còn nhân viên!!',
                                      ),
                                    );
                                  });
                            }
                          },
                          child: Icon(
                            Icons.cancel,
                            color: violet6,
                            size: Resize.getSizeChar(30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ));
  }
}
