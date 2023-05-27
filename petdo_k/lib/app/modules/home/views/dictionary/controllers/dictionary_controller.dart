import 'package:get/get.dart';

import '../../../../../views/dropdown_list.dart';
import '../../../controllers/home_controller.dart';
import '../views/dictionary_summary/controllers/dictionary_summary_provider.dart';

class DictionaryController extends GetxController {
  final provider = Get.find<DictionarySummaryProvider>();
  List<DropboxItem> get animalType => [
        DropboxItem('c', 'Chó'),
        DropboxItem('m', 'Mèo'),
      ];

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
    await Future.delayed(
      Duration(milliseconds: 2000),
      () => ready.value = true,
    );
    getCats();
  }

  @override
  void onClose() {}

  void getCats() async{
    final response = await provider.getCats();
    print(response);
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
