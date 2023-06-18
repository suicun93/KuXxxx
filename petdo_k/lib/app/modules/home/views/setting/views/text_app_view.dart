import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/home_controller.dart';

class TextAppView extends StatelessWidget {
  final String title;
  final String content;

  const TextAppView({Key? key, required this.title, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _appbar(context),
              Flexible(child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(content, style: Get.textTheme.labelLarge,),
              ))
            ],
          ),
        ),
      ),
    );
  }

   _appbar(BuildContext context) =>  Container(
    color: Colors.transparent,
    margin: EdgeInsets.only(
      top: Get.mediaQuery.viewPadding.top + 16,
      bottom: 16,
    ),
    alignment: Alignment.bottomCenter,
    child: Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: SizedBox(
            width: 60,
            child: Image.asset('images/ic_back.png', width: 16, height: 16),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(title, style: Get.textTheme.titleSmall),
          ),
        ),
        SizedBox(width: 60),
      ],
    ),
  );

}