import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sora_manager/app/data/services/auth.dart';
import 'package:sora_manager/app/routes/app_pages.dart';
import 'package:sora_manager/common/constant.dart';

class CustomNavigationBar extends StatelessWidget {
  CustomNavigationBar({
    Key? key,
    required this.height,
    required this.index,
  }) : super(key: key);
  final double height;
  final int index;
  final AuthMethods authMethods = new AuthMethods();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 30),
      width: 60,
      height: height,
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
                  image: AssetImage('assets/images/iconrestaurant.png'),
                ),
              )),
          buildNavBarItem(
              context: context,
              unSelectedIcon: Icons.dashboard_outlined,
              selectedIcon: Icons.dashboard_rounded,
              itemIndex: 0,
              onTap: () {
                if (index != 0) Get.offAllNamed(Routes.HOME);
              }),
          buildNavBarItem(
              context: context,
              unSelectedIcon: Icons.dining_outlined,
              selectedIcon: Icons.dining_rounded,
              itemIndex: 1,
              onTap: () {
                if (index != 1) Get.offAllNamed(Routes.DINNERTABLES);
              }),
          buildNavBarItem(
              context: context,
              unSelectedIcon: Icons.dinner_dining_outlined,
              selectedIcon: Icons.dinner_dining_rounded,
              itemIndex: 2,
              onTap: () {
                if (index != 2) Get.offAllNamed(Routes.FOOD);
              }),
          buildNavBarItem(
              context: context,
              unSelectedIcon: Icons.person_outline,
              selectedIcon: Icons.person_rounded,
              itemIndex: 3,
              onTap: () {
                if (index != 3) Get.offAllNamed(Routes.STAFFS);
              }),
          buildNavBarItem(
              context: context,
              unSelectedIcon: Icons.calendar_today_outlined,
              selectedIcon: Icons.calendar_today_rounded,
              itemIndex: 4,
              onTap: () {
                if (index != 4) Get.offAllNamed(Routes.WORKTIME);
              }),
          buildNavBarItem(
              context: context,
              unSelectedIcon: Icons.pie_chart_outline_outlined,
              selectedIcon: Icons.pie_chart_rounded,
              itemIndex: 5,
              onTap: () {
                if (index != 5) Get.offAllNamed(Routes.STATISTICS);
              }),
          buildNavBarItem(
              context: context,
              unSelectedIcon: Icons.logout_outlined,
              selectedIcon: Icons.logout_rounded,
              itemIndex: 6,
              onTap: () {
                authMethods.signOut();
                Get.offAllNamed(Routes.LOGIN);
              }),
        ],
      ),
      decoration: BoxDecoration(
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
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            blurRadius: 10,
            color: blue3.withOpacity(0.3),
          ),
        ],
      ),
    );
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
