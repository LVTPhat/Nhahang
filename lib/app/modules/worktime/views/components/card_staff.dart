import 'package:flutter/material.dart';
import 'package:sora_manager/app/data/services/size.dart';
import 'package:sora_manager/app/modules/worktime/controllers/worktime_controller.dart';
import 'package:sora_manager/app/modules/worktime/views/components/shift.dart';
import 'package:sora_manager/app/modules/worktime/views/constant.dart';
import 'package:sora_manager/common/constant.dart';

class CardStaff extends StatelessWidget {
  CardStaff(
      {Key? key,
      this.name,
      this.avatar,
      this.phone,
      this.position,
      this.id,
      required this.controller})
      : super(key: key);
  final String? name, phone, position, avatar, id;
  final WorktimeController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(Resize.getSizeBaseOnWidth(10), 0,
          Resize.getSizeBaseOnWidth(10), Resize.getSizeBaseOnHeight(10)),
      decoration: staffCardStyle,
      width: Resize.getSizeBaseOnWidth(340),
      height: Resize.getSizeBaseOnHeight(90),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                  margin: EdgeInsets.only(
                    right: Resize.getSizeBaseOnWidth(15),
                    left: Resize.getSizeBaseOnWidth(10),
                  ),
                  width: Resize.getSizeBaseOnWidth(70),
                  height: Resize.getSizeBaseOnHeight(70),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(avatar ??
                          "https://firebasestorage.googleapis.com/v0/b/nha-hang-sora.appspot.com/o/avatar%2Fanh5.jpg?alt=media&token=908d2869-7599-4a15-aed3-3cb86fc273e0"),
                    ),
                  )),
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(
                      right: Resize.getSizeBaseOnWidth(20),
                      top: Resize.getSizeBaseOnHeight(5),
                      bottom: Resize.getSizeBaseOnHeight(5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                          child: Text(
                        name ?? 'Võ Tứ Thiên',
                        style: styleOfName,
                      )),
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: violet7,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              position ?? 'Chưa cập nhật',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: styleOfInfor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.phone,
                            color: violet7,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              phone ?? '0971008616',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: styleOfInfor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: IconButton(
                    onPressed: () {
                      controller.deleteStaffFromSchedule(
                          controller.currentShift,
                          controller.currentDay,
                          controller.position,
                          id!);
                    },
                    icon: Icon(
                      Icons.cancel,
                      size: 35,
                      color: violet7,
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
