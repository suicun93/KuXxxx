import 'package:get/get.dart';
import 'package:petdo_k/app/model/animal.dart';
import 'package:petdo_k/app/model/cat_response.dart';
import 'package:petdo_k/app/model/dog_response.dart';
import 'package:petdo_k/generated/locales.g.dart';

import '../../../../../views/dropdown_list.dart';
import '../../../controllers/home_controller.dart';
import '../views/dictionary_summary/controllers/dictionary_summary_provider.dart';

class DictionaryController extends GetxController {
  final provider = Get.find<DictionarySummaryProvider>();

  List<DropboxItem> get animalType => [
        DropboxItem('a', LocaleKeys.all.tr),
        DropboxItem('c', LocaleKeys.dog.tr),
        DropboxItem('m', LocaleKeys.cat.tr),
      ];
  final response = <AnimalResponse>[].obs;

  List<DropboxItem> get moneyType => [];

  List<DropboxItem> get originalType => [];

  /// Selected drop box
  final selectedType = Rxn<DropboxItem>();
  final selectedMoney = Rxn<DropboxItem>();
  final selectedOriginal = Rxn<DropboxItem>();
  final ready = true.obs;

  final _catResponse = <CatResponse>[];
  final _dogResponse = <DogResponse>[];

  @override
  void onReady() async {
    super.onReady();
    ready.value = false;
    clearData();
    selectedType.value = animalType[0];
  }

  @override
  void onClose() {}

  void clearData() {
    response.clear();
    _dogResponse.clear();
    _catResponse.clear();
  }

  void listenTypeSelected() {
    selectedType.listen((type) async {
      response.clear();
      _dogResponse.clear();
      _catResponse.clear();
      if (type == animalType[1]) {
        final dogResponse = (await provider.getDogsByBreed()).body ?? [];
        response.addAll(dogResponse.map((e) => AnimalResponse(
            e.image?.url ?? '',
            e.name ?? '',
            e.origin ?? '',
            e.temperament ?? '')));
      } else if (type == animalType[2]) {
        final catResponse = (await provider.getCatsByBreed()).body ?? [];
        response.addAll(catResponse.map((e) => AnimalResponse(
            e.image?.url ?? '',
            e.name ?? '',
            e.origin ?? '',
            e.temperament ?? '')));
      } else {
        getCatsAndDogs(0, 0);
      }
    });
  }

  void getCatsAndDogs(int dogPage, int catPage) async {
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
        _catResponse.add(catResponse[i]);
        response.add(AnimalResponse(
            catResponse[i].image?.url ?? '',
            catResponse[i].name ?? '',
            catResponse[i].origin ?? '',
            catResponse[i].temperament ?? ''));
      }
      if (i < dogResponse.length) {
        _dogResponse.add(dogResponse[i]);
        response.add(AnimalResponse(
            dogResponse[i].image?.url ?? '',
            dogResponse[i].name ?? '',
            dogResponse[i].origin ?? '',
            dogResponse[i].temperament ?? ''));
      }
    }
    ready.value = true;
  }

  void toSummary(
    String animalName,
  ) {
    for (final cat in _catResponse) {
      if (cat.name == animalName) {
        HomeController.instance.selectedDog = null;
        HomeController.instance.selectedCat = cat;
        HomeController.instance.changeMainView(MainView.dictionarySummary);
        return;
      }
    }
    for (final dog in _dogResponse) {
      if (dog.name == animalName) {
        HomeController.instance.selectedDog = dog;
        HomeController.instance.selectedCat = null;
        HomeController.instance.changeMainView(MainView.dictionarySummary);
        return;
      }
    }
  }
}
