import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tipsAndTricks/application/application_bindings.dart';
import 'package:tipsAndTricks/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      getPages: [
        GetPage(
          name: '/',
          page: () => HomePage()
        ),
      ],
      initialBinding: ApplicationBindings(),
    );
  }
}