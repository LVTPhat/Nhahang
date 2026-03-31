import 'package:flutter/material.dart';
import 'package:sora_manager/app/modules/dinnertables/views/constant.dart';
import 'package:sora_manager/common/constant.dart';

class CustomNotification extends StatelessWidget {
  CustomNotification(
      {Key? key,
      this.title,
      this.content,
      required this.onAgreeButton,
      this.titleOfButton});
  final String? title, content, titleOfButton;
  final GestureTapCallback onAgreeButton;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 400,
          height: 200,
          decoration: cardStyle,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                title!,
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.w400, color: violet7),
              ),
              Container(
                height: 110,
                margin: EdgeInsets.only(left: 30, right: 70),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      content!,
                      style: TextStyle(fontSize: 20, color: violet5),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Container(
                      width: 300,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            child: Container(
                              height: 40,
                              width: 120,
                              child: ElevatedButton(
                                style: acceptBtnStyle,
                                onPressed: onAgreeButton,
                                child: Text(
                                  titleOfButton != null
                                      ? titleOfButton!
                                      : "Đồng ý",
                                  style: txtButtonStyle,
                                ),
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
        Container(
          padding: EdgeInsets.only(left: 300),
          child: SizedBox(
            height: 200,
            width: 170,
            child: Image(
              image: AssetImage(
                'assets/images/kuma_icon_home.png',
              ),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }
}
