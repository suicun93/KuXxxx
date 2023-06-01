import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../../common/const.dart';
import '../../../../../../../../views/date_picker.dart';
import '../../../../../../../../views/loading_view.dart';
import '../../../../../../controllers/home_controller.dart';
import '../controllers/add_pet_controller.dart';

class AddPetView extends GetView<AddPetController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: WillPopScope(
          onWillPop: () => controller.back(),
          child: Container(
            color: backgroundColorShadow,
            child: Column(
              children: [
                _appbar,
                Expanded(
                  child: controller.ready.value
                      ? ListView(
                          padding: EdgeInsets.only(top: 4, bottom: 50),
                          children: [
                            SizedBox(height: 16),
                            GestureDetector(
                              onTap: controller.getImage,
                              child: Stack(
                                children: [
                                  Center(
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: controller.image.value == null
                                              ? Image.asset(
                                                  'images/logo.png',
                                                  width: 156,
                                                  height: 156,
                                                )
                                              : Image.file(
                                                  File(
                                                    controller
                                                        .image.value!.path,
                                                  ),
                                                  width: 156,
                                                  height: 156,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                        SizedBox(height: 16),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: subPrimaryColor,
                                      ),
                                      padding: EdgeInsets.all(8),
                                      child: Image.asset(
                                        'images/ic_camera.png',
                                        color: Colors.white,
                                        width: 16,
                                        height: 16,
                                      ),
                                    ),
                                    bottom: 0,
                                    right: (size - 156) / 2 - 16,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 28),
                            _container(
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: CupertinoSlidingSegmentedControl(
                                      children: {
                                        true: Text(
                                          'Chó',
                                          style: Get.textTheme.button?.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                        false: Text(
                                          'Mèo',
                                          style: Get.textTheme.button?.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      },
                                      thumbColor: subPrimaryColor,
                                      backgroundColor: buttonDisableColor,
                                      groupValue: controller.isDog.value,
                                      onValueChanged: (_) =>
                                          controller.isDog.toggle(),
                                    ),
                                  ),
                                  SizedBox(height: 24),
                                  _buildTextFormField(
                                      title: 'Tên thú cưng',
                                      onChange: (_) =>
                                          controller.petName.value = _),
                                  SizedBox(height: 24),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 21,
                                    ),
                                    height: 45,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        width: 0.5,
                                        style: BorderStyle.solid,
                                        color: borderColor,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: DropdownButton<bool>(
                                            value: controller.gender.value,
                                            focusColor: Colors.white,
                                            hint: Center(
                                              child: Text(
                                                'Giới tính',
                                                style: Get.textTheme.bodyText2,
                                              ),
                                            ),
                                            icon: Container(),
                                            dropdownColor: Colors.white,
                                            itemHeight: 48,
                                            menuMaxHeight: 250,
                                            underline: Container(),
                                            onChanged: (_) =>
                                                controller.gender.value = _,
                                            selectedItemBuilder: (_) => [
                                              true,
                                              false
                                            ]
                                                .map<DropdownMenuItem<bool>>(
                                                  (item) =>
                                                      DropdownMenuItem<bool>(
                                                    value: item,
                                                    child: Container(
                                                      child: Text(
                                                        item ? 'Đực' : 'Cái',
                                                        style: Get.textTheme
                                                            .headline6,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                            items: [true, false]
                                                .map<DropdownMenuItem<bool>>(
                                                  (item) =>
                                                      DropdownMenuItem<bool>(
                                                    value: item,
                                                    child: Text(
                                                      item ? 'Đực' : 'Cái',
                                                      style: Get
                                                          .textTheme.headline6,
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ),
                                        Image.asset(
                                          'images/ic_dropdown.png',
                                          width: 10,
                                          color: textColorFaint,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 24),
                                  _buildDatePicker(
                                    'Ngày sinh',
                                    controller.birthdayController,
                                  ),
                                  SizedBox(height: 24),
                                  _buildTextFormField(title: 'Giống', onChange: (_) => controller.type.value = _),
                                  SizedBox(height: 24),
                                  _buildTextFormField(
                                      title: 'Cân nặng (kg)',
                                      textInputType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      onChange: (weight) => controller.petWeight
                                          .value = double.parse(weight)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                              ),
                              child: ElevatedButton(
                                onPressed: controller.add,
                                child: Text('Add'),
                              ),
                            ),
                            SizedBox(height: 50),
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
                child: Text('Add new pet', style: Get.textTheme.titleSmall),
              ),
            ),
            SizedBox(width: 60),
          ],
        ),
      );

  Container _container({required Widget child}) => Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [defaultBoxShadow],
          color: Colors.white,
        ),
        child: child,
      );

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

  Widget _buildDatePicker(
    String title,
    TextEditingController editController,
  ) =>
      DatePicker(title: title, controller: editController);
}
