import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../../../common/const.dart';
import '../../../../../../../../../views/disease_item.dart';
import '../../../../../../../../../views/loading_view.dart';
import '../../../../../../../controllers/home_controller.dart';
import '../controllers/search_disease_controller.dart';

class SearchDiseaseView extends GetView<SearchDiseaseController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: WillPopScope(
          onWillPop: () async => controller.back(),
          child: Scaffold(
            backgroundColor: backgroundColorShadow,
            body: Column(
              children: [
                SizedBox(height: Get.mediaQuery.viewPadding.top),

                /// Hàng đầu tiên
                SizedBox(
                  height: 42 - Get.mediaQuery.viewPadding.top < 0
                      ? 0
                      : 42 - Get.mediaQuery.viewPadding.top,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 24, left: 24),
                  child: Row(
                    children: [
                      SizedBox(width: 4),
                      GestureDetector(
                        onTap: () => HomeController.instance.back(),
                        child: Image.asset(
                          'images/ic_back.png',
                          width: 16,
                          height: 16,
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'TÌm kiếm bệnh',
                            style: Get.textTheme.subtitle2,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Expanded(
                  child: controller.ready.value
                      ? RefreshIndicator(
                          onRefresh: () async => controller.onReady(),
                          child: ListView(
                            padding: EdgeInsets.only(
                              top: 12,
                              bottom: 0,
                            ),
                            children: [
                              GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 3 / 4.6,
                                ),
                                itemBuilder: (c, _) => DiseaseItem(
                                  title: listBenh[_],
                                  image: listAnhBenh[_],
                                ),
                                shrinkWrap: true,
                                itemCount: listBenh.length,
                                addRepaintBoundaries: true,
                                addSemanticIndexes: true,
                                padding: EdgeInsets.only(
                                  top: 12,
                                  left: 24,
                                  right: 24,
                                  bottom: 24,
                                ),
                                physics: BouncingScrollPhysics(),
                              ),
                            ],
                          ),
                        )
                      : LoadingWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final listBenh = [
    'Bệnh viêm ruột',
    'Bệnh ghẻ',
    'Bệnh xàm',
    'Bệnh copy',
  ];
  final listAnhBenh = [
    'https://biowish.vn/wp-content/uploads/2020/05/17DOGS-superJumbo-1024x683.jpg',
    'https://doctors24h.vn/uploads/news/06_2019/13/lam-the-nao-thu-cung-co-the-cai-thien-suc-khoe-cua-ban-doi-tac-cham-soc-ung-thu-tot-hon.jpg',
    'https://www.petcity.vn/media/news/2801_tam_cho_thu_cung_dung_cach.jpg',
    'https://i2.wp.com/azpet.vn/wp-content/uploads/2020/07/chon-thuc-an-phu-hop-voi-chuot-tai-cac-cua-hang-thu-cung.jpg?fit=800%2C533&ssl=1',
  ];
}
