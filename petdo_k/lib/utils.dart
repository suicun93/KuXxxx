import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
const popUpCollection = 'Popup';

const baseUrl = 'https://api.thecatapi.com/v1/';
const dogApi =
    'live_S3kXjyJeQFZ9n5zWmad6t72eRFMrXYNpphfztWK9zF7KgULtZ3wef784DIUHCEm9';
const catApi =
    'live_CJFk5eG4T4bOivfJv5BZ0M98kZIbo17evGbMEGZ81wOMzf4L6Whwd8eEQ6WBTJVl';

final dbWelCome = FirebaseFirestore.instance.collection(welcomeCollection);
final dbHealth = FirebaseFirestore.instance.collection(healthCollection);
final docPopup =
    FirebaseFirestore.instance.collection(popUpCollection).doc(popUpCollection);
final storageRef = FirebaseStorage.instance.ref();

var isImageUploading = false;
var isDialogShowing = false;

const String SHOW_DIALOG = "show_dialog";
const String DIALOG_URL_IMAGE = "dialog_url_image";
const String REDIRECT_URL_IMAGE = "redirect_url_image";
