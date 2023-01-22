import 'package:bt_thermal/routes/binding/main.dart';
import 'package:bt_thermal/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BinMain(),
      initialRoute: PageTo.main,
      getPages: PageTo.pages,
    );
  }
}
