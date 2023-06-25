import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils.dart';

class PopupService extends GetxService {
  var imageUrl = '';
  var redirectUrl = '';
  var isShow = false;
  Timer? timer;
  Future<void> init() async {
    docPopup.snapshots().listen((event) {
      isShow = event.data()?[SHOW_DIALOG];
      imageUrl = event.data()?[DIALOG_URL_IMAGE];
      redirectUrl = event.data()?[REDIRECT_URL_IMAGE];
      print('$isShow -- $imageUrl--$redirectUrl');
      if (isShow) {
        openDialog();
      } else {
        timer?.cancel();
      }
    });
  }

  void openDialog() {
    if (!isDialogShowing) {
      isDialogShowing = true;
      Get.dialog(AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: GestureDetector(
          onTap: () {
            _launchUrl(redirectUrl);
          },
          child: _buildImage(imageUrl),
        ),
      )).then((value) {
        isDialogShowing = false;
        if (isShow) {
          timer = Timer.periodic(Duration(minutes: 1), (timer) {
            openDialog();
          });
        } else {
          timer?.cancel();
        }
      });
    }
  }

  _buildImage(String url) {
    if (url.contains('http')) {
      return Container(
        margin: const EdgeInsets.all(16),
        child: FadeInImage.assetNetwork(
            placeholder: "images/img_loading.png",
            image: url,
            fit: BoxFit.fill),
      );
    } else {
      return Image.asset(url);
    }
  }

  _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
