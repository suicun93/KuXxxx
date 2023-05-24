import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'const.dart';

void toast({required String content}) {
  Fluttertoast.showToast(
    msg: content,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 3,
    backgroundColor: primaryColor.withAlpha(220),
    textColor: Colors.white,
    fontSize: 17,
  );
}
