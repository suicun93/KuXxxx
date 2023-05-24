import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../common/const.dart';
import '../../../routes/app_pages.dart';
import '../controllers/register_success_controller.dart';

class RegisterSuccessView extends GetView<RegisterSuccessController> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: defaultSystemUiOverlayStyle.copyWith(
        systemNavigationBarColor: primaryColor,
        systemNavigationBarDividerColor: primaryColor,
      ),
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('images/success.png', width: size * 0.5),
                  SizedBox(height: 20),
                  Text(
                    LocaleKeys.register_success.tr,
                    textAlign: TextAlign.center,
                    style: Get.textTheme.subtitle2?.copyWith(
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                bottom: 37 + Get.mediaQuery.viewPadding.bottom,
                right: 40,
                left: 40,
              ),
              child: ElevatedButton(
                onPressed: () => Get.offAllNamed(Routes.LOGIN),
                child: Text(LocaleKeys.go_to_login.tr),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
