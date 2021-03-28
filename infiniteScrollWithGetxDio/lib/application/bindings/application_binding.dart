import 'package:dio/dio.dart';
import 'package:get/get.dart';

const YOUR_IP_HERE = '127.0.0.1';

///O próprio GetX faz a gerência das instâncias, e isso
///economiza memória. Então o que ficar aqui no
///[application_binding] não irá morrer nunca
class ApplicationBinding implements Bindings {

  ///Colocamos aqui todas as dependências genéricas, que 
  ///serão usadas na aplicação inteira
  @override 
  void dependencies() {
    ///Deve criar o [Dio] apenas uma vez
    Get.lazyPut(() => Dio(
      BaseOptions(
        baseUrl: 'http://$YOUR_IP_HERE:3333'
      )
    ));
  }
}