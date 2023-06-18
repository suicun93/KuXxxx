import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petdo_k/generated/locales.g.dart';

import '../common/const.dart';

class DatePicker extends StatelessWidget {
  final String title;
  final TextEditingController controller;

  const DatePicker({
    Key? key,
    required this.title,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !Platform.isIOS
          ? () async {
              final now = DateTime.now();
              final date = formatterFullDate(
                await showDatePicker(
                  context: Get.context!,
                  initialDate: now,
                  helpText: '${LocaleKeys.select.tr} $title'.capitalizeFirst,
                  // Can be used as title
                  cancelText: LocaleKeys.exit.tr,
                  confirmText: LocaleKeys.select.tr,
                  fieldLabelText: title,
                  fieldHintText:
                      '${LocaleKeys.enter.tr} $title'.capitalizeFirst,
                  errorFormatText: LocaleKeys.wrong_date_format.tr,
                  errorInvalidText: LocaleKeys.date_too_far.tr,
                  firstDate: now.subtract(Duration(days: 365)),
                  lastDate: now.add(Duration(days: 365)),
                  builder: (context, child) => Theme(
                    data: defaultTheme.copyWith(
                      primaryColor: subPrimaryColor,
                      colorScheme: defaultTheme.colorScheme.copyWith(
                        primary: subPrimaryColor,
                        onPrimary: Colors.white,
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            subPrimaryColor,
                          ),
                          alignment: Alignment.center,
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(
                              vertical: 3,
                              horizontal: 10,
                            ),
                          ),
                          shadowColor: MaterialStateProperty.all<Color>(
                            Colors.transparent,
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white,
                          ),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                    child: child!,
                  ),
                ),
              );
              if (date != null && controller.text != date) {
                controller.text = date;
              }
            }
          : () async {
              final now = DateTime.now();
              return showModalBottomSheet(
                context: Get.context!,
                builder: (BuildContext builder) => Container(
                  height: Get.height / 3,
                  color: Colors.white,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (picked) {
                      final date = formatterFullDate(picked);
                      if (controller.text != date) {
                        controller.text = date!;
                      }
                    },
                    initialDateTime: now,
                    minimumYear: now.year - 1,
                    maximumYear: now.year + 1,
                  ),
                ),
              );
            },
      child: TextFormField(
        controller: controller,
        style: Get.textTheme.headline6,
        cursorColor: subPrimaryColor,
        readOnly: true,
        enabled: false,
        decoration: InputDecoration(
            labelText: title,
            contentPadding: EdgeInsets.only(left: 21),
            suffixIcon: Icon(CupertinoIcons.calendar)),
      ),
    );
  }
}
