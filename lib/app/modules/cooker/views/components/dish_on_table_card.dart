import 'package:flutter/material.dart';
import 'package:sora_manager/app/modules/cooker/views/constant.dart';

class DishCookerCard extends StatelessWidget {
  DishCookerCard(
      {Key? key,
      this.urlOfImage,
      this.name,
      this.type,
      this.amount,
      this.tableName})
      : super(key: key);
  final String? urlOfImage, name, type, tableName;
  final int? amount;
  String imageLink = 'assets/images/others.png';
  @override
  Widget build(BuildContext context) {
    getImageLink();
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      height: 150,
      decoration: dishCard,
      child: Row(
        children: [
          Container(
            width: 150,
            height: 150,
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
                  name! + ' (' + tableName! + ')',
                  style: textTitle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
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
                              type ?? 'Món hấp',
                              style: textNormal,
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
                              backgroundImage:
                                  AssetImage('assets/images/total_icon.png'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              amount.toString() + ' Món',
                              style: textNormal,
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
        ],
      ),
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
