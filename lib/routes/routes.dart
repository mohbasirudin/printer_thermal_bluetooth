import 'package:bt_thermal/routes/binding/main.dart';
import 'package:bt_thermal/view/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageTo {
  static const main = "/";

  static List<GetPage> pages = [
    _page(
      name: main,
      page: const PageMain(),
      binding: BinMain(),
    ),
  ];

  static GetPage _page({
    required String name,
    required Widget page,
    Bindings? binding,
  }) {
    return GetPage(
      name: name,
      page: () => page,
      binding: binding,
    );
  }
}
