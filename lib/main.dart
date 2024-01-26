import 'package:alarm/alarm.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_00/homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Alarm.init(showDebugLogs: true);
  runApp(MaterialApp(
      theme: FlexThemeData.light(scheme: FlexScheme.deepPurple),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.deepPurple),
      debugShowCheckedModeBanner: false,
      home: HomeScreen()));
}
