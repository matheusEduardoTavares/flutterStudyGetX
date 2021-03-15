import 'package:get/get.dart';

///Classe que iremos encapsular o [GetConnect]. É interessante
///fazer isso pois caso no futuro queiramos trocar o [GetConnect]
///pelo [Dio] ou até mesmo o [HTTP] tudo está centralizado
///aqui dentro do [RestTemplate].
 
class RestTemplate extends GetConnect {
  final String name;
  static const String NO_AUTH_TAG = "NO_AUTH_TAG";
  static const String AUTH_TAG = "AUTH_TAG";

  ///Sempre que fazemos um serviço que acessa um backend,
  ///normalmente tem 2 entradas de serviço: As não autenticadas,
  ///e as autenticadas. Por exemplo, fazer o login ou criar uma 
  ///conta não precisa de autenticação. Esses serviços sem 
  ///autenticação não precisam de um token JWT. Temos 2 formas
  ///de fazer acesso a serviços: 
  ///- Com serviços que vão enviar o token;
  ///- Com serviçs que não vão enviar o token;
  ///Então teríamos 2 classes: uma que não manda, e outro que
  ///manda. Poderíamos receber por parâmetro se precisa de 
  ///autenticação ou não e através de ifs trabalhar para passar
  ///ou não o token. Mas com o get podemos fazer isso de outra
  ///forma, usando um interceptor, através de 2 construtores.
  // RestTemplate(bool auth);
  RestTemplate() : name = 'Sem Autenticação';

  RestTemplate.auth() : name = 'Autenticação' {
    ///Assim:
    // httpClient.addAuthenticator((request) => null)
    ///Ou assim (o [addRequestModifier] será invocado sempre
    ///que chamarmos algum método http):
    httpClient.addRequestModifier((request) {
      request.headers['Authorization'] = 'tokenX';
      return request;
    });
  }
}