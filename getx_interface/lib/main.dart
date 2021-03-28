import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_interface/application/application_bindings.dart';
import 'package:getx_interface/pages/home_page.dart';

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