import 'package:get/get.dart';
import 'package:tipsAndTricks/application/rest_template.dart';
import 'package:tipsAndTricks/models/pessoa_model.dart';

class ApplicationBindings implements Bindings {
  @override 
  void dependencies() {
    ///Para conseguir separar as instâncias, basta passar
    ///tags para as instâncias
    // Get.put(RestTemplate(), tag: RestTemplate.NO_AUTH_TAG);
    Get.put(RestTemplate());
    Get.put(RestTemplate.auth(), tag: RestTemplate.AUTH_TAG);

    Get.put(PessoaModel('Rodrigo'));
    Get.put(PessoaModel('Rahman'), tag: 'rahman');
  }
}