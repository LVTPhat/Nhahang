import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sora_manager/app/data/helper/custom_scroll_behavior.dart';
import 'package:sora_manager/app/data/helper/datetime_helpers.dart';
import 'package:sora_manager/app/data/models/notification%20copy.dart';
import 'package:sora_manager/app/routes/app_pages.dart';
import 'package:sora_manager/common/constant.dart';
import 'package:sora_manager/common/widgets/loaders/custom_loader.dart';

Rx<bool> _isHaveNoti = false.obs;
bool get isHaveNoti => _isHaveNoti.value;
set isHaveNoti(value) => _isHaveNoti.value = value;

int oldLen = 99999999;

class NotificationIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    checkNoti();
    pushNoti();
    return Obx(() => IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                    backgroundColor: Colors.transparent,
                    child: NotificationView());
              });
        },
        icon: Icon(
          isHaveNoti ? Icons.notification_important_sharp : Icons.notifications,
          color: violet6,
        )));
  }

  static pushNoti() {
    NotificationView.getNotification().listen(
      (event) {
        if (oldLen < event.length) {
          Get.snackbar('Bạn có một yêu cầu thanh toán!',
              'Một yêu cầu thanh toán đã được gửi đến bạn, hãy xử lý nào');
        }
        oldLen = event.length;
      },
    );
  }

  Future<Null> checkNoti() async {
    var snap =
        await FirebaseFirestore.instance.collection('paymentrequest').get();
    if (snap.docs.length != 0) {
      isHaveNoti = true;
    } else {
      isHaveNoti = false;
    }
  }
}

class NotificationView extends StatelessWidget {
  static final cloudImage =
      "https://firebasestorage.googleapis.com/v0/b/nha-hang-sora.appspot.com/o/avatar%2Fanh5.jpg?alt=media&token=908d2869-7599-4a15-aed3-3cb86fc273e0";
  final cardStyle = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: [
        0.1,
        0.4,
        0.6,
      ],
      colors: [
        pink1,
        violet1,
        blue1,
      ],
    ),
    borderRadius: BorderRadius.circular(10),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 500,
        width: 500,
        decoration: cardStyle,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Danh sách yêu cầu thanh toán',
              style: TextStyle(
                color: violet7,
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
            Container(
              height: 440,
              child: ScrollConfiguration(
                  behavior: MyCustomScrollBehavior(),
                  child: buildNotifiCation(context)),
            ),
          ],
        ));
  }

  // stream builder
  Widget buildNotifiCation(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var streamBuilder = StreamBuilder<List<NotificationModel>>(
        stream: getNotification(),
        builder: (BuildContext context,
            AsyncSnapshot<List<NotificationModel>> notifiSnap) {
          if (notifiSnap.hasError)
            return new Text('Error: ${notifiSnap.error}');
          switch (notifiSnap.connectionState) {
            case ConnectionState.waiting:
              return LoadingScreen(height: size.height);
            default:
              if (notifiSnap.data!.isEmpty) {
                return buildEmpScreen(context);
              }
              return ListView(
                  children: notifiSnap.data!.map((NotificationModel notifi) {
                return InkWell(
                  child: NotifiCard(
                      notiId: notifi.id,
                      name: notifi.name,
                      avatar: notifi.avatar,
                      content: notifi.content,
                      time: notifi.time,
                      id: notifi.tableId),
                  onTap: () {},
                );
              }).toList());
          }
        });
    return streamBuilder;
  }

  // stream
  static Stream<List<NotificationModel>> getNotification() async* {
    var notificationStream;
    notificationStream = FirebaseFirestore.instance
        .collection('paymentrequest')
        .orderBy('time', descending: true)
        .limit(10)
        .snapshots();
    List<NotificationModel> notifications = [];
    await for (var notifiSnap in notificationStream) {
      notifications.clear();
      for (var notifiDoc in notifiSnap.docs) {
        var notifi = notifiDoc.data() as Map<String, dynamic>;
        notifi['id'] = notifiDoc.id;
        if (notifi.containsKey('from')) {
          DocumentSnapshot userRef = await notifi['from'].get();
          if (userRef.exists) {
            var user = userRef.data() as Map<String, dynamic>;
            notifi['name'] = user['name'];
            notifi['avatar'] = user['avatar'];
          }
        }
        NotificationModel noti = NotificationModel.fromJson(notifi);
        // ignore: prefer_conditional_assignment
        if (noti.avatar == null) {
          noti.avatar = cloudImage;
        }
        // ignore: prefer_conditional_assignment
        if (noti.name == null) {
          noti.name = 'Chưa cập nhật';
        }
        notifications.add(noti);
        isHaveNoti = true;
      }
      if (notifications.length == 0) {
        isHaveNoti = false;
      }
      yield notifications;
    }

    // get notification
  }

  // Tao mang hinh rong
  Widget buildEmpScreen(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 6.213,
          width: MediaQuery.of(context).size.width / 12.8,
          child: Image(
            image: AssetImage('assets/images/empty_icon.png'),
            fit: BoxFit.fill,
          ),
        ),
        Text(
          'Chưa có yêu cầu thanh toán nào!',
          style: TextStyle(
            color: violet7,
            fontSize: 18,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    ));
  }
}

class NotifiCard extends StatelessWidget {
  NotifiCard(
      {Key? key,
      this.title,
      this.content,
      this.avatar,
      this.name,
      this.time,
      this.notiId,
      this.id})
      : super(key: key);
  final String? title, content, avatar, name, id, notiId;
  final Timestamp? time;
  final cardStyle = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: [
        0.1,
        0.4,
        0.6,
      ],
      colors: [
        blue2,
        blue1,
        blue1,
      ],
    ),
    borderRadius: BorderRadius.circular(30),
    boxShadow: [
      BoxShadow(
        offset: Offset(0, 5),
        blurRadius: 10,
        color: blue7.withOpacity(0.3),
      ),
    ],
  );
  final TextStyle nameInNo = TextStyle(
    color: violet7,
    fontSize: 20,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
  );

  final TextStyle datetimeInNO = TextStyle(
      color: violet7,
      fontSize: 13,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.italic);

  final TextStyle contentInNO = TextStyle(
    color: violet4,
    fontSize: 18,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
      height: 100,
      width: double.infinity,
      decoration: cardStyle,
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
                    image: NetworkImage(avatar!),
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
                          name!,
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
                      FirebaseFirestore.instance
                          .collection('paymentrequest')
                          .doc(notiId)
                          .delete();
                      Get.offAllNamed(Routes.DINNERTABLES, arguments: id);
                    },
                    child: Icon(
                      Icons.call_missed_outgoing_rounded,
                      color: violet6,
                      size: 40,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {
                      FirebaseFirestore.instance
                          .collection('paymentrequest')
                          .doc(notiId)
                          .delete();
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
