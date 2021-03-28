import 'package:get/get.dart';
import 'package:getx_interface/application/rest_template.dart';
import 'package:getx_interface/models/pessoa_model.dart';
import 'package:getx_interface/repository/i_login_repository.dart';
import 'package:getx_interface/repository/login_repository.dart';

class ApplicationBindings implements Bindings {
  @override 
  void dependencies() {
    Get.put(RestTemplate());
    Get.lazyPut(() => RestTemplate.auth(), tag: RestTemplate.AUTH_TAG);

    Get.lazyPut(() => PessoaModel('Rodrigo'));
    Get.lazyPut(() => PessoaModel('Rahman'), tag: 'rahman');

    ///Para conseguir no [Get.find()] encontrar o [ILoginRepository]
    ///sendo que na verdade estamos retornando o [LoginRepository],
    ///basta tipar o [put] ou o [lazyPut] com o [ILoginRepository]
    Get.lazyPut<ILoginRepository>(() => LoginRepository());
  }
}