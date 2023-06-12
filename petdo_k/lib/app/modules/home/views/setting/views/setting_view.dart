import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petdo_k/app/common/preferences.dart';
import 'package:petdo_k/app/modules/home/controllers/home_controller.dart';
import 'package:petdo_k/app/routes/app_pages.dart';
import 'package:petdo_k/generated/locales.g.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.back(),
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.all(20),
                    textStyle: TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: Color(0xFFF5F6F9),
                  ),
                  onPressed: () {
                    HomeController.instance.changeMainView(
                      MainView.userInfoView,
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.person_3_outlined,
                          color: Colors.black, size: 30),
                      SizedBox(width: 20),
                      Expanded(child: Text(LocaleKeys.account_info.tr)),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.all(20),
                    textStyle: TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: Color(0xFFF5F6F9),
                  ),
                  onPressed: () {
                    controller.deleteLocalInfo();
                    Get.offNamed(Routes.WELCOME);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app_outlined,
                          color: Colors.black, size: 30),
                      SizedBox(width: 20),
                      Expanded(child: Text(LocaleKeys.logout.tr)),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
