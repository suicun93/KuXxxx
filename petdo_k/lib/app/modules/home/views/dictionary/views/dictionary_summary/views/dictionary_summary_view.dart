import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../../../../generated/locales.g.dart';
import '../../../../../../../common/const.dart';
import '../../../../../../../views/disease_item.dart';
import '../../../../../../../views/my_app_bar.dart';
import '../../../../../../../views/my_flexible_space_bar.dart';
import '../../../../../../../views/my_image.dart';
import '../controllers/dictionary_summary_controller.dart';

class DictionarySummaryView extends GetView<DictionarySummaryController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.back(),
      child: Obx(
        () => Scaffold(
          backgroundColor: backgroundColorShadow,
          body: CustomScrollView(
            slivers: [
              MySliverAppBar(
                floating: false,
                snap: false,
                expandedHeight: Get.height * 0.35 + toolbarHeight,
                pinned: true,
                collapsedHeight: toolbarHeight,
                leadingWidth: 60,
                leading: InkWell(
                  onTap: () => controller.back(),
                  child: Icon(CupertinoIcons.arrow_left),
                ),
                flexibleSpace: MyFlexibleSpaceBar(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.catResponse.value.name ?? controller.dogResponse.value.name ?? '',
                        style: Get.textTheme.titleSmall?.copyWith(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        controller.catResponse.value.temperament ?? controller.dogResponse.value.temperament ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: Get.textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      CarouselSlider.builder(
                        itemCount: controller.imageUrl.length,
                        itemBuilder: (_, index, realIndex) => MyImage(
                          link: controller.imageUrl[index].url,
                        ),
                        // carouselController: controller.carouselController,
                        options: CarouselOptions(
                          autoPlay: false,
                          enableInfiniteScroll: false,
                          height: Get.height * 0.41 + toolbarHeight,
                          viewportFraction: 1,
                          onPageChanged: (_, reason) {
                            return controller.carouselIndex.value = _;
                          },
                        ),
                      ),
                      Positioned(
                        right: 24,
                        bottom: 19,
                        child: AnimatedSmoothIndicator(
                          activeIndex: controller.carouselIndex.value,
                          count: 3,
                          effect: ExpandingDotsEffect(
                            expansionFactor: 2.5,
                            offset: 10,
                            dotWidth: 10,
                            dotHeight: 10,
                            spacing: 5.555,
                            radius: 10,
                            activeDotColor: subPrimaryColor,
                            dotColor: Colors.white,
                            strokeWidth: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(height: 24),
                    GestureDetector(
                      onTap: () => controller.expanding.toggle(),
                      child: _container(
                        child: Column(
                          children: [
                            Text(
                              controller.dogResponse.value.description ?? controller.catResponse.value.description ?? '',
                              style: Get.textTheme.bodyLarge,
                              maxLines: !controller.expanding.value ? 3 : 1000,
                              overflow: !controller.expanding.value
                                  ? TextOverflow.ellipsis
                                  : TextOverflow.visible,
                              textAlign: TextAlign.justify,
                            ),
                            _divider,
                            !controller.expanding.value
                                ? Text(
                                    'Show more',
                                    style: Get.textTheme.button?.copyWith(
                                      color: subPrimaryColor,
                                    ),
                                  )
                                : Text(
                                    'Show less',
                                    style: Get.textTheme.button?.copyWith(
                                      color: subPrimaryColor,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    _container(
                      child: Column(
                        children: [
                          _info(
                            image: 'images/ic_original.png',
                            label: 'Original',
                            info: controller.catResponse.value.origin ?? controller.dogResponse.value.origin ?? '',
                          ),
                          // SizedBox(height: 16),
                          // _info(
                          //   image: 'images/ic_price.png',
                          //   label: 'Price',
                          //   info: '60.000 - 200.000 ￥',
                          // ),
                          SizedBox(height: 16),
                          _info(
                            image: 'images/ic_age.png',
                            label: 'Age',
                            info: '${controller.catResponse.value.lifeSpan ?? controller.dogResponse.value.lifeSpan ?? ''} years old',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    _container(
                      child: Column(
                        children: [
                          _menu(title: 'Kích thước'),
                          _divider,
                          _menu(title: 'Tính cách'),
                          _divider,
                          _menu(title: 'Đặc điểm ngoại hình'),
                          _divider,
                          _menu(title: 'Độ phổ biến'),
                          _divider,
                          _menu(title: 'Sở thích'),
                          _divider,
                          _menu(title: 'Chế độ dinh dưỡng'),
                          _divider,
                          _menu(title: 'Điều kiện sống'),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Text(
                          'Các loại bệnh',
                          style: Get.textTheme.caption?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.width * 0.3 + 85 + 16,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(
                          bottom: 85,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menu({
    required String title,
    GestureTapCallback? onTap,
  }) =>
      GestureDetector(
        onTap: onTap ?? () => showSnackBar(LocaleKeys.not_supported_yet.tr),
        child: Row(
          children: [
            Expanded(child: Text(title, style: Get.textTheme.headline6)),
            Icon(Icons.keyboard_arrow_right_rounded),
          ],
        ),
      );

  Row _info({
    required String image,
    required String label,
    required String info,
  }) =>
      Row(
        children: [
          Image.asset(image, width: 14),
          SizedBox(width: 9),
          Text(label, style: Get.textTheme.bodyText1),
          Text(':', style: Get.textTheme.bodyText1),
          SizedBox(width: 4),
          Text(info, style: Get.textTheme.headline6),
        ],
      );

  Container _container({required Widget child}) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
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
        height: 30,
      );
}
