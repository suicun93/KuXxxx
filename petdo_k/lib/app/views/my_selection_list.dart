import 'package:country_list_pick/country_list_pick.dart';
import 'package:country_list_pick/country_selection_theme.dart';
import 'package:country_list_pick/support/code_country.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../common/const.dart';

class MySelectionList extends StatefulWidget {
  MySelectionList(this.elements, this.initialSelection,
      {Key? key,
      this.appBar,
      this.theme,
      this.countryBuilder,
      this.useUiOverlay = true,
      this.useSafeArea = false})
      : super(key: key);

  final PreferredSizeWidget? appBar;
  final List elements;
  final CountryCode? initialSelection;
  final CountryTheme? theme;
  final Widget Function(BuildContext context, CountryCode)? countryBuilder;
  final bool useUiOverlay;
  final bool useSafeArea;

  @override
  _MySelectionListState createState() => _MySelectionListState();
}

class _MySelectionListState extends State<MySelectionList> {
  late List countries;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    countries = widget.elements;
    countries.sort((a, b) {
      return a.name.toString().compareTo(b.name.toString());
    });
    super.initState();
  }

  void _sendDataBack(CountryCode initialSelection) {
    Navigator.pop(Get.context!, initialSelection);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> mainList = List.from(
      [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            widget.theme?.searchText ?? 'SEARCH',
            style: Get.textTheme.button?.copyWith(
              color: widget.theme?.labelColor ?? Colors.black,
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: TextField(
            style: Get.textTheme.bodyText1,
            cursorColor: subPrimaryColor,
            controller: _controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintStyle: Get.textTheme.bodyText2,
              contentPadding: EdgeInsets.only(
                left: 15,
                bottom: 0,
                top: 0,
                right: 15,
              ),
              hintText: widget.theme?.searchHintText ?? "Search...",
            ),
            onChanged: _filterElements,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            widget.theme?.lastPickText ?? 'LAST PICK',
            style: Get.textTheme.button?.copyWith(
              color: widget.theme?.labelColor ?? Colors.black,
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: Material(
            color: Colors.transparent,
            child: ListTile(
              title: Row(
                children: [
                  Image.asset(
                    widget.initialSelection!.flagUri ?? '',
                    package: 'country_list_pick',
                    width: 30.0,
                  ),
                  SizedBox(width: 15),
                  Flexible(
                    child: Text(
                      (widget.initialSelection!.name ?? '') +
                          ' (' +
                          (widget.initialSelection!.dialCode ?? '') +
                          ')',
                      overflow: TextOverflow.ellipsis,
                      style: Get.textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
              trailing: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Icon(CupertinoIcons.heart_fill, color: Colors.redAccent),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            widget.theme?.searchHintText ?? "Search...",
            style: Get.textTheme.button?.copyWith(
              color: widget.theme?.labelColor ?? Colors.black,
            ),
          ),
        ),
      ],
    );
    final List<Widget> listCountries = List.generate(
      countries.length,
      (index) => widget.countryBuilder != null
          ? widget.countryBuilder!(
              context,
              countries.elementAt(index),
            )
          : getListCountry(countries.elementAt(index)),
    );
    mainList.addAll(listCountries);

    return Scaffold(
      appBar: widget.appBar,
      body: Container(
        color: Color(0xfff4f4f4),
        child: ListView(children: mainList),
      ),
    );
  }

  Widget getListCountry(
    CountryCode countryCode,
  ) {
    return Container(
      height: 50,
      color: Colors.white,
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          onTap: () => _sendDataBack(countryCode),
          title: Row(
            children: [
              Image.asset(
                countryCode.flagUri ?? '',
                package: 'country_list_pick',
                width: 30.0,
              ),
              SizedBox(width: 15),
              Flexible(
                child: Text(
                  (countryCode.name ?? '') +
                      ' (' +
                      (countryCode.dialCode ?? '') +
                      ')',
                  style: Get.textTheme.bodyText1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _filterElements(String s) {
    s = s.toUpperCase();
    setState(() => countries = widget.elements
        .where((e) =>
            e.code.contains(s) ||
            e.dialCode.contains(s) ||
            e.name.toUpperCase().contains(s))
        .toList());
  }
}
