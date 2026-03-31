import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sora_manager/app/data/helper/custom_scroll_behavior.dart';
import 'package:sora_manager/app/data/helper/datetime_helpers.dart';
import 'package:sora_manager/app/data/models/dinner_table.dart';
import 'package:sora_manager/app/data/models/dish_on_table.dart';
import 'package:sora_manager/app/modules/dinnertables/controllers/dinnertables_controller.dart';
import 'package:sora_manager/app/modules/dinnertables/views/components/add_dish_list.dart';
import 'package:sora_manager/app/modules/dinnertables/views/components/current_table_view.dart';
import 'package:sora_manager/app/modules/dinnertables/views/components/custom_dialog.dart';
import 'package:sora_manager/app/modules/dinnertables/views/components/dish_card.dart';
import 'package:sora_manager/app/modules/dinnertables/views/components/edit_table_view.dart';
import 'package:sora_manager/app/modules/dinnertables/views/components/insert_new_table_view.dart';
import 'package:sora_manager/app/modules/dinnertables/views/components/print_bill_view.dart';
import 'package:sora_manager/app/modules/dinnertables/views/constant.dart';
import 'package:sora_manager/app/modules/home/views/components/table_card.dart';
import 'package:sora_manager/common/constant.dart';
import 'package:sora_manager/common/widgets/custom_navigationbar.dart';
import 'package:sora_manager/common/widgets/custom_notification.dart';
import 'package:sora_manager/common/widgets/loaders/custom_loader.dart';
import 'package:sora_manager/common/widgets/notification_icon.dart';

