import 'package:flutter/material.dart';
import 'package:sora_manager/app/data/services/size.dart';
import 'package:sora_manager/app/modules/worktime/views/constant.dart';
import 'package:sora_manager/common/constant.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {Key? key,
      required this.percent,
      required this.onTap,
      required this.icon,
      required this.color,
      required this.buttonName,
      required this.buttonContent})
      : super(key: key);

  final IconData icon;
  final String buttonName, buttonContent;
  final Color color;
  final GestureTapCallback onTap;
  final int percent;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: Resize.getSizeBaseOnHeight(90),
        width: Resize.getSizeBaseOnWidth(260),
        decoration: btnDecoration,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                color: color,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: Resize.getSizeBaseOnWidth(8)),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                  height: Resize.getSizeBaseOnHeight(90),
                  color: percent == 100
                      ? Colors.white
                      : Color.fromARGB(255, 229, 239, 250),
                  child: Row(children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: Resize.getSizeBaseOnWidth(10)),
                      child: Icon(icon,
                          size: Resize.getSizeChar(40), color: violet7),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(Resize.getSizeChar(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              buttonName,
                              style: buttonTitleStyle,
                            ),
                            Text(
                              buttonContent,
                              maxLines: 2,
                              style: buttonContentStyle,
                            ),
                          ],
                        ),
                      ),
                    )
                  ]),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: Resize.getSizeBaseOnWidth(14),
                  right: Resize.getSizeBaseOnWidth(6)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: Resize.getSizeBaseOnWidth(260),
                    height: Resize.getSizeBaseOnHeight(6),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: LinearProgressIndicator(
                        value: percent / 100,
                        valueColor: AlwaysStoppedAnimation(
                            percent == 100 ? Colors.white : color),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
