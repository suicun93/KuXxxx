import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../common/const.dart';
import '../controllers/forgot_password_input_phone_mail_controller.dart';

class ForgotPasswordInputPhoneMailView
    extends GetView<ForgotPasswordInputPhoneMailController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.forgot_password_title.tr),
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
                      LocaleKeys.forgot_password_enter_email_phone.tr,
                      style: Get.textTheme.headline1,
                    ),
                    SizedBox(height: 40),

                    /// Password
                    TextFormField(
                      validator: (v) =>
                          (v!.isNotEmpty && (v.isPhoneNumber || v.isEmail))
                              ? null
                              : v.isNumericOnly
                                  ? LocaleKeys.phone_number_invalid.tr
                                  : LocaleKeys.email_invalid.tr,
                      autovalidateMode: AutovalidateMode.always,
                      style: Get.textTheme.headline6,
                      cursorColor: subPrimaryColor,
                      onChanged: (_) => controller.input.value = _,
                      decoration: InputDecoration(
                        labelText: LocaleKeys.forgot_password_email_phone.tr,
                        hintText: LocaleKeys
                            .forgot_password_enter_email_phone_registered.tr,
                        errorMaxLines: 2,
                        contentPadding: EdgeInsets.only(left: 21),
                      ),
                    ),
                    SizedBox(height: 32),

                    /// Finish Button
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text(LocaleKeys.forgot_password_send_otp.tr),
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
