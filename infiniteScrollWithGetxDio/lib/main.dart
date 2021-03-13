import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infiniteScrollWithGetxDio/application/bindings/application_binding.dart';
import 'package:infiniteScrollWithGetxDio/modules/home/home_bindings.dart';
import 'package:infiniteScrollWithGetxDio/modules/home/view/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///No GetX temos 2 formas de fazer injeção de 
    ///dependências:
    
    ///Chama e já deixa a instância pronta
    // Get.put()

    ///Chama somente quando solicitarmos para o get a 
    ///primeira vez.
    // Get.lazyPut()

    ///Outra forma é usando binds, geramos estruturas de 
    ///binds dentro dos [GetPage]

    ///Usamos o [GetMaterialApp] ao invés do [MaterialApp]
    return GetMaterialApp(
      initialBinding: ApplicationBinding(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          ///Antes de chamar o [page], serão carregados os 
          ///Bindings do [HomeBindings]. Como são Bindings 
          ///somente desta página, ao dar dispose na página,
          ///suas dependências serão perdidas
          binding: HomeBindings(),
          page: () => HomePage(Get.find()),
        ),
      ],
    );
  }
}