import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  final size = Get.size.shortestSide;
  final bool mini;
  final bool nghiemTuc;

  LoadingWidget({
    this.mini = false,
    this.nghiemTuc = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ratio = mini ? 0.05 : 0.35;
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: nghiemTuc
            ? Lottie.asset(
                'images/loading.json',
                fit: BoxFit.cover,
                width: size * ratio,
                height: size * ratio,
              )
            : Image.asset(
                'images/load_cat_1.gif',
                fit: BoxFit.cover,
                width: size * ratio,
                height: size * ratio,
              ),
      ),
    );
  }
}
