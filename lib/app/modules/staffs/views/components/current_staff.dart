import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sora_manager/app/data/helper/datetime_helpers.dart';
import 'package:sora_manager/app/modules/staffs/controllers/staffs_controller.dart';
import 'package:sora_manager/app/modules/staffs/views/contant.dart';
import 'package:sora_manager/common/constant.dart';

class CurrenStaff extends StatelessWidget {
  CurrenStaff(
      {Key? key,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.avatar,
      this.birthday,
      this.dayOfEmployment,
      this.sex})
      : super(key: key);
  String? name, email, phone, address, sex, avatar;
  Timestamp? birthday, dayOfEmployment;
  final StaffsController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: buildView(context),
        floatingActionButton: Container(
          height: 50,
          width: 50,
          child: FloatingActionButton.extended(
            heroTag: 'buttonEditStaffInfor',
            backgroundColor: violet7,
            onPressed: () {
              controller.initHint();
              controller.isUpdate = true;
            },
            label: Icon(
              Icons.mode,
            ),
          ),
        ));
  }

  Widget buildView(BuildContext context) => Container(
        decoration: staffCardStyle,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 30, top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: 20),
                          width: 112,
                          height: 112,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image:
                                  NetworkImage(avatar ?? controller.cloudImage),
                            ),
                          )),
                      Container(
                        height: 70,
                        width: 220,
                        margin: EdgeInsets.only(bottom: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name!,
                              style: nameText,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              email!,
                              style: informationText,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Divider(
                      thickness: 2,
                      color: violet4,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Ngày nhận việc',
                        style: keyText,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 28),
                        child: Text(
                          dayOfEmployment != null
                              ? DateTimeHelpers.timestampsToDate(
                                  dayOfEmployment!)
                              : 'Chưa cập nhật',
                          style: informationText,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 48),
                        child: Text(
                          'Ngày sinh',
                          style: keyText,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 28),
                        child: Text(
                          birthday != null
                              ? DateTimeHelpers.timestampsToDate(birthday!)
                              : 'Chưa cập nhật',
                          style: informationText,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 61),
                        child: Text(
                          'Giới tính',
                          style: keyText,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 28),
                        child: Text(
                          sex!,
                          style: informationText,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 74),
                        child: Text(
                          'Địa chỉ',
                          style: keyText,
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(left: 28),
                          child: Text(
                            address!,
                            style: informationText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 100),
                        child: Text(
                          'SĐT',
                          style: keyText,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 28),
                        child: Text(
                          phone!,
                          style: informationText,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
