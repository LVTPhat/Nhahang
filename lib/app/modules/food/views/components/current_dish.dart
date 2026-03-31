import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sora_manager/app/modules/food/controllers/food_controller.dart';
import 'package:sora_manager/app/modules/home/views/constant.dart';

class CurrentDish extends StatelessWidget {
  final FoodController controller = Get.find();
  String imageLink = 'assets/images/others.png';
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
          width: 300,
          child: Row(
            children: [
              Container(
                width: 260,
                height: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30)),
                  child: controller.currentDish.urlOfImage == null
                      ? Image(
                          image: AssetImage('assets/images/humburger.png'),
                          fit: BoxFit.fill,
                        )
                      : Image.network(
                          controller.currentDish.urlOfImage!,
                          fit: BoxFit.fill,
                        ),
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      controller.currentDish.name!,
                      style: styleOfTitle,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 36,
                            child: CircleAvatar(
                              backgroundImage: AssetImage(imageLink),
                              backgroundColor: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              controller.currentDish.type!,
                              style: normalText,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 36,
                            child: CircleAvatar(
                              backgroundImage: AssetImage(
                                  'assets/images/payment_status.jpg'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              controller.currentDish.price.toString() + ' VNĐ',
                              style: normalText,
                            ),
                          )
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

  void getImageLink() {
    switch (controller.currentDish.type) {
      case 'Món nướng':
        imageLink = 'assets/images/grill.png';
        break;
      case 'Món chiên':
        imageLink = 'assets/images/fried.png';
        break;
      case 'Món xào':
        imageLink = 'assets/images/stir.png';
        break;
      case 'Món hấp':
        imageLink = 'assets/images/steamed.jpg';
        break;
      case 'Thức uống':
        imageLink = 'assets/images/drink.png';
        break;
      default:
        imageLink = 'assets/images/others.png';
    }
  }
}
