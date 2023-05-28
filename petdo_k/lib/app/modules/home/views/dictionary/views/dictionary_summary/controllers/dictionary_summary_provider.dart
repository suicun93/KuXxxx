import 'package:get/get.dart';
import 'package:petdo_k/api_utils.dart';
import 'package:petdo_k/app/model/dog_response.dart';

import '../../../../../../../model/cat_response.dart';

class DictionarySummaryProvider extends GetConnect {
  Future<Response<List<CatsResponse>>> getCatsByBreed({int page = 0}) {
    return ApiUtils.getCatData<List<CatsResponse>>(
        'breeds?limit=5&page=$page', (json) => catsResponseFromJson(json));
  }

  Future<Response<List<DogsResponse>>> getDogsByBreed({int page = 0}) {
    return ApiUtils.getDogData(
        'breeds?limit=5&page=$page', (json) => dogsResponseFromJson(json));
  }
}
