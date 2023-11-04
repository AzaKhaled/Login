import 'package:data_verivication/firebase_options.dart';
import 'package:data_verivication/home_view.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
//import 'package:varification/new.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeView(),
    );
  }
}
