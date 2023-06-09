import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:petdo_k/utils.dart';

import '../../../../generated/locales.g.dart';
import '../../../common/const.dart';
import '../../../routes/app_pages.dart';
import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  @override
  Widget build(BuildContext context) {
    Get.find<WelcomeController>();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: defaultSystemUiOverlayStyle.copyWith(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: size * 0.3 + 10,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: primaryColor,
                        width: 4,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/logo_prod.jpeg',
                        width: size * 0.3,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'PetNottoKu',
                    style: TextStyle(
                      color: subPrimaryColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 45,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  Text(
                    LocaleKeys.welcome_welcome_to_petdo_k.tr,
                    textAlign: TextAlign.center,
                    style: Get.textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              width: double.infinity,
              child: ElevatedButton(
                child: Text(LocaleKeys.login_btn.tr),
                onPressed: () => Get.offNamed(Routes.LOGIN),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              width: double.infinity,
              child: TextButton(
                onPressed: () => Get.offNamed(Routes.HOME),
                child: Text(LocaleKeys.welcome_login_without_account.tr),
              ),
            ),
            SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
