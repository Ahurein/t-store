import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/firebase_options.dart';
import 'App.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // .then((value) => Get.put(AuthenticationRepository()));
  runApp(const App());
}