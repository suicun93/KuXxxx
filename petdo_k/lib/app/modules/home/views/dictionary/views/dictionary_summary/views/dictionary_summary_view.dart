import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

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
                              maxLines: !controller.expanding.value ? 1 : 200,
                              overflow: !controller.expanding.value
                                  ? TextOverflow.ellipsis
                                  : TextOverflow.visible,
                              textAlign: TextAlign.justify,
                            ),
                            _divider,
                            !controller.expanding.value
                                ? Text(
                                    LocaleKeys.show_more.tr,
                                    style: Get.textTheme.button?.copyWith(
                                      color: subPrimaryColor,
                                    ),
                                  )
                                : Text(
                                    LocaleKeys.show_less.tr,
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
                          if(controller.catResponse.value.wikipediaUrl?.isNotEmpty == true)
                            _menu(title: LocaleKeys.detail_information.tr, onTap: () {
                            _launchUrl(controller.catResponse.value.wikipediaUrl ?? '');
                          })
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

  _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