class DinnertablesView extends GetView<DinnertablesController> {
  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    controller.getFirstTable();
    return Scaffold(
        bottomSheet: AddDishList(),
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
                    index: 1,
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
                                      onChanged: (value) {
                                        controller.searchTableName = value;
                                      },
                                      controller: _controller,
                                      style: styleOfTitle,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            _controller.clear();
                                            controller.searchTableName = '';
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
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 0, horizontal: 20),
                                        border: textFeildBorder,
                                        enabledBorder: textFeildBorder,
                                        focusedBorder: textFeildBorder,
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide(
                                                color: secondaryColor)),
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
                                      padding:
                                          EdgeInsets.only(left: width / 153.6),
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

                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: width / 102.4),
                                      child: Text(
                                        'Thông tin bàn ăn',
                                        style: TextStyle(
                                          color: violet7,
                                          fontSize: 23,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Obx(() => Container(
                                          height: height / 2.57,
                                          width: width / 2.076,
                                          decoration: cardStyle,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(30),
                                            ),
                                            child: Stack(
                                              children: [
                                                //Background(
                                                //   height: height / 2.57),
                                                Row(children: [
                                                  Row(
                                                    children: [
                                                      controller
                                                              .isLoadCurrentTable
                                                          ? Container(
                                                              height:
                                                                  height / 2.57,
                                                              width: width /
                                                                      2.076 -
                                                                  220,
                                                              child:
                                                                  LoadingScreen(
                                                                      height:
                                                                          height),
                                                            )
                                                          : controller
                                                                  .isNullTable
                                                              ? Container(
                                                                  height:
                                                                      height /
                                                                          2.57,
                                                                  width: width /
                                                                          2.076 -
                                                                      220,
                                                                  child: buildEmpScreen(
                                                                      context,
                                                                      'Không tìm thấy bàn ăn nào! '))
                                                              : CurrentTable(
                                                                  height:
                                                                      height /
                                                                          2.57,
                                                                  width: width /
                                                                          2.076 -
                                                                      220,
                                                                ),
                                                      Container(
                                                        height: height / 2.57,
                                                        width: 220,
                                                        margin: EdgeInsets.only(
                                                          top: 10,
                                                          bottom: 10,
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          30)),
                                                              child: Container(
                                                                height: 60,
                                                                width: 150,
                                                                child:
                                                                    ElevatedButton(
                                                                  style:
                                                                      btnStyle,
                                                                  onPressed:
                                                                      () {
                                                                    if (!controller
                                                                        .isNullTable) {
                                                                      if (controller
                                                                              .currentTable
                                                                              .guestNumber ==
                                                                          0) {
                                                                        controller
                                                                            .initValueOfTable();
                                                                        showModalBottomSheet(
                                                                            barrierColor: Colors.white.withOpacity(
                                                                                0),
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return EditTable();
                                                                            });
                                                                      } else {
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return Dialog(
                                                                                backgroundColor: Colors.transparent,
                                                                                child: CustomNotification(
                                                                                  onAgreeButton: () {
                                                                                    Get.back();
                                                                                  },
                                                                                  title: 'Nhắc nhỡ',
                                                                                  content: 'Bạn không thể chỉnh sửa bằn ăn này khi nó đang được sử dụng!!',
                                                                                ),
                                                                              );
                                                                            });
                                                                      }
                                                                    }
                                                                  },
                                                                  child: Text(
                                                                    "Chỉnh sửa",
                                                                    style:
                                                                        txtButtonStyle,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            ClipRRect(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          30)),
                                                              child: Container(
                                                                height: 60,
                                                                width: 150,
                                                                child:
                                                                    ElevatedButton(
                                                                  style:
                                                                      btnStyle,
                                                                  onPressed:
                                                                      () {
                                                                    if (!controller
                                                                        .isNullTable) {
                                                                      if (controller
                                                                              .currentTable
                                                                              .guestNumber !=
                                                                          0) {
                                                                        //controller
                                                                        //  .payForTable();
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return Dialog(
                                                                                  backgroundColor: Colors.transparent,
                                                                                  child: PrintBill(
                                                                                    controller: controller,
                                                                                  ));
                                                                            });
                                                                      } else {
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return Dialog(
                                                                                backgroundColor: Colors.transparent,
                                                                                child: CustomNotification(
                                                                                  onAgreeButton: () {
                                                                                    Get.back();
                                                                                  },
                                                                                  title: 'Nhắc nhỡ',
                                                                                  content: 'Bàn ăn trống!!',
                                                                                ),
                                                                              );
                                                                            });
                                                                      }
                                                                    }
                                                                  },
                                                                  child: Text(
                                                                    "Thanh toán",
                                                                    style:
                                                                        txtButtonStyle,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            ClipRRect(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          30)),
                                                              child: Container(
                                                                height: 60,
                                                                width: 150,
                                                                child:
                                                                    ElevatedButton(
                                                                  style:
                                                                      btnStyle,
                                                                  onPressed:
                                                                      () {
                                                                    if (!controller
                                                                        .isNullTable) {
                                                                      if (controller
                                                                              .currentTable
                                                                              .guestNumber ==
                                                                          0) {
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return Dialog(
                                                                                backgroundColor: Colors.transparent,
                                                                                child: CustomDialog(
                                                                                  onAgreeButton: () {
                                                                                    Get.back();
                                                                                    controller.deleteDinnerTable();
                                                                                  },
                                                                                  title: 'Xác nhận xóa bàn ăn',
                                                                                  content: 'Bạn chắc chắn xóa bàn ăn này phải không?',
                                                                                ),
                                                                              );
                                                                            });
                                                                      } else {
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return Dialog(
                                                                                backgroundColor: Colors.transparent,
                                                                                child: CustomNotification(
                                                                                  onAgreeButton: () {
                                                                                    Get.back();
                                                                                  },
                                                                                  title: 'Nhắc nhỡ',
                                                                                  content: 'Bạn không thể xóa bằn ăn này khi nó đang được sử dụng!!',
                                                                                ),
                                                                              );
                                                                            });
                                                                      }
                                                                    }
                                                                  },
                                                                  child: Text(
                                                                    "Xóa bàn ăn",
                                                                    style:
                                                                        txtButtonStyle,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ]),
                                              ],
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                child: Container(
                                  height: height / 2.13,
                                  width: 540,
                                  margin: EdgeInsets.only(left: width / 34.13),
                                  child: IntrinsicWidth(
                                    child: Scaffold(
                                      floatingActionButton: Container(
                                        height: 70,
                                        width: 70,
                                        child: FloatingActionButton(
                                          backgroundColor: violet6,
                                          onPressed: () {
                                            if (controller
                                                    .currentTable.guestNumber ==
                                                0) {
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
                                                            'Bạn hãy cho biết số lượng khách của bàn ăn!!',
                                                      ),
                                                    );
                                                  });
                                            } else {
                                              controller.isShowBottomSheet =
                                                  true;
                                            }
                                            //controller.isShowBottomSheet = true;
                                          },
                                          child: Icon(
                                            Icons.add,
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                      backgroundColor: Colors.transparent,
                                      body: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .dinner_dining_outlined,
                                                      size: width / 48,
                                                      color: violet7,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: width / 192),
                                                      child: Text(
                                                        'Danh sách món ăn',
                                                        style: TextStyle(
                                                          color: violet7,
                                                          fontSize: 20,
                                                          fontFamily: 'Roboto',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 20),
                                                child: TextButton(
                                                    onPressed: () {},
                                                    child: Text(
                                                      'Xem thêm',
                                                      style: TextStyle(
                                                        color: blue4,
                                                        fontSize: 16,
                                                        fontFamily: 'Roboto',
                                                        fontWeight:
                                                            FontWeight.w200,
                                                      ),
                                                    )),
                                              )
                                            ],
                                          ),
                                          Obx(
                                            () => Expanded(
                                              child: controller
                                                      .isLoadCurrentTable
                                                  ? LoadingScreen(
                                                      height: height)
                                                  : ScrollConfiguration(
                                                      behavior:
                                                          MyCustomScrollBehavior(),
                                                      child: buildDishList(
                                                          context,
                                                          controller
                                                              .currentTable
                                                              .tableID!)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Container(
                            //color: Colors.blue[50],
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
                                Row(
                                  children: [
                                    Obx(() => Container(
                                          margin: EdgeInsets.only(
                                              top: height / 49.707),
                                          height: height / 3.728,
                                          width: 1225,
                                          //  color: Colors.red[50],
                                          child: ScrollConfiguration(
                                              behavior:
                                                  MyCustomScrollBehavior(),
                                              child: buildAllTableList(context,
                                                  controller.searchTableName)),
                                        )),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Center(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(100)),
                                          child: Container(
                                            height: 70,
                                            width: 70,
                                            child: ElevatedButton(
                                              style: btnStyle,
                                              child: Icon(
                                                Icons.add,
                                                size: 40,
                                              ),
                                              onPressed: () {
                                                showModalBottomSheet(
                                                    barrierColor: Colors.white
                                                        .withOpacity(0),
                                                    context: context,
                                                    builder: (context) {
                                                      return AddTable();
                                                    });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
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

  Widget buildDishView(BuildContext context) {
    return Obx(() => Expanded(
          child: controller.isLoadCurrentTable
              ? LoadingScreen(height: MediaQuery.of(context).size.height)
              : ScrollConfiguration(
                  behavior: MyCustomScrollBehavior(),
                  child:
                      buildDishList(context, controller.currentTable.tableID!)),
        ));
  }

  Widget buildAllTableList(BuildContext context, searchName) {
    Size size = MediaQuery.of(context).size;
    var streamBuilder = StreamBuilder<List<DinnerTableModel>>(
        stream: controller.getAllTable(searchName),
        builder: (BuildContext context,
            AsyncSnapshot<List<DinnerTableModel>> dinnerTablesSnapshot) {
          if (dinnerTablesSnapshot.hasError)
            return new Text('Error: ${dinnerTablesSnapshot.error}');
          switch (dinnerTablesSnapshot.connectionState) {
            case ConnectionState.waiting:
              return LoadingScreen(height: size.height);
            default:
              if (dinnerTablesSnapshot.data!.isEmpty) {
                return buildEmpScreen(context, 'Không tìm thấy bàn ăn nào!');
              }
              return ListView(
                  scrollDirection: Axis.horizontal,
                  children: dinnerTablesSnapshot.data!
                      .map((DinnerTableModel dinnerTable) {
                    return InkWell(
                      child: TableCard(
                        tableName: dinnerTable.tableName,
                        tableStatus: dinnerTable.tableStatus,
                        paymentStatus: dinnerTable.paymentStatus,
                        guestNumber: dinnerTable.guestNumber,
                        capacity: dinnerTable.capacity,
                      ),
                      onTap: () {
                        controller.newGuestNum = dinnerTable.guestNumber!;
                        controller.currentTable = dinnerTable;
                        controller.currentTableStatus = dinnerTable.tableStatus;
                      },
                    );
                  }).toList());
          }
        });
    return streamBuilder;
  }

  Widget buildDishList(BuildContext context, String currentTableId) {
    Size size = MediaQuery.of(context).size;
    var streamBuilder = StreamBuilder<List<DishOnTableModel>>(
        stream: controller.getDish(currentTableId),
        builder: (BuildContext context,
            AsyncSnapshot<List<DishOnTableModel>> dishsSnapshot) {
          if (dishsSnapshot.hasError)
            return new Text('Error: ${dishsSnapshot.error}');
          switch (dishsSnapshot.connectionState) {
            case ConnectionState.waiting:
              return LoadingScreen(height: size.height);
            default:
              if (dishsSnapshot.data!.isEmpty) {
                return buildEmpScreen(context, 'Bàn ăn chưa gọi món!');
              }
              return ListView(
                  children:
                      dishsSnapshot.data!.map((DishOnTableModel dishOnTable) {
                return InkWell(
                  child: DishCard(
                    name: dishOnTable.name,
                    type: dishOnTable.type,
                    price: dishOnTable.price,
                    urlOfImage: dishOnTable.urlOfImage,
                    amount: dishOnTable.amount,
                    id: dishOnTable.id,
                    edited: dishOnTable.amount,
                  ),
                  onTap: () {},
                );
              }).toList());
          }
        });
    return streamBuilder;
  }

  Widget buildEmpScreen(BuildContext context, String content) {
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
          content,
          style: styleOfTitle,
        )
      ],
    ));
  }
}
