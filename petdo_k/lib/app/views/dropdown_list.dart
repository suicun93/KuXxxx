// ignore_for_file: hash_and_equals

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/const.dart';

class DropdownList extends StatelessWidget {
  final List<DropboxItem> list;
  final String hintText;
  final DropboxItem? selectedItem;
  final ValueChanged<DropboxItem?>? onSelect;

  const DropdownList({
    Key? key,
    required this.list,
    required this.hintText,
    required this.selectedItem,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.fromLTRB(0, 12, 8, 12),
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: selectedItem == null ? Colors.white : subPrimaryColor,
        boxShadow: [defaultBoxShadow],
      ),
      child: DropdownButton<DropboxItem>(
        value: selectedItem,
        hint: Center(
          child: Text(
            hintText,
            style: Get.textTheme.bodyText2,
          ),
        ),
        icon: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Image.asset(
            'images/ic_dropdown.png',
            width: 10,
            color: selectedItem != null ? Colors.white : subPrimaryColor,
          ),
        ),
        dropdownColor: subPrimaryColor,
        itemHeight: 48,
        menuMaxHeight: 250,
        underline: Container(),
        onChanged: onSelect,
        selectedItemBuilder: (context) => list
            .map<DropdownMenuItem<DropboxItem>>(
              (item) => DropdownMenuItem<DropboxItem>(
                value: item,
                child: Text(
                  item.value,
                  overflow: TextOverflow.ellipsis,
                  style: Get.textTheme.headline6?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            )
            .toList(),
        items: list
            .map<DropdownMenuItem<DropboxItem>>(
              (item) => DropdownMenuItem<DropboxItem>(
                value: item,
                child: Text(
                  item.value,
                  overflow: TextOverflow.ellipsis,
                  style: Get.textTheme.headline6?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class DropboxItem {
  final String key;
  final String value;

  DropboxItem(this.key, this.value);

  @override
  bool operator ==(Object other) {
    if (Object is DropboxItem) return false;
    return key == (other as DropboxItem).key;
  }
}
