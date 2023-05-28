import 'package:get/get.dart';
import 'package:petdo_k/api_utils.dart';
import 'package:petdo_k/app/model/animal.dart';

import '../../../../../model/image_search.dart';
import '../../../../../views/dropdown_list.dart';
import '../../../controllers/home_controller.dart';
import '../views/dictionary_summary/controllers/dictionary_summary_provider.dart';

class DictionaryController extends GetxController {
  final provider = Get.find<DictionarySummaryProvider>();

  List<DropboxItem> get animalType => [
        DropboxItem('c', 'Chó'),
        DropboxItem('m', 'Mèo'),
      ];
  final response = <AnimalResponse>[].obs;

  List<DropboxItem> get moneyType => [];

  List<DropboxItem> get originalType => [];

  /// Selected drop box
  final selectedType = Rxn<DropboxItem>();
  final selectedMoney = Rxn<DropboxItem>();
  final selectedOriginal = Rxn<DropboxItem>();
  final ready = true.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() async {
    super.onReady();
    ready.value = false;
    response.clear();
    await Future.delayed(
      Duration(milliseconds: 2000),
      () => ready.value = true,
    );
    getCatsAndDogs(dogPage: 0, catPage: 0);
  }

  @override
  void onClose() {}

  void getCatsAndDogs({required int dogPage, required int catPage}) async {
    final catResponse =
        (await provider.getCatsByBreed(page: catPage)).body ?? [];
    final dogResponse =
        (await provider.getDogsByBreed(page: dogPage)).body ?? [];
    for (int i = 0;
        i <
            (catResponse.length > dogResponse.length
                ? catResponse.length
                : dogResponse.length);
        i++) {
      if (i < catResponse.length) {
        response.add(AnimalResponse(
            catResponse[i].image?.url ?? '',
            catResponse[i].name ?? '', catResponse[i].origin ?? '',catResponse[i].temperament ?? '' ));
      }
      if (i < dogResponse.length) {
        response.add(AnimalResponse(
            dogResponse[i].image?.url ?? '',
            dogResponse[i].name ?? '', dogResponse[i].origin ?? '',dogResponse[i].temperament ?? ''));
      }
    }
  }

  void toSummary({
    required String name,
    required String image,
  }) {
    HomeController.instance.selectedAnimalImage = image;
    HomeController.instance.selectedAnimalName = name;
    HomeController.instance.changeMainView(MainView.dictionarySummary);
  }
}
