import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sora_manager/app/data/helper/custom_scroll_behavior.dart';
import 'package:sora_manager/app/data/helper/datetime_helpers.dart';
import 'package:sora_manager/app/data/models/user.dart';
import 'package:sora_manager/app/modules/staffs/views/components/add_staff.dart';
import 'package:sora_manager/app/modules/staffs/views/components/current_staff.dart';
import 'package:sora_manager/app/modules/staffs/views/components/staff_card.dart';
import 'package:sora_manager/app/modules/staffs/views/components/time_of_staff.dart';
import 'package:sora_manager/app/modules/staffs/views/components/updateCurrentUser.dart';
import 'package:sora_manager/app/modules/staffs/views/components/update_staff.dart';
import 'package:sora_manager/app/modules/staffs/views/contant.dart';
import 'package:sora_manager/common/constant.dart';
import 'package:sora_manager/common/widgets/background.dart';
import 'package:sora_manager/common/widgets/custom_navigationbar.dart';
import 'package:sora_manager/common/widgets/custom_notification.dart';
import 'package:sora_manager/common/widgets/loaders/custom_loader.dart';
import 'package:sora_manager/common/widgets/notification_icon.dart';

import '../controllers/staffs_controller.dart';

class StaffsView extends GetView<StaffsController> {
  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    controller.getFirstUser();
    controller.getPositionList();
    controller.getListPos();
    return Container(
      decoration: bgStyle,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              // Background(height: height),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomNavigationBar(
                    height: MediaQuery.of(context).size.height,
                    index: 3,
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
                                        controller.searchStaffName = value;
                                      },
                                      controller: _controller,
                                      style: styleOfTitle,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            _controller.clear();
                                            controller.searchStaffName = '';
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
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: width / 30.72,
                                  right: width / 23.63 - 5,
                                  top: height / 25),
                              child: Container(
                                width: 400,
                                height: 600,
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
                                        'Danh sách nhân viên',
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
                                          left: 15,
                                          right: 15,
                                          top: 15,
                                          bottom: 5),
                                      height: 35,
                                      child: Obx(() => ScrollConfiguration(
                                            behavior: MyCustomScrollBehavior(),
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              controller: ScrollController(),
                                              itemCount: controller
                                                  .positionList.length,
                                              itemBuilder: (context, index) {
                                                return buildNavBarItem(
                                                    context,
                                                    controller
                                                        .positionList[index]
                                                        .name!,
                                                    index);
                                              },
                                            ),
                                          )),
                                    ),
                                    Container(
                                        height: 500,
                                        width: double.infinity,
                                        child: Scaffold(
                                          body: Obx(() => ScrollConfiguration(
                                              behavior:
                                                  MyCustomScrollBehavior(),
                                              child: buildStaffList(
                                                  context,
                                                  controller.pos,
                                                  controller.searchStaffName))),
                                          backgroundColor: Colors.transparent,
                                          floatingActionButton:
                                              FloatingActionButton(
                                                  heroTag: 'btnAddStaff',
                                                  backgroundColor: violet7,
                                                  onPressed: () {
                                                    showDialog(
                                                        barrierDismissible:
                                                            false,
                                                        context: context,
                                                        builder: (context) {
                                                          return Dialog(
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              child:
                                                                  AddStaff());
                                                        });
                                                  },
                                                  child: Icon(Icons.add)),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  // left: width / 30.72,
                                  right: width / 23.63 - 5,
                                  top: height / 25),
                              child: Container(
                                width: 400,
                                height: 600,
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
                                        'Thông tin cá nhân',
                                        style: TextStyle(
                                          color: violet7,
                                          fontSize: 23,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Obx(() => Container(
                                          height: 540,
                                          width: double.infinity,
                                          decoration: staffCardStyle,
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(30),
                                              ),
                                              child: controller
                                                      .isLoadCurrentUser
                                                  ? LoadingScreen(
                                                      height: height)
                                                  : controller.isUpdate
                                                      ? UpdateInformation()
                                                      : buildCurrentStaff(
                                                          context,
                                                          controller
                                                              .currentUserID)),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: height / 25),
                              child: Container(
                                width: 400,
                                height: 600,
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
                                        'Thông tin nhân viên',
                                        style: TextStyle(
                                          color: violet7,
                                          fontSize: 23,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Obx(() => Container(
                                          height: 260,
                                          width: double.infinity,
                                          decoration: staffCardStyle,
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(30),
                                              ),
                                              child:
                                                  controller.isLoadCurrentUser
                                                      ? LoadingScreen(
                                                          height: height)
                                                      : buildUpdateStaff(
                                                          context,
                                                          controller
                                                              .currentUserID)),
                                        )),
                                    Container(
                                      height: 260,
                                      width: double.infinity,
                                      decoration: staffCardStyle,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(30),
                                        ),
                                        child: Stack(
                                          children: [
                                            //   Background(height: 540),
                                            Scaffold(
                                              floatingActionButton: Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 100),
                                                child: FloatingActionButton(
                                                  backgroundColor: violet6,
                                                  heroTag: 'buttonAddWorkTime',
                                                  onPressed: () {
                                                    controller.updateTimeWork();
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return Dialog(
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            child:
                                                                CustomNotification(
                                                              onAgreeButton:
                                                                  () {
                                                                Get.back();
                                                              },
                                                              title:
                                                                  'Thông báo',
                                                              content:
                                                                  'Thông tin về giờ làm việc của nhân viên đã được cập nhật',
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  child: Icon(Icons.check),
                                                ),
                                              ),
                                              backgroundColor:
                                                  Colors.transparent,
                                              body: Obx(() => controller
                                                      .isLoadingWorktimeData
                                                  ? LoadingScreen(
                                                      height: height)
                                                  : TimeOfStaff(
                                                      workdayCheck: controller
                                                          .workdaysCheck)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  Widget buildStaffList(
      BuildContext context, String position, String searchName) {
    Size size = MediaQuery.of(context).size;
    var streamBuilder = StreamBuilder<List<UserModel>>(
        stream: controller.getAllUser(position, searchName),
        builder: (BuildContext context,
            AsyncSnapshot<List<UserModel>> usersSnapshot) {
          if (usersSnapshot.hasError)
            return new Text('Error: ${usersSnapshot.error}');
          switch (usersSnapshot.connectionState) {
            case ConnectionState.waiting:
              return LoadingScreen(height: size.height);
            default:
              if (usersSnapshot.data!.isEmpty) {
                return buildEmpScreen('Không tìm thấy nhân viên nào!');
              }
              return ListView(
                  children: usersSnapshot.data!.map((UserModel user) {
                return InkWell(
                  child: InkWell(
                    child: StaffCard(
                      avatar: user.avatar,
                      position: user.position,
                      name: user.name,
                      email: user.email,
                      phone: user.phone,
                    ),
                  ),
                  onTap: () {
                    controller.currentUserID = user.id;
                    controller.isUpdate = false;
                    controller.getWorktimeData(user.id!);
                  },
                );
              }).toList());
          }
        });
    return streamBuilder;
  }

  Widget addStaff() {
    return Container();
  }

  Widget buildNavBarItem(BuildContext context, String type, int index) {
    return Obx(() => GestureDetector(
          onTap: () {
            controller.chooseIndex = index;
            controller.setTypeOfList(type);
          },
          child: Container(
            height: 30,
            width: 120,
            decoration: index == controller.chooseIndex
                ? BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 4, color: primaryColor)),
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
                      fontSize: index == controller.chooseIndex ? 21 : 19)),
            ),
          ),
        ));
  }

  Widget buildCurrentStaff(BuildContext context, String currentUserID) {
    Size size = MediaQuery.of(context).size;
    var streamBuilder = StreamBuilder<UserModel>(
        stream: controller.getCurrentUser(currentUserID),
        builder: (BuildContext context, AsyncSnapshot<UserModel> user) {
          if (user.hasError) return new Text('Error: ${user.error}');
          switch (user.connectionState) {
            case ConnectionState.waiting:
              return LoadingScreen(height: size.height);
            default:
              if (user == null) {
                return buildEmpScreen('Bàn ăn chưa gọi món!');
              }
              return CurrenStaff(
                avatar: user.data!.avatar,
                name: user.data!.name,
                phone: user.data!.phone,
                address: user.data!.address,
                email: user.data!.email,
                sex: user.data!.sex,
                birthday: user.data!.dateOfBirth,
                dayOfEmployment: user.data!.dateOfEmployment,
              );
          }
        });
    return streamBuilder;
  }

  Widget buildUpdateStaff(BuildContext context, String currentUserID) {
    Size size = MediaQuery.of(context).size;
    var streamBuilder = StreamBuilder<UserModel>(
        stream: controller.getCurrentUser(currentUserID),
        builder: (BuildContext context, AsyncSnapshot<UserModel> user) {
          if (user.hasError) return new Text('Error: ${user.error}');
          switch (user.connectionState) {
            case ConnectionState.waiting:
              return LoadingScreen(height: size.height);
            default:
              if (user == null) {
                return buildEmpScreen('Bàn ăn chưa gọi món!');
              }
              return UpdateStaff(
                salary: user.data!.salary,
                position: user.data!.position,
                dateGetJob: user.data!.dateOfEmployment,
              );
          }
        });
    return streamBuilder;
  }

  Widget buildEmpScreen(String content) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/images/empty_icon.png'),
            fit: BoxFit.fill,
          ),
          Text(
            content,
            style: styleOfTitle,
          )
        ],
      ),
    );
  }
}
