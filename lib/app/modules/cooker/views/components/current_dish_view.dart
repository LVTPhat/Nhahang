import 'package:flutter/material.dart';
import 'package:sora_manager/app/modules/cooker/views/constant.dart';

class CurrentDishViewOfCooker extends StatelessWidget {
  CurrentDishViewOfCooker(
      {Key? key,
      this.amount,
      this.done,
      this.price,
      this.urlOfImage,
      this.name,
      this.type,
      this.id})
      : super(key: key);
  final String? urlOfImage, name, id, type;
  final int? price, amount, done;
  String imageLink = 'assets/images/others.png';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 200,
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                name!,
                style: textTitle,
              ),
              Container(
                height: 140,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                                child: Container(
                                  width: 120,
                                  child: Text(
                                    type ?? 'Món hấp',
                                    style: textNormal,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                          ),
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
                                child: Container(
                                  // height: 50,
                                  width: 130,
                                  child: Text(
                                    price!.toString() + ' VNĐ',
                                    style: textNormal,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 36,
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/numberof.png'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              'Đã hoàn thành ' +
                                  done.toString() +
                                  '/' +
                                  amount.toString() +
                                  ' Món',
                              style: textNormal,
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Icon(
                            Icons.dinner_dining_sharp,
                            size: 34,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: SizedBox(
                            width: 300,
                            height: 15,
                            child: LinearProgressIndicator(
                              value: done! / amount!,
                              valueColor: AlwaysStoppedAnimation(fgColorOfRate),
                              backgroundColor: bgColorOfRate,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
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
