import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../generated/locales.g.dart';
import '../../../common/const.dart';
import '../controllers/register_verify_otp_controller.dart';

class RegisterVerifyOtpView extends GetView<RegisterVerifyOtpController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.register_confirm_otp.tr),
          toolbarHeight: toolbarHeight,
          leading: InkWell(
            onTap: () => Get.back(),
            child: Icon(CupertinoIcons.arrow_left),
          ),
          leadingWidth: 60,
        ),
        body: Container(
          width: double.infinity,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        LocaleKeys.system_sent_otp_to.trParams({
                          'something': controller.registerByPhone.isTrue
                              ? LocaleKeys.phone_number.tr
                              : LocaleKeys.email.tr,
                        }),
                        textAlign: TextAlign.center,
                        style: Get.textTheme.bodyText2,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      controller.registerByPhone.isTrue
                          ? controller.phone.value
                          : controller.email.value,
                      style: Get.textTheme.headline6
                          ?.copyWith(color: subPrimaryColor),
                    ),
                    SizedBox(height: 34),
                    Text(
                      LocaleKeys.enter_otp_here.tr,
                      style: Get.textTheme.bodyText2,
                    ),
                    SizedBox(height: 18),

                    /// PinCode
                    PinCodeTextField(
                      appContext: context,
                      textStyle: Get.textTheme.headline1,
                      backgroundColor: Colors.transparent,
                      mainAxisAlignment: MainAxisAlignment.center,
                      pastedTextStyle: Get.textTheme.headline1,
                      length: 4,
                      showCursor: false,
                      obscureText: false,
                      useHapticFeedback: true,
                      blinkWhenObscuring: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        fieldWidth: 53,
                        fieldHeight: 64,
                        fieldOuterPadding: EdgeInsets.only(left: 8, right: 8),
                        borderRadius: BorderRadius.circular(8),
                        borderWidth: 1,
                        selectedColor: buttonDisableColor,
                        selectedFillColor: Colors.transparent,
                        inactiveColor: buttonDisableColor,
                        inactiveFillColor: Colors.transparent,
                        activeColor: buttonDisableColor,
                        activeFillColor: Colors.transparent,
                      ),
                      autoFocus: true,
                      // cursorColor: Colors.black,
                      animationDuration: Duration(milliseconds: 300),
                      enableActiveFill: true,
                      keyboardType: TextInputType.number,
                      // onCompleted: (_) async => controller.confirmCode(),
                      onChanged: (_) => controller.code.value = _,
                      beforeTextPaste: (text) {
                        print('Allowing to paste $text');
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return false;
                      },
                    ),
                    SizedBox(height: 32),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text(LocaleKeys.finish_btn.tr),
                        onPressed: controller.code.value.length != 4
                            ? null
                            : () => controller.confirmCode(),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () =>
                          showSnackBar(LocaleKeys.not_supported_yet.tr),
                      child: Text(
                        LocaleKeys.not_receive_otp_yet.tr,
                        style: Get.textTheme.button?.copyWith(
                          color: subPrimaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
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
