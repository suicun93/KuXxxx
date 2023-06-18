import 'package:get/get.dart';
import 'package:petdo_k/utils.dart';

class ApiConnect extends GetConnect {
  Future<Response<T>> callCatApi<T>(String endpoint, Decoder<T>? decoder) {
    return get('https://api.thecatapi.com/v1/$endpoint',
        decoder: decoder, headers: {'x-api-key': catApi});
  }

  Future<Response<T>> callDogApi<T>(String endpoint, Decoder<T>? decoder) {
    return get('https://api.thedogapi.com/v1/$endpoint',
        decoder: decoder, headers: {'x-api-key': dogApi});
  }
}

class ApiUtils {
  static ApiConnect? _apiConnect;

  static Future<Response<T>> getCatData<T>(
      String endpoint, Decoder<T>? decoder) {
    _apiConnect ??= ApiConnect();
    return _apiConnect!.callCatApi(endpoint, decoder);
  }

  static Future<Response<T>> getDogData<T>(
      String endpoint, Decoder<T>? decoder) {
    _apiConnect ??= ApiConnect();
    return _apiConnect!.callDogApi(endpoint, decoder);
  }
}
