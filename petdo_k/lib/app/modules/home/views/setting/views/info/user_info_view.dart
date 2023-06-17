import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:petdo_k/app/common/const.dart';
import 'package:petdo_k/app/modules/home/controllers/home_controller.dart';
import 'package:petdo_k/app/modules/home/views/setting/views/info/user_info_controller.dart';
import 'package:petdo_k/app/views/loading_view.dart';
import 'package:petdo_k/generated/locales.g.dart';

class UserInfoView extends GetView<UserInfoController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.back(),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Column(
          children: [
            AppBar(
              title: Text(LocaleKeys.account_info.tr),
              titleTextStyle: TextStyle(fontSize: 20),
              toolbarHeight: toolbarHeight,
              leading: InkWell(
                onTap: () => HomeController.instance.back(),
                child: Icon(CupertinoIcons.arrow_left),
              ),
              leadingWidth: 60,
            ),
            Expanded(
              child: Obx(() => controller.ready.value
                  ? Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: SingleChildScrollView(
                        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: EdgeInsets.only(left: 40, right: 40),
                        child: main(context: context),
                      ),
                    )
                  : LoadingWidget()),
            )
          ],
        ),
      ),
    );
  }

  Widget main({required BuildContext context}) {
    return Column(
      children: [
        SizedBox(height: 40),

        /// Name
        TextFormField(
          validator: (v) =>
              !(v?.isNotEmpty ?? false) ? LocaleKeys.name_invalid.tr : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: Get.textTheme.titleLarge,
          initialValue: controller.name.value,
          cursorColor: subPrimaryColor,
          readOnly: !controller.editMode.value,
          enabled: controller.editMode.value,
          keyboardType: TextInputType.name,
          onChanged: (_) => controller.name.value = _,
          decoration: InputDecoration(
            labelText: LocaleKeys.name.tr,
            contentPadding: EdgeInsets.only(left: 21),
          ),
        ),
        SizedBox(height: 24),

        TextFormField(
          validator: (v) => !(v?.isPhoneNumber ?? false)
              ? LocaleKeys.phone_number_invalid.tr
              : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: Get.textTheme.headline6,
          cursorColor: subPrimaryColor,
          keyboardType: TextInputType.phone,
          readOnly: !controller.editMode.value,
          enabled: controller.editMode.value,
          onChanged: (_) => controller.phone.value = _,
          controller: controller.phoneController,
          decoration: InputDecoration(
            labelText: LocaleKeys.phone.tr,
            hintText: LocaleKeys.enter_your_phone.tr,
            contentPadding: EdgeInsets.only(left: 21),
          ),
        ),
        SizedBox(height: 24),

        TextFormField(
          validator: (v) =>
              !(v?.isEmail ?? false) ? LocaleKeys.email_invalid.tr : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: Get.textTheme.headline6,
          readOnly: !controller.editMode.value,
          enabled: controller.editMode.value,
          cursorColor: subPrimaryColor,
          keyboardType: TextInputType.emailAddress,
          onChanged: (_) => controller.email.value = _,
          controller: controller.emailController,
          decoration: InputDecoration(
            labelText: LocaleKeys.email.tr,
            hintText: LocaleKeys.enter_your_mail.tr,
            contentPadding: EdgeInsets.only(left: 21),
          ),
        ),
        SizedBox(height: 24),

        /// Password
        TextFormField(
          validator: (v) => v.isPassword,
          autovalidateMode: AutovalidateMode.always,
          style: Get.textTheme.headline6,
          cursorColor: subPrimaryColor,
          obscureText: controller.hidePassword.value,
          keyboardType: TextInputType.visiblePassword,
          initialValue: controller.password.value,
          readOnly: !controller.editMode.value,
          enabled: controller.editMode.value,
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
        if (controller.editMode.value) SizedBox(height: 24),
        if (controller.editMode.value)
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
        SizedBox(height: 46),
        if (controller.editMode.value)
          Row(
            children: [
              SizedBox(width: 16),
              Expanded(
                child: TextButton(
                  onPressed: () => controller.editMode.value = false,
                  child: Text(
                    LocaleKeys.cancel.tr,
                  ),
                  style: Get.theme.textButtonTheme.style,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: checkEdit(context),
                  child: Text(LocaleKeys.finish_btn.tr),
                ),
              ),
              SizedBox(width: 16),
            ],
          ),

        /// Continue Button
        if (!controller.editMode.value)
          Container(
            width: double.infinity,
            child: ElevatedButton(
              child: Text(LocaleKeys.edit.tr),
              onPressed: () => controller.editMode.value = true,
              // onPressed: null,
            ),
          ),
      ],
    );
  }

  VoidCallback? checkEdit(BuildContext context) {
    if (controller.validToSubmit) {
      return () {
        controller.submit.then((value) {
          if (value) {
            controller.onReady();
          } else {
            Fluttertoast.showToast(msg: LocaleKeys.error.tr);
          }
        });
      };
    } else {
      return null;
    }
  }
}
