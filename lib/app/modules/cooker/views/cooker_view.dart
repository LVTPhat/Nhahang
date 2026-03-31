import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sora_manager/app/data/helper/custom_scroll_behavior.dart';
import 'package:sora_manager/app/data/helper/datetime_helpers.dart';
import 'package:sora_manager/app/data/models/dinner_table.dart';
import 'package:sora_manager/app/data/models/dish_on_table.dart';
import 'package:sora_manager/app/modules/cooker/views/components/current_dish_view.dart';
import 'package:sora_manager/app/modules/cooker/views/components/dish_on_table_card.dart';
import 'package:sora_manager/app/modules/cooker/views/constant.dart';
import 'package:sora_manager/common/constant.dart';
import 'package:sora_manager/common/widgets/empty_screen.dart';
import 'package:sora_manager/common/widgets/loaders/custom_loader.dart';

import '../controllers/cooker_controller.dart';

class CookerView extends GetView<CookerController> {
  final int index = 0;
  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      decoration: bgStyle,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Row(
            children: [
              Container(
                  margin: EdgeInsets.only(right: 30),
                  width: 60,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 10),
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  'assets/images/iconrestaurant.png'),
                            ),
                          )),
                      buildNavBarItem(
                          context: context,
                          unSelectedIcon: Icons.dashboard_outlined,
                          selectedIcon: Icons.dashboard_rounded,
                          itemIndex: 0,
                          onTap: () {}),
                      buildNavBarItem(
                          context: context,
                          unSelectedIcon: Icons.logout_outlined,
                          selectedIcon: Icons.logout_rounded,
                          itemIndex: 1,
                          onTap: () {
                            controller.signOut();
                          }),
                    ],
                  ),
                  decoration: navbarStyle),
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
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
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
                                                    'assets/images/bep_avatar.jpg'),
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
                                                  'thien@bep.com',
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
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: width / 30.72,
                          right: width / 23.63,
                          top: height / 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 600,
                            height: 600,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width / 102.4, bottom: 30),
                                  child: Text(
                                    'Món ăn cần chế biến',
                                    style: inforTxt,
                                  ),
                                ),
                                Container(
                                  width: 600,
                                  height: 540,
                                  child: buildDishList(context),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 80),
                            width: 630,
                            height: 600,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width / 102.4, bottom: 30),
                                  child: Text(
                                    'Thông tin chi tiết món ăn',
                                    style: inforTxt,
                                  ),
                                ),
                                Container(
                                  width: 630,
                                  height: 540,
                                  decoration: dishCard,
                                  child: Obx(() => controller.isLoadCurrentDish
                                      ? LoadingScreen(height: height)
                                      : controller.isHaveDish
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  height: 140,
                                                  child: buildTableView(
                                                      context,
                                                      controller
                                                          .currentTableId),
                                                ),
                                                Container(
                                                  height: 200,
                                                  child: buildCurrentDishView(
                                                      context,
                                                      controller.currentTableId,
                                                      controller.currentDishId),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 30, right: 30),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30)),
                                                    child: Container(
                                                      height: 50,
                                                      width: double.infinity,
                                                      child: ElevatedButton(
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(
                                                                      violet6),
                                                        ),
                                                        onPressed: () {
                                                          controller.doneOneDish(
                                                              controller
                                                                  .currentTableId,
                                                              controller
                                                                  .currentDishId);
                                                        },
                                                        child: Text(
                                                          "Hoàn thành một món",
                                                          style: textButton,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : EmptyScreen(
                                              content:
                                                  'Không có bàn nào gọi món!')),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }

  Widget buildDishList(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var streamBuilder = StreamBuilder<List<DishOnTableModel>>(
        stream: controller.getDish(),
        builder: (BuildContext context,
            AsyncSnapshot<List<DishOnTableModel>> dishsSnapshot) {
          if (dishsSnapshot.hasError)
            return new Text('Error: ${dishsSnapshot.error}');
          switch (dishsSnapshot.connectionState) {
            case ConnectionState.waiting:
              return LoadingScreen(height: size.height);
            default:
              if (dishsSnapshot.data!.isEmpty) {
                return EmptyScreen(content: 'Chưa có bàn ăn nào gọi món!');
              }
              return ScrollConfiguration(
                behavior: MyCustomScrollBehavior(),
                child: ListView(
                    children:
                        dishsSnapshot.data!.map((DishOnTableModel dishOnTable) {
                  return InkWell(
                    child: DishCookerCard(
                      tableName: dishOnTable.tableName,
                      urlOfImage: dishOnTable.urlOfImage,
                      name: dishOnTable.name,
                      type: dishOnTable.type,
                      amount: dishOnTable.amount!,
                    ),
                    onTap: () {
                      controller.currentDishId = dishOnTable.id;
                      controller.currentTableId = dishOnTable.tableId;
                      controller.nameDish = dishOnTable.name!;
                      controller.nameTable = dishOnTable.tableName!;
                      controller.amount = dishOnTable.amount!;
                      controller.done = dishOnTable.done!;
                    },
                  );
                }).toList()),
              );
          }
        });
    return streamBuilder;
  }

  Widget buildTableView(BuildContext context, String tableId) {
    Size size = MediaQuery.of(context).size;
    var streamBuilder = StreamBuilder<DinnerTableModel>(
        stream: controller.getTable(tableId),
        builder: (BuildContext context, AsyncSnapshot<DinnerTableModel> table) {
          if (table.hasError) return new Text('Error: ${table.error}');
          switch (table.connectionState) {
            case ConnectionState.waiting:
              return LoadingScreen(height: size.height);
            default:
              if (table == null) {
                return EmptyScreen(content: 'Không tìm thấy bàn ăn!');
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    table.data!.tableName! +
                        ' (' +
                        table.data!.guestNumber!.toString() +
                        '/' +
                        table.data!.capacity!.toString() +
                        ')',
                    style: textTitle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Icon(
                          Icons.person,
                          size: 40,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: SizedBox(
                          width: 450,
                          height: 20,
                          child: LinearProgressIndicator(
                            value: table.data!.guestNumber! /
                                table.data!.capacity!,
                            valueColor: AlwaysStoppedAnimation(fgColorOfRate),
                            backgroundColor: bgColorOfRate,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 36,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/price.png'),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            table.data!.totalPrice == null
                                ? ''
                                : table.data!.totalPrice! == 0
                                    ? 'Bàn chưa gọi món'
                                    : table.data!.totalPrice!.toString() +
                                        'VNĐ',
                            style: textNormal,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
          }
        });
    return streamBuilder;
  }

  Widget buildCurrentDishView(
      BuildContext context, String tableId, String dishId) {
    Size size = MediaQuery.of(context).size;
    var streamBuilder = StreamBuilder<DishOnTableModel>(
        stream: controller.getCurrentDish(tableId, dishId),
        builder: (BuildContext context, AsyncSnapshot<DishOnTableModel> dish) {
          if (dish.hasError) return new Text('Error: ${dish.error}');
          switch (dish.connectionState) {
            case ConnectionState.waiting:
              return LoadingScreen(height: size.height);
            default:
              if (dish.data == null) {
                return EmptyScreen(content: 'Không tìm thấy món ăn!');
              }
              return CurrentDishViewOfCooker(
                type: dish.data!.type,
                name: dish.data!.name,
                urlOfImage: dish.data!.urlOfImage,
                done: dish.data!.done,
                amount: dish.data!.amount,
                price: dish.data!.price,
              );
          }
        });
    return streamBuilder;
  }

  Widget buildNavBarItem(
      {required BuildContext context,
      required IconData selectedIcon,
      required IconData unSelectedIcon,
      required int itemIndex,
      required GestureTapCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 60,
          width: 60,
          child: itemIndex == index
              ? Icon(
                  selectedIcon,
                  color: violet7,
                  size: 36,
                )
              : Icon(
                  unSelectedIcon,
                  color: violet5,
                  size: 28,
                )),
    );
  }
}
