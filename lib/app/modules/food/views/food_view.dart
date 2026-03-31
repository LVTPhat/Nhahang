import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sora_manager/app/data/helper/custom_scroll_behavior.dart';
import 'package:sora_manager/app/data/helper/datetime_helpers.dart';
import 'package:sora_manager/app/data/models/dish.dart';
import 'package:sora_manager/app/modules/dinnertables/views/components/custom_dialog.dart';
import 'package:sora_manager/app/modules/food/controllers/food_controller.dart';
import 'package:sora_manager/app/modules/food/views/components/current_dish.dart';
import 'package:sora_manager/app/modules/food/views/components/dish_card.dart';
import 'package:sora_manager/app/modules/food/views/components/edit_dish_view.dart';
import 'package:sora_manager/app/modules/food/views/components/food_chart.dart';
import 'package:sora_manager/app/modules/food/views/components/insert_new_dish_view.dart';
import 'package:sora_manager/app/modules/food/views/constant.dart';
import 'package:sora_manager/common/constant.dart';
import 'package:sora_manager/common/widgets/custom_navigationbar.dart';
import 'package:sora_manager/common/widgets/custom_notification.dart';
import 'package:sora_manager/common/widgets/loaders/custom_loader.dart';
import 'package:sora_manager/common/widgets/notification_icon.dart';

