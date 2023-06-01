import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/const.dart';
import '../../../../../views/animal_item.dart';
import '../../../../../views/dropdown_list.dart';
import '../../../../../views/loading_view.dart';
import '../../../controllers/home_controller.dart';
import '../controllers/dictionary_controller.dart';

class DictionaryView extends GetView<DictionaryController> {
  @override
  Widget build(BuildContext context) {
    controller.listenTypeSelected();
    return Obx(
      () {
        return Scaffold(
          backgroundColor: backgroundColorShadow,
          body: Column(
            children: [
              SizedBox(height: Get.mediaQuery.viewPadding.top),
              Expanded(
                child: controller.ready.value
                    ? RefreshIndicator(
                        onRefresh: () async {
                          if (controller.selectedType.value != controller.animalType[0]){
                            controller.onReady();
                          } else {
                            controller.clearData();
                            controller.getCatsAndDogs(0, 0);
                          }
                        },
                        child: ListView(
                          padding: EdgeInsets.only(
                            top: 42 - Get.mediaQuery.viewPadding.top < 0
                                ? 0
                                : 42 - Get.mediaQuery.viewPadding.top,
                          ),
                          children: [
                            /// Hàng đầu tiên
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 24, left: 24),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Image.asset('images/splash_logo.png',
                                        width: 30),
                                  ),
                                  Text(
                                    'PetdoK',
                                    style: TextStyle(
                                      color: subPrimaryColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24,
                                      fontFamily: 'Nunito',
                                    ),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () =>
                                        HomeController.instance.changeMainView(
                                      MainView.searchPetDisease,
                                    ),
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(12),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: [defaultBoxShadow],
                                      ),
                                      child: Image.asset(
                                        'images/ic_search.png',
                                        height: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// Hàng 2
                            Container(height: 10),
                            Padding(
                              padding: EdgeInsets.zero,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.zero,
                                child: Row(
                                  children: [
                                    SizedBox(width: 24),
                                    DropdownList(
                                      list: controller.animalType,
                                      hintText: 'Loại',
                                      selectedItem:
                                          controller.selectedType.value,
                                      onSelect: (_) =>
                                          controller.selectedType.value = _,
                                    ),
                                    DropdownList(
                                      list: controller.moneyType,
                                      hintText: 'Giá tiền',
                                      selectedItem:
                                          controller.selectedMoney.value,
                                      onSelect: (_) =>
                                          controller.selectedMoney.value = _,
                                    ),
                                    DropdownList(
                                      list: controller.originalType,
                                      hintText: 'Nguồn gốc',
                                      selectedItem:
                                          controller.selectedOriginal.value,
                                      onSelect: (_) =>
                                          controller.selectedOriginal.value = _,
                                    ),
                                    SizedBox(width: 24),
                                  ],
                                ),
                              ),
                            ),

                            /// List Item
                            GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 3 / 4.6,
                              ),
                              shrinkWrap: true,
                              itemBuilder: (c, index) => AnimalItem(
                                url: controller.response[index].imageUrl,
                                name: controller.response[index].name,
                                origin: controller.response[index].origin,
                                temperament: controller.response[index].temperament,
                                onTap: () => controller.toSummary(
                                    controller.response[index].name
                                ),
                              ),
                              itemCount: controller.response.length,
                              addRepaintBoundaries: true,
                              addSemanticIndexes: true,
                              padding: EdgeInsets.only(
                                top: 12,
                                left: 24,
                                right: 24,
                                bottom: 24,
                              ),
                              physics: BouncingScrollPhysics(),
                              addAutomaticKeepAlives: true,
                            ),
                          ],
                        ),
                      )
                    : LoadingWidget(),
              ),
            ],
          ),
        );
      },
    );
  }

  final listAnimalUrls = [
    'https://huanluyenchothanhtai.com/wp-content/uploads/2019/07/cho-corgi-4.jpg',
    'https://media.baamboozle.com/uploads/images/115667/1600676707_579518',
    'https://thumbor.forbes.com/thumbor/711x533/https://specials-images.forbesimg.com/imageserve/5faad4255239c9448d6c7bcd/Best-Animal-Photos-Contest--Close-Up-Of-baby-monkey/960x0.jpg',
    'https://aldf.org/wp-content/uploads/2018/05/lamb-iStock-665494268-16x9-e1559777676675.jpg',
    'https://images.pexels.com/photos/47547/squirrel-animal-cute-rodents-47547.jpeg',
    'https://images.hindustantimes.com/rf/image_size_630x354/HT/p2/2019/08/08/Pictures/happy-golden-retriever-puppy_c7b14e3e-b9eb-11e9-a203-e6c4ad816de5.jpg',
    'https://www.thevetonfourth.com/wp-content/uploads/2019/12/cat-looking-up.jpg'
  ];
  final name = ['Corgi', 'Chó', 'Khỉ', 'Cừu', 'Sóc', 'Chó', 'Quàng thượng'];
}
