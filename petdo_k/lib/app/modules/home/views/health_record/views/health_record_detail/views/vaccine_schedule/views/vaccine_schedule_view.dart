import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petdo_k/generated/locales.g.dart';

import '../../../../../../../../../common/const.dart';
import '../../../../../../../../../views/loading_view.dart';
import '../../../../../../../controllers/home_controller.dart';
import '../controllers/vaccine_schedule_controller.dart';

class VaccineScheduleView extends GetView<VaccineScheduleController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: () => controller.back(),
        child: Container(
          color: backgroundColorShadow,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: Get.mediaQuery.viewPadding.top + 16,
                  bottom: 4,
                ),
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => controller.back(),
                      child: SizedBox(
                        width: 60,
                        child: Image.asset(
                          'images/ic_back.png',
                          width: 16,
                          height: 16,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          LocaleKeys.history.tr,
                          style: Get.textTheme.subtitle2,
                        ),
                      ),
                    ),
                    SizedBox(width: 60),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: ElevatedButton(
                  onPressed: () => HomeController.instance.changeMainView(
                    MainView.vaccineAdd,
                  ),
                  style: _elevatedButton,
                  child: Text(
                    LocaleKeys.add_schedule.tr,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
              Expanded(
                child: controller.ready.value
                    ? RefreshIndicator(
                        onRefresh: () async => controller.onReady(),
                        child: ListView.builder(
                          padding: EdgeInsets.only(top: 12, bottom: 50),
                          itemCount: controller.vaccineMap.length,
                          itemBuilder: (_, index) => _vaccineBuilder(
                            index: index,
                            onTap: () {
                              controller.selected.value =
                                  controller.vaccineMap[index];
                              controller.vaccineCount.value =
                                  controller.vaccineMap.length - index;
                              HomeController.instance.changeMainView(
                                MainView.vaccineEdit,
                              );
                            },
                          ),
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

  Widget _vaccineBuilder({
    required int index,
    required GestureTapCallback onTap,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                '${LocaleKeys.number.tr} ${controller.vaccineMap.length - index}',
                style: Get.textTheme.bodySmall?.copyWith(color: Colors.black),
              ),
            ),
            _container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${LocaleKeys.time.tr}: ',
                            style: Get.textTheme.bodyText1,
                          ),
                          SizedBox(height: 12),
                          Text(
                            '${LocaleKeys.vaccine_type.tr}: ',
                            style: Get.textTheme.bodyText1,
                          ),
                        ],
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.vaccineMap[index].values.first.date ??
                                  '',
                              overflow: TextOverflow.ellipsis,
                              style: Get.textTheme.headline6,
                            ),
                            SizedBox(height: 12),
                            Text(
                              controller.vaccineMap[index].values.first
                                      .vaccineType ??
                                  '',
                              style: Get.textTheme.headline6,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 40,
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          size: 23,
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

  Container _container({required Widget child}) => Container(
        margin: EdgeInsets.only(right: 24, left: 24, top: 6, bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [defaultBoxShadow],
          color: Colors.white,
        ),
        child: child,
      );

  get _elevatedButton => ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) => states.contains(MaterialState.disabled)
              ? buttonDisableColor
              : subPrimaryColor,
        ),
        alignment: Alignment.center,
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        ),
        shadowColor: MaterialStateProperty.all<Color>(
          Colors.transparent,
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) => states.contains(MaterialState.disabled)
              ? textColorFaint
              : Colors.white,
        ),
      );
}
