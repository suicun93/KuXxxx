import 'dart:math';

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
        dismissDirection: DismissDirection.horizontal,
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

const termsAndPolicy = "Terms and Policy for Mobile Application\n\n" +
    "Welcome to our mobile application! These Terms and Policies outline the rules and guidelines for the use of our app and related services. By downloading, installing, accessing, or using our app, you agree to comply with these terms. Please read them carefully before proceeding.\n\n" +
    "1. Definitions\n\n" +
    "1.1 \"App\" refers to our mobile application and any related services provided therein.\n" +
    "1.2 \"User\" refers to any individual who downloads, installs, accesses, or uses the app.\n\n" +
    "2. Acceptance of Terms\n\n" +
    "By using our app, you agree to these Terms and Policies, and any future updates or modifications that may occur. If you do not agree with these terms, please refrain from using the app.\n\n" +
    "3. User Accounts\n\n" +
    "Users may be required to create an account to access certain features and services of the app. You are responsible for maintaining the confidentiality of your account credentials and are liable for all activities that occur under your account.\n\n" +
    "You must provide accurate, complete, and up-to-date information when creating an account. You agree to promptly update any changes to your account information.\n\n" +
    "4. User Conduct\n\n" +
    "Users of the app must comply with all applicable laws and regulations and are responsible for their actions within the app.\n\n" +
    "Users shall not engage in any activities that may:\n" +
    "   a. Violate the rights of others or infringe upon any intellectual property rights.\n" +
    "   b. Transmit any harmful or malicious code, viruses, or disruptive content.\n" +
    "   c. Attempt to gain unauthorized access to the app or any other user's account.\n" +
    "   d. Use the app for any illegal, harmful, or unethical purposes.\n" +
    "   e. Engage in any form of harassment, discrimination, or offensive behavior.\n\n" +
    "5. Intellectual Property\n\n" +
    "The app and its associated content, including but not limited to logos, graphics, text, and software, are protected by intellectual property rights. Users may not reproduce, modify, distribute, or exploit any part of the app without explicit permission.\n\n" +
    "6. Privacy\n\n" +
    "We are committed to protecting your privacy. Our Privacy Policy outlines how we collect, use, and disclose personal information.\n\n" +
    "Please note that these Terms and Policies may be subject to change. It is your responsibility to review them periodically for any updates or modifications.\n\n";

String aboutUs = "Welcome to our application! We are a dedicated team of professionals who are passionate about creating innovative solutions to enhance your everyday life. Our mission is to provide you with a seamless and intuitive user experience that simplifies complex tasks and brings convenience to your fingertips. Whether you're looking for a productivity tool, a fitness companion, or a source of inspiration, our application is designed to cater to your needs.\n\n" +
    "With a strong focus on user-centric design, we strive to deliver an application that not only meets but exceeds your expectations. We listen to your feedback and continuously iterate on our features to ensure they align with your evolving requirements. Our commitment to excellence drives us to push boundaries, explore new technologies, and stay ahead of the curve in an ever-changing digital landscape.\n\n" +
    "Security and privacy are paramount to us. We employ robust measures to safeguard your personal information, ensuring that your data is protected at all times. Trust and transparency are at the core of our values, and we work tirelessly to maintain your confidence in our application.\n\n" +
    "Collaboration and inclusivity are integral to our philosophy. We believe in building a vibrant community where users can connect, share ideas, and inspire one another. Through our application, we aim to foster meaningful connections and empower you to reach your goals, whatever they may be.\n\n" +
    "Thank you for choosing our application. We are thrilled to have you on board and look forward to embarking on this journey together. Join us as we revolutionize the way you live, work, and play. Together, let's make every moment extraordinary.";
