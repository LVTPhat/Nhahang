import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sora_manager/app/data/helper/datetime_helpers.dart';
import 'package:sora_manager/app/modules/home/controllers/home_controller.dart';
import 'package:sora_manager/app/modules/home/views/constant.dart';
import 'package:sora_manager/common/constant.dart';

class NotificationCard extends StatelessWidget {
  NotificationCard(
      {Key? key,
      required this.controller,
      this.title,
      this.content,
      this.avatar,
      this.name,
      this.time,
      this.id})
      : super(key: key);
  final String? title, content, avatar, name, id;
  final Timestamp? time;
  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 8, right: 15, left: 15),
      height: 80,
      decoration: tableCardStyle,
      child: Stack(
        children: [
          Row(children: [
            Container(
                margin: EdgeInsets.only(right: 20, left: 10),
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(avatar ??
                        'https://firebasestorage.googleapis.com/v0/b/nha-hang-sora.appspot.com/o/avatar%2Fanh2.jpg?alt=media&token=2f7a3981-419b-42c3-8568-4a1ea9288c32'),
                  ),
                )),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name ?? 'Võ Tứ Thiên',
                          style: nameInNo,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 70),
                          child: Text(
                            getDateTime(),
                            style: datetimeInNO,
                          ),
                        ),
                      ]),
                  Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: Text(
                      content!,
                      style: contentInNO,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
          ]),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {
                      controller.deleteNotification(id!);
                    },
                    child: Icon(
                      Icons.cancel,
                      color: violet6,
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String getDateTime() {
    String datetime = '';
    datetime += DateTimeHelpers.timestampsToDate(time!) + ' ';
    datetime += DateTimeHelpers.timestampsToTime(time!);
    return datetime;
  }
}
