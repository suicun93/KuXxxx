import 'package:country_list_pick/country_list_pick.dart';
import 'package:country_list_pick/support/code_countries_en.dart';
import 'package:country_list_pick/support/code_countrys.dart';
import 'package:flutter/material.dart';

import 'my_selection_list.dart';

class MyCountryListPick extends StatefulWidget {
  MyCountryListPick({
    this.onChanged,
    this.initialSelection,
    this.appBar,
    this.pickerBuilder,
    this.countryBuilder,
    this.theme,
    this.useUiOverlay = true,
    this.useSafeArea = false,
  });

  final String? initialSelection;
  final ValueChanged<CountryCode?>? onChanged;
  final PreferredSizeWidget? appBar;
  final Widget Function(BuildContext context, CountryCode? countryCode)?
      pickerBuilder;
  final CountryTheme? theme;
  final Widget Function(BuildContext context, CountryCode countryCode)?
      countryBuilder;
  final bool useUiOverlay;
  final bool useSafeArea;

  @override
  _MyCountryListPickState createState() {
    List<Map> jsonList =
        theme?.showEnglishName ?? true ? countriesEnglish : codes;

    List elements = jsonList
        .map((s) => CountryCode(
              name: s['name'],
              code: s['code'],
              dialCode: s['dial_code'],
              flagUri: 'flags/${s['code'].toLowerCase()}.png',
            ))
        .toList();
    return _MyCountryListPickState(elements);
  }
}

class _MyCountryListPickState extends State<MyCountryListPick> {
  CountryCode? selectedItem;
  List elements = [];

  _MyCountryListPickState(this.elements);

  @override
  void initState() {
    if (widget.initialSelection != null) {
      selectedItem = elements.firstWhere(
          (e) =>
              (e.code.toUpperCase() ==
                  widget.initialSelection!.toUpperCase()) ||
              (e.dialCode == widget.initialSelection),
          orElse: () => elements[0] as CountryCode);
    } else {
      selectedItem = elements[0];
    }

    super.initState();
  }

  void _awaitFromSelectScreen(
    BuildContext context,
    PreferredSizeWidget? appBar,
    CountryTheme? theme,
  ) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MySelectionList(
            elements,
            selectedItem,
            appBar: widget.appBar ?? AppBar(title: Text("Select Country")),
            theme: theme,
            countryBuilder: widget.countryBuilder,
            useUiOverlay: widget.useUiOverlay,
            useSafeArea: widget.useSafeArea,
          ),
        ));

    setState(() {
      selectedItem = result ?? selectedItem;
      widget.onChanged!(result ?? selectedItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _awaitFromSelectScreen(context, widget.appBar, widget.theme);
      },
      child: widget.pickerBuilder != null
          ? widget.pickerBuilder!(context, selectedItem)
          : Flex(
              direction: Axis.horizontal,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (widget.theme?.isShowFlag ?? true == true)
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Image.asset(
                        selectedItem!.flagUri!,
                        package: 'country_list_pick',
                        width: 32.0,
                      ),
                    ),
                  ),
                if (widget.theme?.isShowCode ?? true == true)
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(selectedItem.toString()),
                    ),
                  ),
                if (widget.theme?.isShowTitle ?? true == true)
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(selectedItem!.toCountryStringOnly()),
                    ),
                  ),
                if (widget.theme?.isDownIcon ?? true == true)
                  Flexible(
                    child: Icon(Icons.keyboard_arrow_down),
                  )
              ],
            ),
    );
  }
}
