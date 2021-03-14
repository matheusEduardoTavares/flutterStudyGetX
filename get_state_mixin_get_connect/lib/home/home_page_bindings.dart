import 'package:get/get.dart';
import 'package:get_state_mixin_get_connect/home/home_page_controller.dart';
import 'package:get_state_mixin_get_connect/repository/giphy_repository.dart';

class HomePageBindings implements Bindings {
  @override 
  void dependencies() {
    Get.lazyPut(() => GiphyRepository());

    ///O lazy, quando for acessado a primeira vez irá
    ///instanciar essa classe. Por isso lazy, é uma 
    ///inicialização preguiçosa, a instância só é 
    ///criada quando ela for ser usada.
    Get.lazyPut(() => HomePageController(Get.find()));
  }
}