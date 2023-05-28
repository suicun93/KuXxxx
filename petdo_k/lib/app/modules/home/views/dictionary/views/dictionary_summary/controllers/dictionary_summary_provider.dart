import 'package:get/get.dart';
import 'package:petdo_k/api_utils.dart';
import 'package:petdo_k/app/model/dog_response.dart';
import 'package:petdo_k/app/model/image_search.dart';

import '../../../../../../../model/cat_response.dart';

class DictionarySummaryProvider extends GetConnect {
  Future<Response<List<CatResponse>>> getCatsByBreed({int page = 0}) {
    return ApiUtils.getCatData<List<CatResponse>>(
        'breeds?limit=5&page=$page', (json) => catsResponseFromJson(json));
  }

  Future<Response<List<DogResponse>>> getDogsByBreed({int page = 0}) {
    return ApiUtils.getDogData(
        'breeds?limit=5&page=$page', (json) => dogsResponseFromJson(json));
  }

  Future<Response<List<ImageSearch>>> getDogImages(String breedId) {
    return ApiUtils.getDogData<List<ImageSearch>>(
        'images/search?limit=3&breed_id=$breedId',
        (data) => imageSearchFromJson(data));
  }

  Future<Response<List<ImageSearch>>> getCatImages(String breedId) {
    return ApiUtils.getCatData<List<ImageSearch>>(
        'images/search?limit=3&breed_id=$breedId',
            (data) => imageSearchFromJson(data));
  }
}
