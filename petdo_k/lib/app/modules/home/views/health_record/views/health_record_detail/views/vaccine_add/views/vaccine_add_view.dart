import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petdo_k/generated/locales.g.dart';

import '../../../../../../../../../common/const.dart';
import '../../../../../../../../../views/date_picker.dart';
import '../../../../../../../../../views/loading_view.dart';
import '../../../../../../../controllers/home_controller.dart';
import '../controllers/vaccine_add_controller.dart';

class VaccineAddView extends GetView<VaccineAddController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: WillPopScope(
        onWillPop: () => controller.back(),
        child: Obx(
          () => Container(
            color: backgroundColorShadow,
            child: Column(
              children: [
                Container(
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
                            LocaleKeys.add_schedule.tr,
                            style: Get.textTheme.subtitle2,
                          ),
                        ),
                      ),
                      SizedBox(width: 60)
                    ],
                  ),
                ),
                Expanded(
                  child: controller.ready.value
                      ? ListView(
                          padding: EdgeInsets.only(
                            top: 12,
                            bottom: 50,
                            right: 24,
                            left: 24,
                          ),
                          children: [
                            _container(
                              child: Column(
                                children: [
                                  SizedBox(height: 10),
                                  _buildDatePicker(
                                    LocaleKeys.time.tr,
                                    controller.vaccineDateController,
                                  ),
                                  SizedBox(height: 24),
                                  _buildTextFormField(
                                      title: LocaleKeys.body_temp.tr,
                                      textInputType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      onChange: (_) =>
                                          controller.temp.value = _),
                                  SizedBox(height: 24),
                                  _buildTextFormField(
                                      title: LocaleKeys.weight.tr,
                                      textInputType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      onChange: (_) =>
                                          controller.weight.value = _),
                                  SizedBox(height: 24),
                                  _buildTextFormField(
                                      title: LocaleKeys.vaccine_type.tr,
                                      onChange: (_) =>
                                          controller.vaccineType.value = _),
                                  SizedBox(height: 24),
                                  _buildDatePicker(
                                    LocaleKeys.revaccinate_date.tr,
                                    controller.revaccineDateController,
                                  ),
                                  SizedBox(height: 24),
                                  _buildTextFormField(
                                      title: LocaleKeys.doctor.tr,
                                      onChange: (_) =>
                                          controller.doctor.value = _),
                                  SizedBox(height: 24),
                                  _buildTextFormField(
                                      title: LocaleKeys.location.tr,
                                      onChange: (_) =>
                                      controller.location.value = _),
                                ],
                              ),
                            ),
                            SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: controller.submit,
                              child: Text(LocaleKeys.add.tr),
                            ),
                          ],
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

  Widget _buildDatePicker(
    String title,
    TextEditingController editController,
  ) =>
      DatePicker(title: title, controller: editController);

  TextFormField _buildTextFormField({
    required String title,
    ValueChanged<String>? onChange,
    TextInputType? textInputType,
  }) =>
      TextFormField(
        style: Get.textTheme.headline6,
        cursorColor: subPrimaryColor,
        keyboardType: textInputType ?? TextInputType.streetAddress,
        onChanged: onChange,
        decoration: InputDecoration(
          labelText: title,
          contentPadding: EdgeInsets.only(left: 21),
        ),
      );

  Container _container({required Widget child}) => Container(
        margin: EdgeInsets.only(top: 12, bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          // boxShadow: [defaultBoxShadow],
          color: Colors.white,
        ),
        child: child,
      );
}
