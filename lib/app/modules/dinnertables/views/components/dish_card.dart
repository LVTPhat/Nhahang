import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sora_manager/app/modules/dinnertables/controllers/dinnertables_controller.dart';
import 'package:sora_manager/app/modules/dinnertables/views/constant.dart';
import 'package:sora_manager/common/constant.dart';

class DishCard extends StatelessWidget {
  DishCard(
      {Key? key,
      this.name,
      this.price,
      this.urlOfImage,
      this.type,
      this.id,
      this.edited,
      this.amount})
      : super(key: key);
  final String? name, type, urlOfImage, id;
  final int? price, amount;
  int? edited;

  final DinnertablesController controller = Get.find();
  var _controller = TextEditingController();
  String imageLink = 'assets/images/others.png';
  @override
  Widget build(BuildContext context) {
    getImageLink();
    return Obx(() => ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          child: Container(
              decoration: dishCardStyle,
              margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              width: 300,
              height: 120,
              child: Row(
                children: [
                  Container(
                    width: 110,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30)),
                      child: urlOfImage == null
                          ? Image(
                              image: AssetImage('assets/images/humburger.png'),
                              fit: BoxFit.fill,
                            )
                          : Image.network(
                              urlOfImage!,
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          name!,
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
                                  type!,
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
                                  price!.toString() + ' VNĐ',
                                  style: normalText,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 120,
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                // Tang so luong
                                if (!controller.isPrRR)
                                  controller.riseDishMount(id!, amount!);
                              },
                              child: Icon(
                                Icons.arrow_drop_up,
                                color: violet6,
                                size: 49,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (!controller.isPrRR)
                                  controller.reduceDishMount(id!, amount!);
                              },
                              child: Icon(
                                Icons.arrow_drop_down,
                                color: violet6,
                                size: 49,
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: _controller,
                            cursorColor: violet6,
                            style: styleOfTitle,
                            decoration: InputDecoration(
                              hintText: controller.isLoadText
                                  ? edited.toString()
                                  : amount!.toString(),
                              prefixIconColor: primaryColor,
                              hintStyle: styleOfTitle,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 8),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: violet6,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: violet6),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: secondaryColor),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: secondaryColor),
                              ),
                            ),
                            onSubmitted: (value) async {
                              if (GetUtils.isNum(value)) {
                                edited = int.parse(value);
                                controller.changeDishMount(
                                    id!, int.parse(value), _controller);
                              } else {
                                _controller.clear();
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            controller.deleteDishOnTable(id!);
                          },
                          child: Icon(
                            Icons.cancel,
                            color: violet6,
                            size: 40,
                          ),
                        ),
                        InkWell(
                          child: Icon(
                            Icons.note_alt,
                            color: violet6,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }

  void getImageLink() {
    switch (type) {
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
