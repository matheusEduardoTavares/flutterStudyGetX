import 'package:get/get.dart';
import 'package:get_state_mixin_get_connect/models/giphy_model.dart';

///Extendendo a classe do [GetConnect] automaticamente
///nos dá o acesso a fazer qualquer requisição HTTP.
///O [GetConnect] tem um ciclo de vida, então dentro
///dele temos o [onInit] em que podemos fazer alguma
///coisa antes de fazer o acesso a qualquer serviço.
///Há um pequeno ciclo de vida para fazer sua função.
///Conseguimos trabalhar com sockets com o [GetConnect]
///também, então temos essa funcionalidade. Alguns 
///exemplos de funcionalidades que podemos adicionar
///no [onInit] é um [baseUrl], um [defaultDecoder], o
///[RequestModifier] para modificar algo antes de fazer
///o request ou o [ResponseModifier] ou uma autenticação
///caso tenhamos. Podemos configurar algumas retentativas.
class GiphyRepository extends GetConnect {
  Future<List<GiphyModel>> findAll() async {
    ///Se não usarmos generics, por padrão é retornado
    ///um [Response<dynamic>], e depois teríamos que
    ///fazer as conversões necessárias. Mas não é isso
    ///que queremos, já querems que venha tudo certo, 
    ///e para tal, basta passar no método http o generics,
    ///e o [GetConnect] e depois usar um decoder para 
    ///converter a resposta que queremos para o nosso 
    ///model
    final response = await get<List<GiphyModel>>(
      'http://api.giphy.com/v1/gifs/trending', 
      query: {
        'api_key': 'NqbVHGIPsevR7aNbRB89SAsjxznqVvp8',
      },
      decoder: (response) {
        return response['data']?.map<GiphyModel>((d) => GiphyModel(
          d['id'],
          d['images']['downsized']['url']
        ))?.toList() ?? [];
      } 
    );

    ///Os métodos do [GetConnect] não error-safety,
    ///ou seja, não precisamos adicionar try catch,
    ///automaticamente já é tratado os erros para nós,
    ///de forma a retornar um [response.hasError] como
    ///true.
    if (response.hasError) {
      throw Exception(response.statusText);
    }

    return response.body;
  }
}