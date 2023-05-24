import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../common/const.dart';
import '../controllers/forgot_password_input_new_controller.dart';

class ForgotPasswordInputNewView
    extends GetView<ForgotPasswordInputNewController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.forgot_password_title_new.tr),
          toolbarHeight: toolbarHeight,
          leading: InkWell(
            onTap: () => Get.back(),
            child: Icon(CupertinoIcons.arrow_left),
          ),
          leadingWidth: 60,
        ),
        body: Container(
          padding: EdgeInsets.only(left: 40, right: 40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Obx(
            () => ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
                Column(
                  children: [
                    SizedBox(height: 40),
                    Text(
                      LocaleKeys.forgot_password_enter_new_password.tr,
                      style: Get.textTheme.headline1,
                    ),
                    SizedBox(height: 40),

                    /// Password
                    TextFormField(
                      validator: (v) => v.isPassword,
                      autovalidateMode: AutovalidateMode.always,
                      style: Get.textTheme.headline6,
                      cursorColor: subPrimaryColor,
                      obscureText: controller.hidePassword.value,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (_) => controller.password.value = _,
                      decoration: InputDecoration(
                        labelText: LocaleKeys.password.tr,
                        hintText: LocaleKeys.password_hint.tr,
                        errorMaxLines: 3,
                        contentPadding: EdgeInsets.only(left: 21),
                        suffixIcon: GestureDetector(
                          onTap: () => controller.hidePassword.toggle(),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.remove_red_eye_rounded,
                              color: controller.hidePassword.value
                                  ? buttonDisableColor
                                  : subPrimaryColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    TextFormField(
                      validator: (v) => !((v?.isNotEmpty ?? false) &&
                              v.toString() == controller.password.value)
                          ? LocaleKeys.password_not_match.tr
                          : null,
                      autovalidateMode: AutovalidateMode.always,
                      style: Get.textTheme.headline6,
                      cursorColor: subPrimaryColor,
                      obscureText: controller.hidePassword.value,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (_) => controller.confirmPassword.value = _,
                      decoration: InputDecoration(
                        labelText: LocaleKeys.confirmPassword.tr,
                        errorMaxLines: 2,
                        contentPadding: EdgeInsets.only(left: 21),
                        suffixIcon: GestureDetector(
                          onTap: () => controller.hidePassword.toggle(),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.remove_red_eye_rounded,
                              color: controller.hidePassword.value
                                  ? buttonDisableColor
                                  : subPrimaryColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 32),

                    /// Finish Button
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text(LocaleKeys.finish_btn.tr),
                        onPressed: controller.submit,
                        // onPressed: null,
                      ),
                    ),
                    SizedBox(height: 32),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
