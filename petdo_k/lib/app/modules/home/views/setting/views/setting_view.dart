import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:petdo_k/app/common/const.dart';
import 'package:petdo_k/app/modules/home/views/setting/views/text_app_view.dart';
import 'package:petdo_k/app/routes/app_pages.dart';
import 'package:petdo_k/app/views/loading_view.dart';
import 'package:petdo_k/generated/locales.g.dart';

import '../../../controllers/home_controller.dart';
import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.back(),
      child: Obx(
        () => LoaderOverlay(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: controller.token.value == null
                ? Center(child: LoadingWidget())
                : (controller.token.value?.isEmpty ?? true)
                    ? Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 80),
                              child: Image.asset('images/pending.png'),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Text(
                                LocaleKeys.login_to_use.tr,
                                textAlign: TextAlign.center,
                                style: Get.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: textColorDefault,
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: ElevatedButton(
                                onPressed: () => Get.offAllNamed(Routes.LOGIN),
                                child: Text(LocaleKeys.login_btn.tr),
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: TextButton(
                                onPressed: () => Get.offAllNamed(
                                    Routes.REGISTER_VERIFY_PHONE),
                                child: Text(LocaleKeys.register_btn.tr),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Stack(
                        children: [
                          SingleChildScrollView(
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.only(top: 50),
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: Get.size.width,
                                    child: Text(LocaleKeys.profile.tr,
                                        style: Get.textTheme.titleSmall),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context.loaderOverlay.show();
                                      controller.getImage().then((value) {
                                        context.loaderOverlay.hide();
                                      });
                                    },
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(80),
                                                child: controller.image.value !=
                                                        null
                                                    ? Image.file(
                                                        File(
                                                          controller.image
                                                              .value!.path,
                                                        ),
                                                        width: 156,
                                                        height: 156,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : (controller.token
                                                                    .isEmpty ==
                                                                true ||
                                                            controller.imageUrl
                                                                .isEmpty)
                                                        ? Icon(
                                                            Icons
                                                                .account_circle,
                                                            color: Colors.grey,
                                                            size: 156,
                                                          )
                                                        : Image.network(
                                                            controller
                                                                .imageUrl.value,
                                                            width: 156,
                                                            height: 156,
                                                            fit: BoxFit.cover,
                                                          ),
                                              ),
                                              SizedBox(height: 16),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: subPrimaryColor,
                                            ),
                                            padding: EdgeInsets.all(8),
                                            child: Image.asset(
                                              'images/ic_camera.png',
                                              color: Colors.white,
                                              width: 16,
                                              height: 16,
                                            ),
                                          ),
                                          bottom: 30,
                                          right:
                                              (controller.image.value != null ||
                                                      controller
                                                          .imageUrl.isNotEmpty)
                                                  ? (size - 126) / 2 - 16
                                                  : (size - 120) / 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: Get.size.width,
                                    child: Text(
                                        controller.token.isEmpty == true
                                            ? LocaleKeys.guest.tr
                                            : (controller.phone.value.isNotEmpty
                                                ? controller.phone.value
                                                : controller.email.value),
                                        style: Get.textTheme.titleSmall),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: Get.size.width / 3,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: subPrimaryColor,
                                              width: 1.5),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Text(
                                        LocaleKeys.change_password.tr,
                                        style: Get.textTheme.labelLarge
                                            ?.copyWith(color: subPrimaryColor),
                                      ),
                                    ),
                                    onTap: () =>
                                        HomeController.instance.changeMainView(
                                      MainView.passwordInfo,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  _settingSection(
                                      context,
                                      LocaleKeys.policy_and_terms.tr,
                                      'images/ic_terms.png',
                                      termsAndPolicy),
                                  _settingSection(
                                      context,
                                      LocaleKeys.about_us.tr,
                                      'images/ic_about_us.png',
                                      aboutUs),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 40),
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.deleteLocalInfo();
                                  Get.offNamed(Routes.WELCOME);
                                },
                                child: Text(
                                  LocaleKeys.logout.tr,
                                  style: TextStyle(fontSize: 14),
                                ),
                                style: _redElevatedButtonTheme?.copyWith(padding:  MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(20))),
                              ),
                            ),
                            alignment: Alignment.bottomCenter,
                          )
                        ],
                      ),
          ),
        ),
      ),
    );
  }

  _settingSection(
      BuildContext context, String title, String iconUrl, String content) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(24),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [defaultBoxShadow],
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: [
            Image.asset(iconUrl, height: 20),
            SizedBox(width: 10),
            Expanded(
                child: Text(
              title,
              style: Get.textTheme.labelLarge,
            )),
            Icon(Icons.arrow_forward_ios, size: 14,),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    TextAppView(title: title, content: content)));
      },
    );
  }

  ButtonStyle? get _redElevatedButtonTheme {
    return Get.theme.elevatedButtonTheme.style?.copyWith(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (states) =>
            states.contains(MaterialState.disabled) ? buttonDisableColor : red,
      ),
    );
  }
}
