import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petdo_k/generated/locales.g.dart';
import 'package:url_launcher/url_launcher.dart';

const welcomeCollection = 'Welcome';
const loginDocument = 'login';
const registerDocument = 'register';
const emailCollection = 'email';
const phoneCollection = 'phone';
const passwordField = 'password';
const infoDocument = 'info';
const petDocument = 'Pet';
const healthCollection = 'Health';
const vaccineCollection = 'Vaccine';
const vetCollection = 'Vet';

const baseUrl = 'https://api.thecatapi.com/v1/';
const dogApi =
    'live_S3kXjyJeQFZ9n5zWmad6t72eRFMrXYNpphfztWK9zF7KgULtZ3wef784DIUHCEm9';
const catApi =
    'live_CJFk5eG4T4bOivfJv5BZ0M98kZIbo17evGbMEGZ81wOMzf4L6Whwd8eEQ6WBTJVl';

final dbWelCome = FirebaseFirestore.instance.collection(welcomeCollection);
final dbHealth = FirebaseFirestore.instance.collection(healthCollection);
final storageRef = FirebaseStorage.instance.ref();

var isImageUploading = false;
var isDialogShowing = false;

const String SHOW_DIALOG = "show_dialog";
const String DIALOG_URL_IMAGE = "dialog_url_image";
const String REDIRECT_URL_IMAGE = "redirect_url_image";

checkRemoteConfig(BuildContext context) async{
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
  if (remoteConfig.getBool(SHOW_DIALOG)) {
    if (!context.mounted) return;
    _showMyDialog(context, remoteConfig.getString(DIALOG_URL_IMAGE),
        remoteConfig.getString(REDIRECT_URL_IMAGE));
  }
  remoteConfig.onConfigUpdated.listen((event) async {
    await remoteConfig.activate();
    if (remoteConfig.getBool(SHOW_DIALOG)) {
      if (!context.mounted) return;
      _showMyDialog(context, remoteConfig.getString(DIALOG_URL_IMAGE),
          remoteConfig.getString(REDIRECT_URL_IMAGE));
    }
  });
}

_showMyDialog(BuildContext context, String url, String launchUrl) {
  if (isDialogShowing) {
    return Future;
  } else {
    isDialogShowing = true;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Image'),
          contentPadding: EdgeInsets.zero,
          content: GestureDetector(
            onTap: () {
              _launchUrl(launchUrl);
            },
            child: _buildImage(url),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Dismiss'),
              onPressed: () {
                isDialogShowing = false;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
