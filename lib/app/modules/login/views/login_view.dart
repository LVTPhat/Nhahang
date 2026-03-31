import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sora_manager/app/data/services/size.dart';
import 'package:sora_manager/app/modules/login/views/constant.dart';
import 'package:sora_manager/common/constant.dart';
import 'package:sora_manager/common/widgets/custom_textformfield.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Color? color = violet2;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    Resize size = new Resize(width, height);
    return Container(
      decoration: bgStyle,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.83,
                      bottom: 10),
                  child: Text(
                    'votuthienb1805920di1896a2-@sora',
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // _buildLoginForm(context),
                  Container(
                    height: Resize.getSizeBaseOnHeight(500),
                    width: Resize.getSizeBaseOnWidth(900),
                    decoration: loginStyle,
                    child: Row(
                      children: [
                        buildIntroduce(context),
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(
                                        top: Resize.getSizeBaseOnHeight(10)),
                                    width: Resize.getSizeBaseOnWidth(120),
                                    height: Resize.getSizeBaseOnHeight(120),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                            'assets/images/iconrestaurant.png'),
                                      ),
                                    )),
                                Text(
                                  'Đăng nhập vào hệ thống',
                                  style: TextStyle(
                                      fontSize: Resize.getSizeChar(20),
                                      fontWeight: FontWeight.w600,
                                      color: violet7),
                                ),
                                _buildLoginForm(context),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: Resize.getSizeBaseOnWidth(20),
                                      right: Resize.getSizeBaseOnWidth(20)),
                                  child: Text(
                                    'Để sử dụng các tính năng bạn cần phải đăng nhập',
                                    style: TextStyle(
                                        fontSize: Resize.getSizeChar(16),
                                        fontWeight: FontWeight.w300,
                                        color: violet3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

// xay dung bang gioi thieu
  Widget buildIntroduce(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Resize.getSizeBaseOnWidth(550),
          height: Resize.getSizeBaseOnHeight(450),
          child: CarouselSlider.builder(
            carouselController: controller.carouselController,
            options: CarouselOptions(
                autoPlay: true,
                height: MediaQuery.of(context).size.width - 16,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                onPageChanged: (index, reason) {
                  controller.activeIndex.value = index;
                }),
            itemCount: controller.urlImages.length,
            itemBuilder: (context, index, realIndex) {
              final urlImage = controller.urlImages[index];
              final textBelowImage = controller.textBelowImages[index];
              final note = controller.notes[index];
              return buildImage(urlImage, textBelowImage, note, index);
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: Resize.getSizeBaseOnHeight(5)),
          child: Obx(() => buildIndicator()),
        )
      ],
    );
  }

  Widget buildImage(
          String urlImage, String textBelowImage, String note, int index) =>
      Container(
          margin: EdgeInsets.all(Resize.getSizeBaseOnWidth(10)),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(urlImage),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: Resize.getSizeBaseOnWidth(20),
                      right: Resize.getSizeBaseOnWidth(20)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: Resize.getSizeBaseOnHeight(5),
                              top: Resize.getSizeBaseOnHeight(15)),
                          child: Text(textBelowImage,
                              style: TextStyle(
                                  fontSize: Resize.getSizeChar(22),
                                  color: violet7)),
                        ),
                        Text(
                          note,
                          style: TextStyle(
                              color: violet3, fontSize: Resize.getSizeChar(16)),
                        )
                      ]),
                )
              ]));

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
        effect: SlideEffect(dotColor: color!, activeDotColor: primaryColor),
        activeIndex: controller.activeIndex.value,
        count: controller.urlImages.length);
  }

  Form _buildLoginForm(BuildContext context) {
    return Form(
        key: controller.formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(Resize.getSizeBaseOnWidth(26), 0,
                  Resize.getSizeBaseOnWidth(26), 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    style: styleOfTitle,
                    cursorColor: violet7,
                    decoration: buildDecorationTextFormField(
                        hintText: 'Email của bạn...', icon: Icons.email),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email không được rỗng";
                      } else if (!GetUtils.isEmail(value)) {
                        return "Vui lòng nhập email hợp lệ";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      controller.email = value!;
                    },
                  ),
                  SizedBox(height: Resize.getSizeBaseOnHeight(20)),
                  TextFormField(
                    style: styleOfTitle,
                    cursorColor: violet7,
                    obscureText: true,
                    decoration: buildDecorationTextFormField(
                        hintText: 'Mật khẩu...', icon: Icons.lock),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Mật khẩu không được rỗng';
                      } else if (value.length < 6) {
                        return 'Vui lòng nhập chính xác mật khẩu';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      controller.password = value!;
                    },
                  ),
                  SizedBox(height: Resize.getSizeBaseOnHeight(20)),
                  InkWell(
                    onTap: () {
                      controller.handleSignIn(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          vertical: Resize.getSizeBaseOnHeight(14)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: primaryColor,
                      ),
                      child: Text(
                        'Đăng nhập',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Resize.getSizeChar(18),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
