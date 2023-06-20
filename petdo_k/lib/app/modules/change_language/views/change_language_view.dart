import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../common/language_currency.dart';
import '../controllers/change_language_controller.dart';

class ChangeLanguageView extends GetView<ChangeLanguageController> {
  const ChangeLanguageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.change_language.tr),
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              size: 18,
              color: Colors.white,
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 12),
          children: [
            ...SupportedLanguages.values.map(
              (lang) {
                return InkWell(
                  onTap: () => controller.languageCurrency.value = lang,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 24,
                          horizontal: 16,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                lang.name,
                              ),
                            ),
                            Radio<SupportedLanguages>(
                              activeColor: blue400,
                              value: lang,
                              groupValue: controller.languageCurrency.value,
                              onChanged: (_) =>
                                  controller.languageCurrency.value = _!,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: ElevatedButton(
                onPressed: () => controller.save(),
                child: Text(LocaleKeys.select.tr),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const blue400 = Color(0xFF3A74F6);
