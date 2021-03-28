import 'package:get/get.dart';
import 'package:infiniteScrollWithGetxDio/modules/home/controller/home_controller.dart';
import 'package:infiniteScrollWithGetxDio/repositories/user_repository.dart';

class HomeBindings implements Bindings {
  @override 
  void dependencies() {
    Get.lazyPut(() => UserRepository(
      Get.find()
    ));

    Get.lazyPut(() => HomeController(
      Get.find()
    ));
  }
}