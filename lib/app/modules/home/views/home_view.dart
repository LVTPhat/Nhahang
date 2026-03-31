import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sora_manager/app/data/helper/custom_scroll_behavior.dart';
import 'package:sora_manager/app/data/helper/datetime_helpers.dart';
import 'package:sora_manager/app/data/models/dinner_table.dart';
import 'package:sora_manager/app/data/models/notification%20copy.dart';
import 'package:sora_manager/app/modules/home/views/components/notification_card.dart';
import 'package:sora_manager/app/modules/home/views/components/table_card.dart';
import 'package:sora_manager/app/modules/home/views/constant.dart';
import 'package:sora_manager/app/routes/app_pages.dart';
import 'package:sora_manager/common/constant.dart';
import 'package:sora_manager/common/widgets/custom_navigationbar.dart';
import 'package:sora_manager/common/widgets/loaders/custom_loader.dart';
import 'package:sora_manager/common/widgets/notification_icon.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    //controller.getUserInfo();

    return Scaffold(
        body: Container(
      decoration: bgStyle,
      child: Stack(
        children: [
          //  Background(height: height),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomNavigationBar(
                height: MediaQuery.of(context).size.height,
                index: 0,
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: height / 50.1),
                      height: height / 12.2,
                      child: Padding(
                        padding: EdgeInsets.only(right: width / 51),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: width / 5.1,
                              decoration: searchStyle,
                              child: TextField(
                                  cursorColor: violet7,
                                  onChanged: (value) {},
                                  controller: _controller,
                                  style: styleOfTitle,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        _controller.clear();
                                      },
                                      icon: Icon(
                                        Icons.clear,
                                        color: violet7,
                                      ),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: violet7,
                                    ),
                                    prefixIconColor: violet7,
                                    hintText: 'Tìm kiếm',
                                    hintStyle: styleOfHint,
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
                                  )),
                            ), //ket thuc khung tim kiem
                            Container(
                              width: width / 7.68,
                              child: Row(children: [
                                Icon(
                                  Icons.calendar_today_rounded,
                                  color: violet7,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width / 153.6),
                                  child: Text(
                                    DateTimeHelpers.getDateTimeNow(),
                                    style: dateTimeText,
                                  ),
                                )
                              ]),
                            ),
                            Container(
                              width: width / 4.8,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.message_outlined,
                                    color: violet7,
                                  ),
                                  NotificationIcon(),
                                  Container(
                                    width: width / 6.4,
                                    child: Row(
                                      children: [
                                        Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: AssetImage(
                                                    'assets/images/admin_avatar.jpg'),
                                              ),
                                            )),
                                        Flexible(
                                          child: Container(
                                            height: height / 12.4,
                                            margin: EdgeInsets.only(
                                                left: width / 109.71),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Võ Tứ Thiên',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: inforText,
                                                ),
                                                Text(
                                                  'thien@admin.com',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: inforText,
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ), // ket thuc phan top nav
                    Container(
                      margin: EdgeInsets.only(
                          left: width / 30.72,
                          right: width / 23.63,
                          top: height / 25),
                      child: Row(
                        children: [
                          Container(
                            width: width / 2.076,
                            height: height / 2.15,
                            //color: Colors.amber[50],
                            child: Stack(
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: width / 102.4),
                                      child: Text(
                                        'Bảng điều khiển',
                                        style: TextStyle(
                                          color: violet7,
                                          fontSize: 23,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: height / 2.57,
                                      width: width / 2.076,
                                      decoration: cardStyle,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(30),
                                        ),
                                        child: Stack(
                                          children: [
                                            // Background(
                                            //   height: height / 2.57),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: width / 30.72,
                                                  top: height / 37.3,
                                                  bottom: height / 37.3),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      'Chào quản lý!',
                                                      style: TextStyle(
                                                        color: violet7,
                                                        fontSize: 32,
                                                        fontFamily: 'Roboto',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Hôm nay chúng ta sẽ làm gì?',
                                                      style: TextStyle(
                                                        color: violet5,
                                                        fontSize: 20,
                                                        fontFamily: 'Roboto',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .arrow_forward,
                                                                  color: blue4,
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: width /
                                                                          192),
                                                                  child:
                                                                      TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Get.offAllNamed(Routes.DINNERTABLES);
                                                                          },
                                                                          child: Text(
                                                                              'Quản lý bàn ăn',
                                                                              style: txtStyle)),
                                                                )
                                                              ],
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: height /
                                                                          74.56),
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .arrow_forward,
                                                                    color:
                                                                        blue4,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left: width /
                                                                            192),
                                                                    child: TextButton(
                                                                        onPressed: () {
                                                                          Get.offAllNamed(
                                                                              Routes.FOOD);
                                                                        },
                                                                        child: Text('Quản lý món ăn', style: txtStyle)),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: width /
                                                                      102.4),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .arrow_forward,
                                                                    color:
                                                                        blue4,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left: width /
                                                                            192),
                                                                    child: TextButton(
                                                                        onPressed: () {
                                                                          Get.offAllNamed(
                                                                              Routes.WORKTIME);
                                                                        },
                                                                        child: Text('Quản lý giờ làm việc', style: txtStyle)),
                                                                  )
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    top: height /
                                                                        74.56),
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .arrow_forward,
                                                                      color:
                                                                          blue4,
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left: width /
                                                                              192),
                                                                      child: TextButton(
                                                                          onPressed: () {
                                                                            Get.offAllNamed(Routes.STATISTICS);
                                                                          },
                                                                          child: Text(
                                                                            'Thống kê doanh thu',
                                                                            style:
                                                                                txtStyle,
                                                                          )),
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: width / 3.614),
                                  child: Image(
                                    image: AssetImage(
                                        'assets/images/kuma_icon_home.png'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: height / 2.13,
                              margin: EdgeInsets.only(left: width / 34.13),
                              child: IntrinsicWidth(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons
                                                    .notifications_none_rounded,
                                                size: width / 48,
                                                color: violet7,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: width / 192),
                                                child: Text(
                                                  'Thông báo',
                                                  style: TextStyle(
                                                    color: violet7,
                                                    fontSize: 20,
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: 20),
                                          child: TextButton(
                                              onPressed: () {},
                                              child: Text(
                                                'Xem thêm',
                                                style: TextStyle(
                                                  color: blue4,
                                                  fontSize: 16,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w200,
                                                ),
                                              )),
                                        )
                                      ],
                                    ),
                                    Expanded(
                                      child: ScrollConfiguration(
                                        behavior: MyCustomScrollBehavior(),
                                        child: buildNotifiCation(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    Flexible(
                      child: Container(
                        //   color: Colors.blue[50],
                        margin: EdgeInsets.only(
                            top: height / 21.3,
                            left: width / 31.13,
                            right: width / 19.2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: width / 102.4),
                              child: Text(
                                'Danh sách bàn ăn',
                                style: TextStyle(
                                  color: violet7,
                                  fontSize: 23,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: height / 49.707),
                              height: height / 3.728,
                              //color: Colors.red[50],
                              child: ScrollConfiguration(
                                  behavior: MyCustomScrollBehavior(),
                                  child: buildAllTableList(context)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }

  Widget buildAllTableList(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var streamBuilder = StreamBuilder<List<DinnerTableModel>>(
        stream: controller.getAllTable(),
        builder: (BuildContext context,
            AsyncSnapshot<List<DinnerTableModel>> dinnerTablesSnapshot) {
          if (dinnerTablesSnapshot.hasError)
            return new Text('Error: ${dinnerTablesSnapshot.error}');
          switch (dinnerTablesSnapshot.connectionState) {
            case ConnectionState.waiting:
              return LoadingScreen(height: size.height);
            default:
              if (dinnerTablesSnapshot.data!.isEmpty) {
                return buildEmpScreen(context);
              }
              return ListView(
                  scrollDirection: Axis.horizontal,
                  children: dinnerTablesSnapshot.data!
                      .map((DinnerTableModel dinnerTable) {
                    return TableCard(
                      tableName: dinnerTable.tableName,
                      tableStatus: dinnerTable.tableStatus,
                      paymentStatus: dinnerTable.paymentStatus,
                      guestNumber: dinnerTable.guestNumber,
                      capacity: dinnerTable.capacity,
                    );
                  }).toList());
          }
        });
    return streamBuilder;
  }

  Widget buildNotifiCation(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var streamBuilder = StreamBuilder<List<NotificationModel>>(
        stream: controller.getNotification(),
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
                  child: NotificationCard(
                    controller: controller,
                    id: notifi.id,
                    name: notifi.name,
                    avatar: notifi.avatar,
                    content: notifi.content,
                    time: notifi.time,
                  ),
                  onTap: () {},
                );
              }).toList());
          }
        });
    return streamBuilder;
  }

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
          'Không tìm thấy bàn ăn nào!',
          style: styleOfTitle,
        )
      ],
    ));
  }
}
