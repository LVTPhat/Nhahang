import 'package:flutter/material.dart';

import 'package:sora_manager/app/modules/statistics/views/constant.dart';
import 'package:sora_manager/app/modules/worktime/views/constant.dart';
import 'package:sora_manager/common/constant.dart';

class CardTableView extends StatelessWidget {
  CardTableView({Key? key, this.name, this.revenue, this.totalRevenue})
      : super(key: key);
  final String? name;
  final int? revenue, totalRevenue;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
      width: 170,
      decoration: scheduleCardStyle,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              name!,
              style: tableName,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  child: CircularProgressIndicator(
                    value: revenue!.toDouble() / totalRevenue!,
                    color: blue4,
                    backgroundColor: Colors.white,
                  ),
                ),
                Text(
                  (revenue!.toDouble() / 1000000).toStringAsFixed(2) + ' tr',
                  style: revenueStyle,
                ),
              ],
            ),
            Text(
              (revenue!.toDouble() / totalRevenue! * 100).toStringAsFixed(1) +
                  '% so với tổng doanh thu',
              style: noteStyle,
            )
          ],
        ),
      ),
    );
  }
}
