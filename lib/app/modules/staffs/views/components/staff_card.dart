import 'package:flutter/material.dart';
import 'package:sora_manager/app/modules/staffs/views/contant.dart';
import 'package:sora_manager/common/constant.dart';

class StaffCard extends StatelessWidget {
  StaffCard(
      {Key? key, this.name, this.avatar, this.email, this.phone, this.position})
      : super(key: key);
  final String? name, email, phone, position, avatar;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 15, 20, 10),
      decoration: staffCardStyle,
      width: 340,
      height: 120,
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.only(
                right: 15,
                left: 10,
              ),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(avatar ??
                      "https://firebasestorage.googleapis.com/v0/b/nha-hang-sora.appspot.com/o/avatar%2Fanh5.jpg?alt=media&token=908d2869-7599-4a15-aed3-3cb86fc273e0"),
                ),
              )),
          Flexible(
            child: Container(
              margin: EdgeInsets.only(top: 15, bottom: 10, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                      child: Text(
                    name!,
                    style: styleOfName,
                  )),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: violet7,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          position!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: styleOfInfor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.email,
                        color: violet7,
                      ),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            email!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: styleOfInfor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: violet7,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          phone!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: styleOfInfor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
