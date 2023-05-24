import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../common/const.dart';
import '../../../../../../../views/disease_item.dart';
import '../../../../../../../views/loading_view.dart';
import '../../../../../controllers/home_controller.dart';
import '../controllers/search_pet_disease_controller.dart';

class SearchPetDiseaseView extends GetView<SearchPetDiseaseController> {
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
                      SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          height: 44,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
                            boxShadow: [defaultBoxShadow],
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                'images/ic_search.png',
                                height: 16,
                              ),
                              Expanded(
                                child: TextFormField(
                                  style: Get.textTheme.bodyText1,
                                  cursorColor: subPrimaryColor,
                                  onChanged: (_) =>
                                      controller.searchText.value = _,
                                  controller:
                                      controller.searchTextEditingController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: 'Nhập vào đây',
                                    labelText: '',
                                    contentPadding: const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                      bottom: 14,
                                      top: 0,
                                    ),
                                  ),
                                ),
                              ),
                              Image.asset(
                                'images/ic_camera.png',
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Expanded(
                  child: controller.ready.value
                      ? RefreshIndicator(
                          onRefresh: () async => controller.onReady(),
                          child: controller.searchText.isEmpty
                              ? ListView(
                                  padding: EdgeInsets.only(
                                    top: 12,
                                    bottom: 0,
                                    right: 24,
                                    left: 24,
                                  ),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: Text(
                                        'Tìm kiếm gần đây',
                                        style: Get.textTheme.caption?.copyWith(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    _container(
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (_1, index) => (!controller
                                                    .showMore.value &&
                                                index == 3)
                                            ? GestureDetector(
                                                onTap: () => controller.showMore
                                                    .toggle(),
                                                child: Text(
                                                  'Hiển thị thêm',
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Get.textTheme.button
                                                      ?.copyWith(
                                                    color: subPrimaryColor,
                                                  ),
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  controller
                                                      .searchTextEditingController
                                                      .text = listSearch[index];
                                                  controller.searchText.value =
                                                      listSearch[index];
                                                },
                                                child: Text(
                                                  listSearch[index],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      Get.textTheme.bodyText1,
                                                ),
                                              ),
                                        separatorBuilder: (_1, _2) => _divider,
                                        itemCount: controller.showMore.value
                                            ? listSearch.length
                                            : 4,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: Text(
                                        'Phổ biến nhất',
                                        style: Get.textTheme.caption?.copyWith(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    _container(
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (_1, index) => (!controller
                                                    .showMore.value &&
                                                index == 3)
                                            ? GestureDetector(
                                                onTap: () => controller.showMore
                                                    .toggle(),
                                                child: Text(
                                                  'Hiển thị thêm',
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Get.textTheme.button
                                                      ?.copyWith(
                                                    color: subPrimaryColor,
                                                  ),
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  controller
                                                      .searchTextEditingController
                                                      .text = listSearch[index];
                                                  controller.searchText.value =
                                                      listSearch[index];
                                                },
                                                child: Text(
                                                  listSearch[index],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      Get.textTheme.bodyText1,
                                                ),
                                              ),
                                        separatorBuilder: (_1, _2) => _divider,
                                        itemCount: controller.showMore.value
                                            ? listSearch.length
                                            : 4,
                                      ),
                                    ),
                                  ],
                                )
                              : ListView(
                                  padding: EdgeInsets.only(
                                    top: 12,
                                    bottom: 0,
                                  ),
                                  children: [
                                    /// Hàng 2 Các loại vật nuôi
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                      ),
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Có ',
                                              style: Get.textTheme.bodyText1,
                                            ),
                                            TextSpan(
                                              text: '${listAnimalUrls.length}',
                                              style: Get.textTheme.headline6,
                                            ),
                                            TextSpan(
                                              text: ' kết quả cho ',
                                              style: Get.textTheme.bodyText1,
                                            ),
                                            TextSpan(
                                              text:
                                                  '"${controller.searchText.value}"',
                                              style: Get.textTheme.headline6,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    /// List Item
                                    SizedBox(
                                      height: Get.width * 0.3 + 16 + 16,
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        padding: EdgeInsets.only(
                                          bottom: 16,
                                          top: 16,
                                          right: 24,
                                          left: 24,
                                        ),
                                        itemBuilder: (c, _) => GestureDetector(
                                          onTap: () => controller.toSummary(
                                            name: name[_],
                                            image: listAnimalUrls[_],
                                          ),
                                          child: DiseaseItem(
                                            title: name[_],
                                            image: listAnimalUrls[_],
                                          ),
                                        ),
                                        separatorBuilder: (c, _) =>
                                            SizedBox(width: 12),
                                        itemCount: listAnimalUrls.length,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: size * 0.4,
                                        child: TextButton(
                                          onPressed: () => HomeController
                                              .instance
                                              .changeMainView(
                                            MainView.searchPet,
                                          ),
                                          child: Text('Xem tất cả'),
                                          style: _textButtonStyle,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 32),

                                    /// Hàng 3 - Các loại bệnh
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                      ),
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Có ',
                                              style: Get.textTheme.bodyText1,
                                            ),
                                            TextSpan(
                                              text: '${4}',
                                              style: Get.textTheme.headline6,
                                            ),
                                            TextSpan(
                                              text: ' kết quả bệnh cho ',
                                              style: Get.textTheme.bodyText1,
                                            ),
                                            TextSpan(
                                              text:
                                                  '"${controller.searchText.value}"',
                                              style: Get.textTheme.headline6,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.width * 0.3 + 16 + 16,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        padding: EdgeInsets.only(
                                          bottom: 16,
                                          top: 16,
                                          right: 24,
                                          left: 24,
                                        ),
                                        children: [
                                          DiseaseItem(
                                            title: 'Bệnh viêm ruột',
                                            image:
                                                'https://biowish.vn/wp-content/uploads/2020/05/17DOGS-superJumbo-1024x683.jpg',
                                          ),
                                          SizedBox(width: 12),
                                          DiseaseItem(
                                            title: 'Bệnh ghẻ',
                                            image:
                                                'https://doctors24h.vn/uploads/news/06_2019/13/lam-the-nao-thu-cung-co-the-cai-thien-suc-khoe-cua-ban-doi-tac-cham-soc-ung-thu-tot-hon.jpg',
                                          ),
                                          SizedBox(width: 12),
                                          DiseaseItem(
                                            title: 'Bệnh xàm',
                                            image:
                                                'https://www.petcity.vn/media/news/2801_tam_cho_thu_cung_dung_cach.jpg',
                                          ),
                                          SizedBox(width: 12),
                                          DiseaseItem(
                                            title: 'Bệnh copy',
                                            image:
                                                'https://i2.wp.com/azpet.vn/wp-content/uploads/2020/07/chon-thuc-an-phu-hop-voi-chuot-tai-cac-cua-hang-thu-cung.jpg?fit=800%2C533&ssl=1',
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: size * 0.4,
                                        child: TextButton(
                                          onPressed: () => HomeController
                                              .instance
                                              .changeMainView(
                                                  MainView.searchDisease),
                                          child: Text('Xem tất cả'),
                                          style: _textButtonStyle,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 32),
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
  final listSearch = [
    'Corgi',
    'Chó',
    'Khỉ',
    'Cừu',
    'Sóc',
    'Chó',
    'Quàng thượng'
  ];

  Container _container({required Widget child}) => Container(
        margin: EdgeInsets.only(top: 8, bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [defaultBoxShadow],
          color: Colors.white,
        ),
        child: child,
      );

  Divider get _divider => Divider(
        color: Color(0xffF1F1F4),
        thickness: 1,
        height: 32,
      );

  get _textButtonStyle => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          Colors.transparent,
        ),
        alignment: Alignment.center,
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        ),
        shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
        foregroundColor: MaterialStateProperty.all<Color>(subPrimaryColor),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            side: BorderSide(
              color: subPrimaryColor,
              width: 1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      );
}
