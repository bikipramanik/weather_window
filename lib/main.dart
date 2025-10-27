import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_window/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock device orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Lock to portrait up
    // DeviceOrientation.portraitDown, // you can include this if you want upside down portrait too
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}
