import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/const.dart';
import 'my_image.dart';

class DiseaseItem extends StatelessWidget {
  final String title;
  final String image;

  const DiseaseItem({
    required this.title,
    required this.image,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.33,
      height: Get.width * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            offset: Offset(0, 6),
            blurRadius: 30,
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        children: [
          Expanded(
            flex: 88,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                topLeft: Radius.circular(8),
              ),
              child: MyImage(link: image),
            ),
          ),
          Expanded(
            flex: 32,
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Get.textTheme.headline6,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ],
      ),
    );
  }
}
