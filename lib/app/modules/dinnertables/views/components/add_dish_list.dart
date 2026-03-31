import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sora_manager/app/data/helper/custom_scroll_behavior.dart';
import 'package:sora_manager/app/data/models/dish.dart';
import 'package:sora_manager/app/modules/dinnertables/controllers/dinnertables_controller.dart';
import 'package:sora_manager/app/modules/dinnertables/views/constant.dart';
import 'package:sora_manager/app/modules/food/views/components/dish_card.dart';
import 'package:sora_manager/common/constant.dart';
import 'package:sora_manager/common/widgets/loaders/custom_loader.dart';

class AddDishList extends StatelessWidget {
  AddDishList({Key? key});
  DinnertablesController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    TextEditingController _controller = new TextEditingController();

    return Obx(() => controller.isShowBottomSheet
        ? Container(
            height: 300,
            decoration: bottomSheetStyle,
            child: Container(
              //color: Colors.blue[50],
              margin: EdgeInsets.only(
                  top: height / 21.3, left: width / 31.13, right: width / 19.2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: width / 5.1,
                              decoration: searchStyle,
                              child: TextField(
                                  cursorColor: keyOrHintColor,
                                  onChanged: (value) {
                                    controller.searchDishName = value;
                                  },
                                  controller: _controller,
                                  style: styleOfTitle,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        controller.searchDishName = '';
                                        _controller.clear();
                                      },
                                      icon: Icon(
                                        Icons.clear,
                                        color: primaryColor,
                                      ),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: primaryColor,
                                    ),
                                    prefixIconColor: primaryColor,
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
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 40),
                          child: Center(
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
                        ),
                      ],
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
                        buildNavBarItem(context, 'Món nướng', 1),
                        buildNavBarItem(context, 'Món chiên', 2),
                        buildNavBarItem(context, 'Món hấp', 3),
                        buildNavBarItem(context, 'Món xào', 4),
                        buildNavBarItem(context, 'Món khác', 5),
                        buildNavBarItem(context, 'Thức uống', 6),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 150,
                        width: 1225,
                        //  color: Colors.red[50],
                        child: ScrollConfiguration(
                            behavior: MyCustomScrollBehavior(),
                            child: buildDishList(context)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 100),
                        child: Center(
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            child: Container(
                              height: 70,
                              width: 70,
                              child: ElevatedButton(
                                style: btnStyle,
                                child: Icon(
                                  Icons.check,
                                  size: 40,
                                ),
                                onPressed: () {
                                  controller.isShowBottomSheet = false;
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
          )
        : Container(
            height: 0,
          ));
  }

  Widget buildDishList(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var streamBuilder = StreamBuilder<List<DishModel>>(
        stream: controller.getDishList(controller.searchDishName),
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
                        if (!controller.isProcessing)
                          controller.findDish(dish.reference!);
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
                  fontSize: index == controller.chooseIndex ? 21 : 19,
                  color: violet7)),
        ),
      ),
    );
  }
}
