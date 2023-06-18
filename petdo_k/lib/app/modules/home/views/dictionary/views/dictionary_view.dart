import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/const.dart';
import '../../../../../views/animal_item.dart';
import '../../../../../views/dropdown_list.dart';
import '../../../../../views/loading_view.dart';
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
                          if (controller.selectedType.value !=
                              controller.animalType[0]) {
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
                                  Container(
                                    width: 36,
                                    decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: primaryColor,
                                        width: 2,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child:
                                          Image.asset('assets/logo_prod.jpeg'),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'PetNottoKu',
                                    style: TextStyle(
                                      color: subPrimaryColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24,
                                      fontFamily: 'Nunito',
                                    ),
                                  ),
                                  Spacer(),
                                  // GestureDetector(
                                  //   onTap: () =>
                                  //       HomeController.instance.changeMainView(
                                  //     MainView.searchPetDisease,
                                  //   ),
                                  //   child: Container(
                                  //     alignment: Alignment.center,
                                  //     padding: const EdgeInsets.all(12),
                                  //     decoration: const BoxDecoration(
                                  //       color: Colors.white,
                                  //       shape: BoxShape.circle,
                                  //       boxShadow: [defaultBoxShadow],
                                  //     ),
                                  //     child: Image.asset(
                                  //       'images/ic_search.png',
                                  //       height: 20,
                                  //     ),
                                  //   ),
                                  // ),
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
                                      hintText: '',
                                      selectedItem:
                                          controller.selectedType.value,
                                      onSelect: (_) =>
                                          controller.selectedType.value = _,
                                    ),
                                    // DropdownList(
                                    //   list: controller.moneyType,
                                    //   hintText: 'Giá tiền',
                                    //   selectedItem:
                                    //       controller.selectedMoney.value,
                                    //   onSelect: (_) =>
                                    //       controller.selectedMoney.value = _,
                                    // ),
                                    // DropdownList(
                                    //   list: controller.originalType,
                                    //   hintText: 'Nguồn gốc',
                                    //   selectedItem:
                                    //       controller.selectedOriginal.value,
                                    //   onSelect: (_) =>
                                    //       controller.selectedOriginal.value = _,
                                    // ),
                                    // SizedBox(width: 24),
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
                                temperament:
                                    controller.response[index].temperament,
                                onTap: () => controller
                                    .toSummary(controller.response[index].name),
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
}
