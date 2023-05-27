import 'package:get/get.dart';

import '../../../../../controllers/home_controller.dart';
import '../../../controllers/dictionary_controller.dart';
import 'cat_response.dart';

class DictionarySummaryProvider extends GetConnect {
  Future<Response<CatResponse>> getCats() {
    return get(
      'https://api.thecatapi.com/v1/images/0XYvRd7oD',
      decoder: (json) => CatResponse.fromJson(json),
    );
  }
}
