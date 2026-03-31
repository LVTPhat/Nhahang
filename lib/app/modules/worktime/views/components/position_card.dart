import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sora_manager/app/data/services/size.dart';
import 'package:sora_manager/app/modules/worktime/controllers/worktime_controller.dart';
import 'package:sora_manager/app/modules/worktime/views/constant.dart';
import 'package:sora_manager/common/constant.dart';

class PositionCard extends StatelessWidget {
  PositionCard(
      {Key? key, this.name, this.id, this.num, required this.controller})
      : super(key: key);
  var _controller = TextEditingController();
  final String? name, id;
  final int? num;
  final WorktimeController controller;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(30),
      ),
      child: Container(
          decoration: scheduleCardStyle,
          margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          width: Resize.getSizeBaseOnWidth(240),
          height: Resize.getSizeBaseOnHeight(80),
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
                    padding:
                        EdgeInsets.only(right: Resize.getSizeBaseOnWidth(20)),
                    child: Container(
                      width: Resize.getSizeBaseOnWidth(120),
                      child: Stack(
                        children: [
                          Container(
                            height: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    // giam so luong
                                    controller.reduceNumberPosition(id!);
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
                                    controller.increaseNumberPosition(id!);
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
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 8),
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
                                    controller.updateNumOfPosition(id ?? '');
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
                      onTap: () {
                        // xoa bo o day
                        controller.deletePostion(id ?? '');
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
    );
  }
}
