import 'package:get/get.dart';

import '../../../common/const.dart';
import '../../../common/language_currency.dart';

class ChangeLanguageController extends GetxController {
  final ready = true.obs;
  final languageCurrency = SupportedLanguages.english.obs;

  @override
  void onInit() async {
    super.onInit();

    /// Get default Locale
    languageCurrency.value = SupportedLanguages.currentSupportedLanguages;
  }

  @override
  void onClose() {}

  Future save() async {
    try {
      ready.value = false;
      final currentLang = SupportedLanguages.currentSupportedLanguages;
      if (languageCurrency.value != currentLang) {
        await SupportedLanguages.save(languageCurrency.value);
      }
    } catch (e) {
      showSnackBar(e.toString());
    } finally {
      ready.value = true;
    }
  }
}
