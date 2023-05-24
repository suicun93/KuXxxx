import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../../../../../../../generated/locales.g.dart';
import '../../../../../../../common/const.dart';
import '../../../../../../../views/loading_view.dart';
import '../../../../../../../views/my_image.dart';
import '../../../../../controllers/home_controller.dart';
import '../controllers/health_record_detail_controller.dart';

class HealthRecordDetailView extends GetView<HealthRecordDetailController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: () => controller.back(),
        child: Container(
          color: backgroundColorShadow,
          child: Column(
            children: [
              _appbar,
              Expanded(
                child: controller.ready.value
                    ? RefreshIndicator(
                        onRefresh: () async => controller.onReady(),
                        child: ListView(
                          padding: EdgeInsets.only(top: 4, bottom: 50),
                          children: [
                            SizedBox(height: 16),
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  SizedBox(width: 24),
                                  _petInfo1(
                                    image: controller.selectedImage.value,
                                    name: controller.selectedName.value,
                                    birthday: '29/08/2022',
                                    gender: 'Đực',
                                  ),
                                  SizedBox(width: 16),
                                  _petInfo2(
                                    weight: '4 kg',
                                    origin: 'Corgi Pembroke Wales',
                                  ),
                                  SizedBox(width: 24),
                                ],
                              ),
                            ),

                            /// Vaccine
                            _scheduleBlock(
                              header: 'Lịch tiêm Vaccine gần nhất',
                              title1: 'Ngày tiêm',
                              content1: '01/06/2021',
                              title2: 'Loại vaccine',
                              content2: 'Astra Zeneca',
                              buttonShow: 'Xem lịch khác',
                              onShow: controller.showVaccine,
                              buttonAdd: 'Thêm lịch tiêm',
                              onAdd: controller.addVaccine,
                            ),

                            /// Khám
                            _scheduleBlock(
                              header: 'Lịch khám gần nhất',
                              title1: 'Ngày khám',
                              content1: '01/06/2021',
                              title2: 'Cở sở khám',
                              content2: 'Thu Cúc',
                              buttonShow: 'Xem lịch khác',
                              onShow: controller.showExamination,
                              buttonAdd: 'Thêm lịch khám',
                              onAdd: controller.addExamination,
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 16, 40, 24),
                              child: ElevatedButton(
                                onPressed: () => _showDialog(
                                  'Bạn muốn xóa ${controller.selectedName.value}?',
                                  () => HomeController.instance.back(),
                                ),
                                child: Text('Delete Pet'),
                                style: _redElevatedButtonTheme,
                              ),
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
    );
  }

  Expanded _petInfo1({
    required String image,
    required String name,
    required String birthday,
    required String gender,
  }) {
    return Expanded(
      child: _container(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: MyImage(link: image),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: Text(
                name,
                style: Get.textTheme.headline4,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Image.asset('images/ic_birthday.png', width: 16, height: 19),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    birthday,
                    style: Get.textTheme.bodyText1,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Image.asset('images/ic_gender.png', width: 16, height: 19),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    gender,
                    style: Get.textTheme.bodyText1,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Expanded _petInfo2({
    required String weight,
    required String origin,
  }) {
    return Expanded(
      child: _container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cân nặng:',
                  style: Get.textTheme.bodyText2,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(height: 2),
                GestureDetector(
                  onTap: () => showSnackBar(LocaleKeys.not_supported_yet.tr),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          weight,
                          style: Get.textTheme.headline4?.copyWith(height: 1.4),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Image.asset('images/ic_edit.png', width: 18, height: 18),
                    ],
                  ),
                ),
                SizedBox(height: 2),
              ],
            ),
            Spacer(),
            SizedBox(height: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Giống:',
                  style: Get.textTheme.bodyText2,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(height: 2),
                Text(
                  origin,
                  style: Get.textTheme.headline4?.copyWith(height: 1.4),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                SizedBox(height: 2),
              ],
            ),
            Spacer(),
            _divider,
            GestureDetector(
              onTap: () => showSnackBar(
                LocaleKeys.not_supported_yet.tr,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Đặc điểm',
                      style: Get.textTheme.headline4,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_right),
                ],
              ),
            ),
            _divider,
            GestureDetector(
              onTap: () => showSnackBar(LocaleKeys.not_supported_yet.tr),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Sở thích',
                      style: Get.textTheme.headline4,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_right),
                ],
              ),
            ),
            SizedBox(height: 2),
          ],
        ),
      ),
    );
  }

  Column _scheduleBlock({
    required String header,
    required String title1,
    required String content1,
    required String title2,
    required String content2,
    required String buttonShow,
    required VoidCallback onShow,
    required String buttonAdd,
    required VoidCallback onAdd,
  }) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 40, top: 16),
            child: Text(
              header,
              style: Get.textTheme.caption?.copyWith(color: Colors.black),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: _container(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        title1,
                        style: Get.textTheme.bodyText2,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      flex: 3,
                      child: Text(
                        content1,
                        style: Get.textTheme.headline6,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        title2,
                        style: Get.textTheme.bodyText2,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      flex: 3,
                      child: Text(
                        content2,
                        style: Get.textTheme.headline6,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: onShow,
                        child: Text(
                          buttonShow,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        style: _textButtonStyle,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onAdd,
                        child: Text(
                          buttonAdd,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        style: _elevatedButton,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Container get _appbar => Container(
        color: Colors.transparent,
        margin: EdgeInsets.only(
          top: Get.mediaQuery.viewPadding.top + 16,
          bottom: 16,
        ),
        alignment: Alignment.bottomCenter,
        child: Row(
          children: [
            GestureDetector(
              onTap: () => HomeController.instance.back(),
              child: SizedBox(
                width: 60,
                child: Image.asset('images/ic_back.png', width: 16, height: 16),
              ),
            ),
            Expanded(
              child: Center(
                child: Text('Sổ y bạ', style: Get.textTheme.subtitle2),
              ),
            ),
            SizedBox(width: 60),
          ],
        ),
      );

  Container _container({required Widget child}) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [defaultBoxShadow],
          color: Colors.white,
        ),
        child: child,
      );

  Divider get _divider {
    return Divider(color: Color(0xffF1F1F4), thickness: 1, height: 30);
  }

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

  get _elevatedButton => ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) => states.contains(MaterialState.disabled)
              ? buttonDisableColor
              : subPrimaryColor,
        ),
        alignment: Alignment.center,
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        ),
        shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) => states.contains(MaterialState.disabled)
              ? textColorFaint
              : Colors.white,
        ),
      );

  ButtonStyle? get _redElevatedButtonTheme {
    return Get.theme.elevatedButtonTheme.style?.copyWith(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (states) =>
            states.contains(MaterialState.disabled) ? buttonDisableColor : red,
      ),
    );
  }

  void _showDialog(String content, VoidCallback onPress) => showDialog(
        context: Get.context!,
        builder: (_) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              margin: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Text(
                    content,
                    style: Get.textTheme.subtitle2?.copyWith(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Get.back(),
                          child: Text('Không xóa'),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                            onPress();
                          },
                          child: Text('Xóa'),
                          style: Get.theme.elevatedButtonTheme.style?.copyWith(
                            backgroundColor: MaterialStateProperty.all(red),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
