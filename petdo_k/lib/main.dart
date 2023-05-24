import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'app/common/const.dart';
import 'app/routes/app_pages.dart';
import 'generated/locales.g.dart';

void main() {
  /// Run app
  runApp(
    GetMaterialApp(
      onReady: () {
        /// Setup môi trường xung quanh
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            /// The color of the system bottom navigation bar.
            /// Only honored in Android versions O and greater.
            systemNavigationBarColor: primaryColor,

            /// The color of the divider between the system's bottom navigation bar and the app's content.
            /// Only honored in Android versions P and greater.
            systemNavigationBarDividerColor: primaryColor,

            /// The brightness of the system navigation bar icons.
            /// Only honored in Android versions O and greater.
            /// When set to [Brightness.light], the system navigation bar icons are light.
            /// When set to [Brightness.dark], the system navigation bar icons are dark.
            systemNavigationBarIconBrightness: Brightness.light,

            /// The color of top status bar.
            /// Only honored in Android version M and greater.
            statusBarColor: Colors.transparent,

            /// The brightness of top status bar.
            /// Only honored in iOS.
            statusBarBrightness: Brightness.dark,

            /// The brightness of the top status bar icons.
            /// Only honored in Android version M and greater.
            statusBarIconBrightness: Brightness.light,
          ),
        );

        /// Lock màn hình dọc
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);

        /// Chưa biết để làm gì
        // SystemChrome.setApplicationSwitcherDescription(
        //   ApplicationSwitcherDescription(
        //     label: 'PetdoK',
        //     primaryColor: 250,
        //   ),
        // );
      },
      color: primaryColor,
      title: "PetdoK",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: defaultTheme,
      // Đa ngôn ngữ - Multilingual - i18n
      translationsKeys: AppTranslation.translations,
      locale: Get.deviceLocale,
      fallbackLocale: Locale('en', 'US'),
    ),
  );

  // You can change locale by
  // var locale = Locale('vi', 'VN');
  // Get.updateLocale(locale);
}
