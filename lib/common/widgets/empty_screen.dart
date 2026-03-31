import 'package:flutter/cupertino.dart';
import 'package:sora_manager/common/constant.dart';

class EmptyScreen extends StatelessWidget {
  EmptyScreen({Key? key, required this.content}) : super(key: key);
  final String content;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 6.213,
          width: MediaQuery.of(context).size.width / 12.8,
          child: Image(
            image: AssetImage('assets/images/empty_icon.png'),
            fit: BoxFit.fill,
          ),
        ),
        Text(
          content,
          style: txtEmt,
        )
      ],
    ));
  }
}