class FoodView extends GetView<FoodController> {
  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    controller.getFirstDish();
    return Obx(() => Container(
          decoration: bgStyle,
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  //Background(height: height),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomNavigationBar(
                        height: MediaQuery.of(context).size.height,
                        index: 2,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: width / 5.1,
                                      decoration: searchStyle,
                                      child: TextField(
                                          cursorColor: violet7,
                                          onChanged: (value) {
                                            controller.searchDishName = value;
                                          },
                                          controller: _controller,
                                          style: styleOfTitle,
                                          decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                _controller.clear();
                                                controller.searchDishName = '';
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
                                                    vertical: 0,
                                                    horizontal: 20),
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
                                          padding: EdgeInsets.only(
                                              left: width / 153.6),
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
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Võ Tứ Thiên',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: inforText,
                                                        ),
                                                        Text(
                                                          'thien@admin.com',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
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
                                  right: width / 23.63 - 5,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: width / 102.4),
                                          child: Text(
                                            'Thông tin món ăn',
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
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: height / 2.57,
                                                      width:
                                                          width / 2.076 - 220,
                                                      child: controller
                                                              .isLoadCurrentDish
                                                          ? LoadingScreen(
                                                              height: height)
                                                          : controller
                                                                  .isNullDish
                                                              ? buildEmpScreen(
                                                                  context)
                                                              : CurrentDish(),
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
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            30)),
                                                            child: Container(
                                                              height: 60,
                                                              width: 150,
                                                              child:
                                                                  ElevatedButton(
                                                                style: btnStyle,
                                                                onPressed:
                                                                    () async {
                                                                  if (!controller
                                                                      .isNullDish) {
                                                                    if (await controller.checkIsOder(controller
                                                                        .currentDish
                                                                        .dishID!)) {
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
                                                                                title: 'Không thể chỉnh sửa',
                                                                                content: 'Đã có bàn gọi món ăn này, bạn không thể chỉnh sửa nó!',
                                                                              ),
                                                                            );
                                                                          });
                                                                    } else {
                                                                      showModalBottomSheet(
                                                                          barrierColor: Colors.white.withOpacity(
                                                                              0),
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (context) {
                                                                            return EditDish();
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
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            30)),
                                                            child: Container(
                                                              height: 60,
                                                              width: 150,
                                                              child:
                                                                  ElevatedButton(
                                                                style: btnStyle,
                                                                onPressed:
                                                                    () {},
                                                                child: Text(
                                                                  "Khuyến mãi",
                                                                  style:
                                                                      txtButtonStyle,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            30)),
                                                            child: Container(
                                                              height: 60,
                                                              width: 150,
                                                              child:
                                                                  ElevatedButton(
                                                                style: btnStyle,
                                                                onPressed:
                                                                    () async {
                                                                  if (!controller
                                                                      .isNullDish) {
                                                                    if (await controller.checkIsOder(controller
                                                                        .currentDish
                                                                        .dishID!)) {
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
                                                                                title: 'Không thể xóa món ăn',
                                                                                content: 'Đã có bàn gọi món ăn này, bạn không thể xóa nó!',
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
                                                                              child: CustomDialog(
                                                                                onAgreeButton: () {
                                                                                  controller.deleteDish();
                                                                                  Get.back();
                                                                                },
                                                                                title: 'Xác nhận xóa món ăn',
                                                                                content: 'Bạn chắc chắn xóa món ăn này phải không?',
                                                                              ),
                                                                            );
                                                                          });
                                                                    }
                                                                  }
                                                                },
                                                                child: Text(
                                                                  "Xóa món ăn",
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
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    child: Container(
                                      height: height / 2.07,
                                      width: 550,
                                      margin:
                                          EdgeInsets.only(left: width / 34.13),
                                      child: IntrinsicWidth(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 20),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.pie_chart,
                                                    size: width / 48,
                                                    color: violet7,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: width / 192),
                                                    child: Text(
                                                      'Các biểu đồ có liên quan',
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
                                            Expanded(child: FoodChart()),
                                          ],
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
                                      padding:
                                          EdgeInsets.only(left: width / 102.4),
                                      child: Text(
                                        'Danh sách món ăn',
                                        style: TextStyle(
                                          color: violet7,
                                          fontSize: 23,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: height / 49.707,
                                          bottom: height / 149.12,
                                          left: 50),
                                      child: Row(
                                        children: <Widget>[
                                          buildNavBarItem(context, 'Tất cả', 0),
                                          buildNavBarItem(
                                              context, 'Món nướng', 1),
                                          buildNavBarItem(
                                              context, 'Món chiên', 2),
                                          buildNavBarItem(
                                              context, 'Món hấp', 3),
                                          buildNavBarItem(
                                              context, 'Món xào', 4),
                                          buildNavBarItem(
                                              context, 'Món khác', 5),
                                          buildNavBarItem(
                                              context, 'Thức uống', 6),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Obx(() => Container(
                                              height: 150,
                                              width: 1225,
                                              //  color: Colors.red[50],
                                              child: ScrollConfiguration(
                                                  behavior:
                                                      MyCustomScrollBehavior(),
                                                  child: buildDishList(
                                                      context,
                                                      controller
                                                          .searchDishName)),
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
                                                        barrierColor: Colors
                                                            .white
                                                            .withOpacity(0),
                                                        context: context,
                                                        builder: (context) {
                                                          return InsertDish();
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
              )),
        ));
  }

  Widget buildDishList(BuildContext context, String searchName) {
    Size size = MediaQuery.of(context).size;
    var streamBuilder = StreamBuilder<List<DishModel>>(
        stream: controller.getDish(searchName),
        builder: (BuildContext context,
            AsyncSnapshot<List<DishModel>> dishsSnapshot) {
          if (dishsSnapshot.hasError)
            return new Text('Error: ${dishsSnapshot.error}');
          switch (dishsSnapshot.connectionState) {
            case ConnectionState.waiting:
              return LoadingScreen(height: size.height);
            default:
              if (dishsSnapshot.data!.isEmpty) {
                return buildEmpScreen(context);
              }
              // controller.isNullDish = false;
              return ListView(
                  scrollDirection: Axis.horizontal,
                  children: dishsSnapshot.data!.map((DishModel dish) {
                    return InkWell(
                      child: DishCard(
                        name: dish.name,
                        type: dish.type,
                        price: dish.price,
                        urlOfImage: dish.urlOfImage,
                      ),
                      onTap: () {
                        controller.currentDish = dish;
                      },
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
          'Không tìm thấy món ăn nào!',
          style: styleOfTitle,
        )
      ],
    ));
  }

  Widget buildNavBarItem(BuildContext context, String type, int index) {
    return GestureDetector(
      onTap: () {
        controller.chooseIndex = index;
        controller.setTypeOfList(index);
      },
      child: Container(
        height: 30,
        width: 120,
        decoration: index == controller.chooseIndex
            ? BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 4, color: primaryColor)),
                gradient: LinearGradient(colors: [
                  primaryColor.withOpacity(0.3),
                  primaryColor.withOpacity(0.015)
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter))
            : BoxDecoration(),
        /*child: Icon(
          icon,
          color:
              index == controller.chooseIndex ? primaryColor : keyOrHintColor,
          size: index == controller.chooseIndex ? 32 : 26,
        ),*/
        child: Center(
          child: Text(type,
              style: TextStyle(
                color: violet7,
                fontSize: index == controller.chooseIndex ? 21 : 19,
              )),
        ),
      ),
    );
  }
}
