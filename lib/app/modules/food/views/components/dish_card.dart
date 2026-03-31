import 'package:flutter/material.dart';
import 'package:sora_manager/app/modules/dinnertables/views/constant.dart';

class DishCard extends StatelessWidget {
  DishCard({Key? key, this.name, this.price, this.urlOfImage, this.type})
      : super(key: key);
  final String? name, type, urlOfImage;
  final int? price;
  String imageLink = 'assets/images/others.png';
  @override
  Widget build(BuildContext context) {
    getImageLink();
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(30),
      ),
      child: Container(
          decoration: dishCardStyle,
          margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
          width: 300,
          child: Row(
            children: [
              Container(
                width: 110,
                height: double.infinity,
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
              )
            ],
          )),
    );
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
