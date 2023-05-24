import 'package:country_list_pick/country_selection_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../common/const.dart';
import '../../../routes/app_pages.dart';
import '../../../views/my_country_list_picker.dart';
import '../controllers/register_verify_phone_controller.dart';

class RegisterVerifyPhoneView extends GetView<RegisterVerifyPhoneController> {
  @override
  Widget build(BuildContext context) {
    final oversize = Get.height < 698;
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
                      color: primaryColor,
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
                      color: primaryColor,
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

            /// Đăng ký
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                LocaleKeys.register_btn.tr,
                style: Get.textTheme.headline1,
              ),
            ),
            SizedBox(height: 18),
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
                groupValue: controller.registerByPhone.value,
                onValueChanged: (_) => controller.registerByPhone.toggle(),
              ),
            ),
            SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 0.5,
                  style: BorderStyle.solid,
                  color: borderColor,
                ),
              ),
              child: controller.registerByPhone.value
                  ? Column(
                      children: [
                        SizedBox(height: 16),
                        // Mã vùng
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
                          // if you need custom picker use this
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
                        TextFormField(
                          cursorColor: subPrimaryColor,
                          style: Get.textTheme.headline6,
                          keyboardType: TextInputType.phone,
                          onChanged: (_) => controller.phoneNumber.value = _,
                          controller: controller.phoneController,
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
                      onChanged: (_) => controller.email.value = _,
                      controller: controller.emailController,
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
            SizedBox(height: 32),
            // Nút tiếp tục
            Container(
              width: double.infinity,
              child: ElevatedButton(
                child: Text(LocaleKeys.continue_btn.tr),
                onPressed: controller.submit,
                // onPressed: null,
              ),
            ),
            SizedBox(height: 32),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: LocaleKeys.register_you_had_account_already.tr,
                    style: Get.textTheme.bodyText1,
                  ),
                  TextSpan(
                    text: LocaleKeys.login_btn.tr,
                    style: Get.textTheme.button?.copyWith(
                      color: subPrimaryColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Get.offAllNamed(Routes.LOGIN),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            oversize ? SizedBox(height: 22) : Spacer(),

            /// sos call
            sosCall,
          ],
        ),
      ),
    );
  }
}
