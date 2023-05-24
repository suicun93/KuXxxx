import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyGetxController<T extends GetConnect> extends GetxController {
  T? provider;

  @override
  @mustCallSuper
  void onInit() {
    super.onInit();
    provider = Get.find<T>();
  }
}
