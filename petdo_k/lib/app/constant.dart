import 'package:cloud_firestore/cloud_firestore.dart';

const welcomeCollection = 'Welcome';
const loginDocument = 'login';
const registerDocument = 'register';
const emailCollection = 'email';
const phoneCollection = 'phone';

final dbWelCome = FirebaseFirestore.instance.collection(welcomeCollection);
