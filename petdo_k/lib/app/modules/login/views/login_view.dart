import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../common/const.dart';
import '../../../routes/app_pages.dart';
import '../../../views/my_country_list_picker.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    final oversize = Get.height < 836;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: defaultSystemUiOverlayStyle,
        child: Scaffold(
          resizeToAvoidBottomInset: oversize,
          body: oversize
              ? ListView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.only(
                    top: Get.mediaQuery.viewPadding.top,
                  ),
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: size * 0.11),
                      child: Image.asset(
                        'images/splash_logo.png',
                        width: size * 0.3,
                      ),
                    ),
                    main(oversize: oversize),
                  ],
                )
              : Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                        top: Get.mediaQuery.viewPadding.top,
                      ),
                      padding: EdgeInsets.symmetric(vertical: size * 0.11),
                      child: Image.asset(
                        'images/splash_logo.png',
                        width: size * 0.3,
                      ),
                    ),
                    Expanded(child: main(oversize: oversize)),
                  ],
                ),
        ),
      ),
    );
  }

  Widget main({required bool oversize}) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 40),

            /// Title Login
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                LocaleKeys.login_btn.tr,
                style: Get.textTheme.headline1,
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: CupertinoSlidingSegmentedControl(
                children: {
                  true: Text(
                    LocaleKeys.phone.tr,
                    style: Get.textTheme.button?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  false: Text(
                    LocaleKeys.email.tr,
                    style: Get.textTheme.button?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                },
                thumbColor: subPrimaryColor,
                backgroundColor: buttonDisableColor,
                groupValue: controller.loginByPhone.value,
                onValueChanged: (_) => controller.loginByPhone.toggle(),
              ),
            ),
            SizedBox(height: controller.loginByPhone.isTrue ? 16 : 24),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 0.5,
                  style: BorderStyle.solid,
                  color: borderColor,
                ),
              ),
              child: controller.loginByPhone.isTrue
                  ? Column(
                      children: [
                        SizedBox(height: 16),

                        /// Mã vùng
                        MyCountryListPick(
                          appBar: AppBar(
                            backgroundColor: primaryColor,
                            systemOverlayStyle: defaultSystemUiOverlayStyle,
                            toolbarHeight: toolbarHeight,
                            title: Text(
                              LocaleKeys.login_where_are_you_from.tr,
                              style: Get.textTheme.subtitle2?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            leading: InkWell(
                              onTap: () => Get.back(),
                              child: Icon(CupertinoIcons.arrow_left),
                            ),
                            leadingWidth: 60,
                          ),
                          pickerBuilder: (context, countryCode) => Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 10,
                                  child: ClipOval(
                                    child: Image.asset(
                                      countryCode?.flagUri ?? '',
                                      package: 'country_list_pick',
                                      fit: BoxFit.fitHeight,
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    '${countryCode?.name ?? ''} (${countryCode?.dialCode ?? ''})',
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.textTheme.headline6,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  size: 20,
                                )
                              ],
                            ),
                          ),
                          theme: CountryTheme(
                            isShowFlag: true,
                            isShowTitle: true,
                            isShowCode: true,
                            isDownIcon: false,
                            showEnglishName: false,
                            labelColor: subPrimaryColor,
                            searchText: LocaleKeys.search.tr,
                            searchHintText:
                                LocaleKeys.login_select_your_country.tr,
                            lastPickText: LocaleKeys.login_last_select.tr,
                          ),
                          initialSelection:
                              controller.country.value?.dialCode ?? '+84',
                          onChanged: (_) => controller.country.value = _,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Divider(),
                        ),

                        /// Phone
                        TextFormField(
                          cursorColor: subPrimaryColor,
                          style: Get.textTheme.headline6,
                          keyboardType: TextInputType.phone,
                          controller: controller.phoneController,
                          onChanged: (_) => controller.phoneNumber.value = _,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            hintText: LocaleKeys.enter_your_phone.tr,
                            contentPadding: EdgeInsets.only(
                              left: 21,
                              right: 21,
                            ),
                          ),
                        ),
                      ],
                    )
                  : TextFormField(
                      cursorColor: subPrimaryColor,
                      style: Get.textTheme.headline6,
                      keyboardType: TextInputType.emailAddress,
                      controller: controller.emailController,
                      onChanged: (_) => controller.email.value = _,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        hintText: LocaleKeys.enter_your_mail.tr,
                        contentPadding: EdgeInsets.only(
                          left: 21,
                          right: 21,
                        ),
                      ),
                    ),
            ),
            SizedBox(height: 24),

            /// Password
            TextFormField(
              style: Get.textTheme.headline6,
              cursorColor: subPrimaryColor,
              obscureText: controller.hidePassword.value,
              keyboardType: TextInputType.visiblePassword,
              controller: controller.passwordController,
              onChanged: (_) => controller.password.value = _,
              decoration: InputDecoration(
                labelText: LocaleKeys.password.tr,
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
            SizedBox(height: 25),

            /// Save password, forgot password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.saveLogin.toggle(),
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(top: 15, bottom: 10),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                controller.saveLogin.value
                                    ? CupertinoIcons.checkmark_square_fill
                                    : CupertinoIcons.square_fill,
                                size: 17,
                                color: controller.saveLogin.value
                                    ? subPrimaryColor
                                    : buttonDisableColor,
                              ),
                            ),
                            WidgetSpan(child: SizedBox(width: 7)),
                            TextSpan(
                              text: LocaleKeys.login_save_login.tr,
                              style: Get.textTheme.bodyText1,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.forgotPass(),
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(top: 15, bottom: 10),
                      child: Text(
                        LocaleKeys.login_forgot_password.tr,
                        maxLines: 3,
                        textAlign: TextAlign.right,
                        style: Get.textTheme.button?.copyWith(
                          color: subPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),

            /// Nút đăng nhập/login
            Container(
              width: double.infinity,
              child: ElevatedButton(
                child: Text(LocaleKeys.login_btn.tr),
                onPressed: controller.submit,
                // onPressed: null,
              ),
            ),
            SizedBox(height: 32),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: LocaleKeys.login_you_do_not_have_account.tr,
                    style: Get.textTheme.bodyText1,
                  ),
                  TextSpan(
                    text: LocaleKeys.register_btn.tr,
                    style: Get.textTheme.button?.copyWith(
                      color: subPrimaryColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap =
                          () => Get.offAllNamed(Routes.REGISTER_VERIFY_PHONE),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            oversize ? SizedBox(height: 22) : Spacer(),

            /// Sos
            sosCall,
          ],
        ),
      ),
    );
  }
}
