import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../common/const.dart';
import '../controllers/home_controller.dart';
import 'dictionary/views/dictionary_view.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColorShadow,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: GestureDetector(
          onTap: () => showSnackBar(LocaleKeys.not_supported_yet.tr),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(3),
            margin: const EdgeInsets.only(bottom: 80),
            height: 53,
            width: 53,
            decoration: BoxDecoration(
              color: sosColor,
              shape: BoxShape.circle,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.phone_fill,
                  color: Colors.white,
                  size: 25,
                ),
                SizedBox(width: 6),
                Text(
                  'SOS',
                  style: Get.textTheme.button?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: homeSystemUiOverlayStyle,
          child: Column(
            children: [
              Expanded(child: controller.view ?? DictionaryView()),
              Container(
                color: primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: TabType.values
                      .map(
                        (tab) => _iconBuilder(tab: tab, controller: controller),
                      )
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconBuilder({
    required TabType tab,
    required HomeController controller,
  }) {
    final selected = tab == controller.currentTab;
    return GestureDetector(
      onTap: () => controller.changeTab(tab),
      child: Container(
        width: size * 0.3,
        color: primaryColor,
        padding: EdgeInsets.only(
          top: 12,
          bottom: 8 + Get.mediaQuery.viewPadding.bottom,
        ),
        child: Column(
          children: [
            Image.asset(
              tab.icon,
              height: 26.67,
              color: selected ? Colors.white : Colors.white38,
            ),
            SizedBox(height: 6.67),
            Text(
              tab.label,
              style: Get.textTheme.caption?.copyWith(
                color: selected ? Colors.white : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }

// static const _tabs = [
//   TabType.DICTIONARY,
//   TabType.HEALTH_RECORD,
//   TabType.SETTING,
// ];
}

extension TabTypeInfo on TabType {
  String get icon {
    switch (this) {
      case TabType.dictionary:
        return 'images/ic_home.png';
      case TabType.healthRecord:
        return 'images/ic_paper.png';
      case TabType.setting:
        return 'images/ic_setting.png';
    }
  }

  String get label {
    switch (this) {
      case TabType.dictionary:
        return 'Từ điển';
      case TabType.healthRecord:
        return 'Sổ y bạ';
      case TabType.setting:
        return 'Cài đặt';
    }
  }
}
