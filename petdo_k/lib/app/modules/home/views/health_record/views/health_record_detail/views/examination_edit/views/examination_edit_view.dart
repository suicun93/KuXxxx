import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../../../common/const.dart';
import '../../../../../../../../../views/date_picker.dart';
import '../../../../../../../../../views/loading_view.dart';
import '../../../../../../../controllers/home_controller.dart';
import '../controllers/examination_edit_controller.dart';

class ExaminationEditView extends GetView<ExaminationEditController> {
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
                            controller.title.value,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  _buildDatePicker(
                                    'Ngày khám',
                                    controller.vaccineDateController,
                                  ),
                                  controller.editMode.value
                                      ? SizedBox(height: 24)
                                      : _divider,
                                  _buildTextFormField(
                                    title: 'Thân nhiệt',
                                    editController:
                                        controller.thanNhietController,
                                  ),
                                  controller.editMode.value
                                      ? SizedBox(height: 24)
                                      : _divider,
                                  _buildTextFormField(
                                    title: 'Cân nặng',
                                    editController:
                                        controller.canNangController,
                                  ),
                                  controller.editMode.value
                                      ? SizedBox(height: 24)
                                      : _divider,
                                  _buildTextFormField(
                                    title: 'Các triệu chứng',
                                    editController:
                                        controller.trieuChungController,
                                  ),
                                  controller.editMode.value
                                      ? SizedBox(height: 24)
                                      : _divider,
                                  _buildTextFormField(
                                    title: 'Chẩn đoán bệnh',
                                    editController:
                                        controller.chanDoanBenhController,
                                  ),
                                  controller.editMode.value
                                      ? SizedBox(height: 24)
                                      : _divider,
                                  _buildTextFormField(
                                    title: 'Các loại thuốc sử dụng',
                                    editController:
                                        controller.cacLoaiThuocController,
                                  ),
                                  controller.editMode.value
                                      ? SizedBox(height: 24)
                                      : _divider,
                                  _buildDatePicker(
                                    'Ngày tái khám',
                                    controller.revaccineDateController,
                                  ),
                                  controller.editMode.value
                                      ? SizedBox(height: 24)
                                      : _divider,
                                  _buildTextFormField(
                                    title: 'Bác sỹ tiếp nhận',
                                    editController: controller.bacSyController,
                                  ),
                                  controller.editMode.value
                                      ? SizedBox(height: 24)
                                      : _divider,
                                  _buildTextFormField(
                                    title: 'Sđt liên hệ',
                                    editController:
                                        controller.doctorPhoneController,
                                  ),
                                  controller.editMode.value
                                      ? SizedBox(height: 24)
                                      : _divider,
                                  _buildTextFormField(
                                    title: 'Cơ sở khám',
                                    editController: controller.coSoController,
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                            SizedBox(height: 24),
                            Row(
                              children: [
                                SizedBox(width: 16),
                                Expanded(
                                  child: TextButton(
                                    onPressed: controller
                                        .deleteButton((_) => _showDialog(_)),
                                    child: Text(
                                      controller.editMode.value ? 'Hủy' : 'Xóa',
                                    ),
                                    style: controller.editMode.value
                                        ? Get.theme.textButtonTheme.style
                                        : _redButtonTheme,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: controller.editButton,
                                    child: Text(
                                      controller.editMode.value
                                          ? 'Hoàn thành'
                                          : 'Chỉnh sửa',
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                              ],
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

  ButtonStyle? get _redButtonTheme {
    return Get.theme.textButtonTheme.style?.copyWith(
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          side: BorderSide(
            color: red,
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      foregroundColor: MaterialStateProperty.all<Color>(red),
    );
  }

  Widget _buildDatePicker(
    String title,
    TextEditingController editController,
  ) =>
      controller.editMode.value
          ? DatePicker(title: title, controller: editController)
          : _readonly(title, editController);

  Widget _buildTextFormField({
    required String title,
    ValueChanged<String>? onChange,
    required TextEditingController editController,
  }) =>
      controller.editMode.value
          ? TextFormField(
              style: Get.textTheme.headline6,
              cursorColor: subPrimaryColor,
              keyboardType: TextInputType.streetAddress,
              controller: editController,
              onChanged: onChange,
              decoration: InputDecoration(
                labelText: title,
                contentPadding: EdgeInsets.only(left: 21),
              ),
            )
          : _readonly(title, editController);

  Widget _readonly(
    String title,
    TextEditingController editController,
  ) {
    return Row(
      children: [
        Text('$title', style: Get.textTheme.bodyText2),
        SizedBox(width: 8),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              editController.text,
              style: Get.textTheme.headline6,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
      ],
    );
  }

  Container _container({required Widget child}) => Container(
        margin: EdgeInsets.only(top: 12, bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: child,
      );

  Divider get _divider => Divider(
        color: Color(0xffF1F1F4),
        thickness: 1.5,
        height: 32,
      );

  void _showDialog(VoidCallback onPress) => showDialog(
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
                    'Bạn muốn xóa lịch khám?',
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
