import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../generated/locales.g.dart';

part 'styles.dart';

enum Environment { production, test, dev }

// Base URL
var currentEnvironment = Environment.production;

String get endpointApi => _environmentsMap[currentEnvironment] ?? '';

const Map<Environment, String> _environmentsMap = {
  Environment.production: 'https://dev-resumo.com/api/',
  Environment.dev: 'hihi',
  Environment.test: 'hihi',
};

// Use this photo if user don't have avatar
const noPhoto = 'images/noPhoto.jpeg';

// Valid date
DateTime _valid(DateTime dateTime) => (dateTime).toLocal();

// Format date
final _formatterFullDate = DateFormat('dd/MM/yyyy');
final _formatterMonthYear1 = DateFormat('yyyy年 MM月');

String? formatterFullDate(DateTime? dateTime) =>
    dateTime == null ? null : _formatterFullDate.format(dateTime);

String formatterMonthYear1(DateTime dateTime) =>
    _formatterMonthYear1.format(_valid(dateTime));

// Format money
final numberFormatter = NumberFormat('#,###');

copyToClipboard(String text) async {
  await Clipboard.setData(ClipboardData(text: text));
  showSnackBar('Copied $text');
}

bool get isTablet =>
    sqrt((Get.size.width * Get.size.width) +
        (Get.size.height * Get.size.height)) >
    1100;

bool get displayMobile => false;

final size =
    Get.size.width < Get.size.height ? Get.size.width : Get.size.height;

void showSnackBar(String message) => {
      Get.snackbar(
        '',
        '',
        titleText: Container(),
        messageText: Text(message),
        dismissDirection: SnackDismissDirection.HORIZONTAL,
        isDismissible: true,
        snackPosition: SnackPosition.BOTTOM,
      )
    };

get sosCall => Container(
      margin: EdgeInsets.only(
        top: 10,
        bottom: 25 + Get.mediaQuery.viewPadding.bottom,
      ),
      child: GestureDetector(
        onTap: () => showSnackBar(
          LocaleKeys.not_supported_yet.tr,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.phone_fill,
              color: sosColor,
            ),
            SizedBox(width: 6),
            Text(
              LocaleKeys.sos_central.tr,
              style: _defaultTextButtonStyle.copyWith(color: sosColor),
            ),
          ],
        ),
      ),
    );
final String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
final RegExp regExp = RegExp(pattern);

/// Check password invalid
/// 6 chars at least
/// contains alphabet and number
extension CheckPassword on String? {
  String? get isPassword =>
      !regExp.hasMatch(this ?? '') ? LocaleKeys.password_invalid.tr : null;
}

extension RemoveZero on String? {
  String? get remove0 {
    if (this?.startsWith('0') ?? false) {
      return this?.replaceFirst('0', '');
    }
    return this;
  }
}
