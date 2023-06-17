import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petdo_k/app/modules/home/controllers/home_controller.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../common/const.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../views/loading_view.dart';
import '../../../../../views/my_image.dart';
import '../controllers/health_record_controller.dart';

class HealthRecordView extends GetView<HealthRecordController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        color: backgroundColorShadow,
        child: controller.token.value == null
            ? Center(child: LoadingWidget())
            : (controller.token.value?.isEmpty ?? true)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80),
                        child: Image.asset('images/pending.png'),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'Đăng nhập để sử dụng tính năng này',
                          textAlign: TextAlign.center,
                          style: Get.textTheme.subtitle1?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: textColorDefault,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: ElevatedButton(
                          onPressed: () => Get.offAllNamed(Routes.LOGIN),
                          child: Text(LocaleKeys.login_btn.tr),
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: TextButton(
                          onPressed: () => controller.token.value = 'something',
                          child: Text('Switch Logged In'),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: Get.mediaQuery.viewPadding.top + 16,
                          bottom: 16,
                          right: 24,
                          left: 40
                        ),
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 50),
                            Text(
                              LocaleKeys.medical_book.tr,
                              style: Get.textTheme.subtitle2,
                            ),
                            GestureDetector(
                              onTap: () =>
                                  HomeController.instance.changeMainView(
                                MainView.addPet,
                              ),
                              child: SizedBox(
                                width: 84,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      CupertinoIcons.plus,
                                      color: subPrimaryColor,
                                      size: 20,
                                    ),
                                    SizedBox(width: 9),
                                    Text(
                                      LocaleKeys.add.tr,
                                      style: Get.textTheme.labelLarge?.copyWith(
                                        color: subPrimaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: controller.ready.value
                            ? RefreshIndicator(
                                onRefresh: () async {
                                  controller.onReady();
                                },
                                child: controller.noPet.value
                                    ? ListView.builder(
                                        padding: EdgeInsets.only(
                                            top: 12, bottom: 50),
                                        itemBuilder: (_, index) => _pet(
                                          image: controller.pets[index].imageUrl,
                                          name: controller.pets[index].name,
                                          gender: controller.pets[index].isMale ? LocaleKeys.male.tr : LocaleKeys.female.tr,
                                          age: '${index + 1} tháng tuổi',
                                          onTap: () => controller.toDetail(pet: controller.pets[index]),
                                        ),
                                        itemCount: controller.pets.length,
                                      )
                                    : ListView(
                                        children: [
                                          SizedBox(height: size * 0.3),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Image.asset(
                                              'images/no_pet.png',
                                              width: size * 0.4,
                                            ),
                                          ),
                                          Text(
                                            'You don’t have any pet.\nAdd pet now',
                                            textAlign: TextAlign.center,
                                            style: Get.textTheme.subtitle1
                                                ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: textColorDefault,
                                            ),
                                          ),
                                          SizedBox(height: size * 0.3),
                                        ],
                                      ),
                              )
                            : LoadingWidget(),
                      ),
                    ],
                  ),
      ),
    );
  }

  Widget _pet({
    required String image,
    required String name,
    required String gender,
    required String age,
    required GestureTapCallback? onTap,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          height: Get.width * 0.66,
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [defaultBoxShadow],
            color: Colors.white,
          ),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                  ),
                  child: MyImage(link: image),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              name,
                              maxLines: 1,
                              style: Get.textTheme.headline4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              gender,
                              style: Get.textTheme.bodyText2,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 60,
                    child: Icon(Icons.keyboard_arrow_right),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  /// Sample Data
  final listAnimalUrls = [
    'https://huanluyenchothanhtai.com/wp-content/uploads/2019/07/cho-corgi-4.jpg',
    'https://media.baamboozle.com/uploads/images/115667/1600676707_579518',
    'https://thumbor.forbes.com/thumbor/711x533/https://specials-images.forbesimg.com/imageserve/5faad4255239c9448d6c7bcd/Best-Animal-Photos-Contest--Close-Up-Of-baby-monkey/960x0.jpg',
    'https://aldf.org/wp-content/uploads/2018/05/lamb-iStock-665494268-16x9-e1559777676675.jpg',
    'https://images.pexels.com/photos/47547/squirrel-animal-cute-rodents-47547.jpeg',
    'https://images.hindustantimes.com/rf/image_size_630x354/HT/p2/2019/08/08/Pictures/happy-golden-retriever-puppy_c7b14e3e-b9eb-11e9-a203-e6c4ad816de5.jpg',
    'https://www.thevetonfourth.com/wp-content/uploads/2019/12/cat-looking-up.jpg'
  ];
  final name = [
    'Chong Jong Cho',
    'Mồn Lèo',
    'Khỉ',
    'Cừu',
    'Sóc',
    'Chó',
    'Quàng thượng'
  ];
}
