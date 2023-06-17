import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/const.dart';
import '../controllers/initial_controller.dart';

class InitialView extends GetView<InitialController> {
  @override
  Widget build(BuildContext context) {
    Get.find<InitialController>();
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          SizedBox(height: size * 0.08),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('images/splash_top.png', width: size * 0.35),
              Expanded(child: Container()),
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Image.asset('assets/logo_prod.jpeg', width: size * 0.7),
          ),
          SizedBox(height: size * 0.03),
          Text(
            'PetNottoKu',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 45,
              fontFamily: 'Nunito',
            ),
          ),
          Flexible(
            child: Row(
              children: [
                Expanded(child: Container()),
                Image.asset('images/splash_bottom.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
