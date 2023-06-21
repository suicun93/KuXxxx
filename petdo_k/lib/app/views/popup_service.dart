import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
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
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));

    await remoteConfig.setDefaults(const {
      SHOW_DIALOG: false,
      DIALOG_URL_IMAGE: "",
      REDIRECT_URL_IMAGE: ""
    });
    await remoteConfig.fetchAndActivate();
    isShow = remoteConfig.getBool(SHOW_DIALOG);
    if (remoteConfig.getBool(SHOW_DIALOG)) {
      imageUrl = remoteConfig.getString(DIALOG_URL_IMAGE);
      redirectUrl = remoteConfig.getString(REDIRECT_URL_IMAGE);
      openDialog();
    } else {
      timer?.cancel();
    }
    remoteConfig.onConfigUpdated.listen((event) async {
      await remoteConfig.activate();
      imageUrl = remoteConfig.getString(DIALOG_URL_IMAGE);
      redirectUrl = remoteConfig.getString(REDIRECT_URL_IMAGE);
      isShow = remoteConfig.getBool(SHOW_DIALOG);
      if (remoteConfig.getBool(SHOW_DIALOG)) {
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
