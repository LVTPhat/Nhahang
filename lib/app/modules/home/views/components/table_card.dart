import 'package:flutter/material.dart';
import 'package:sora_manager/app/modules/home/views/constant.dart';

class TableCard extends StatelessWidget {
  TableCard(
      {Key? key,
      this.tableName,
      this.capacity,
      this.guestNumber,
      this.paymentStatus,
      this.tableStatus})
      : super(key: key);
  final String? tableName, paymentStatus, tableStatus;
  final int? capacity, guestNumber;
  @override
  Widget build(BuildContext context) {
    final String imageLink = getImageLink();
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          child: Container(
              decoration: tableCardStyle,
              margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
              width: 400,
              height: 150,
              child: Row(
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30)),
                      child: Image(
                        image: AssetImage(imageLink),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          tableName!.toString() +
                              ' (' +
                              guestNumber.toString() +
                              '/' +
                              capacity.toString() +
                              ')',
                          style: styleOfTableName,
                        ),
                        SizedBox(
                          width: 150,
                          height: 10,
                          child: LinearProgressIndicator(
                            value: guestNumber! / capacity!,
                            valueColor: AlwaysStoppedAnimation(fgColorOfRate),
                            backgroundColor: bgColorOfRate,
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
                                  paymentStatus!,
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
                                      'assets/images/table_status.png'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Text(
                                  tableStatus!,
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
        ),
        Container(
          margin: EdgeInsets.only(top: 90, left: 340),
          height: 100,
          width: 100,
          child: paymentStatus == 'Đã thanh toán'
              ? Image(
                  image: AssetImage('assets/images/paid.png'),
                )
              : null,
        ),
      ],
    );
  }

  String getImageLink() {
    switch (tableStatus) {
      case 'Đã được đặt':
        return 'assets/images/booked_table.jpg';
      case 'Trống':
        return 'assets/images/empty_table.jpg';
    }
    return 'assets/images/eating_table.jpg';
  }
}
