import 'package:get/get.dart';
import 'package:get_state_mixin_get_connect/models/giphy_model.dart';
import 'package:get_state_mixin_get_connect/repository/giphy_repository.dart';

class HomePageController extends GetxController with StateMixin<List<GiphyModel>> {
  final GiphyRepository _repository;

  ///Podemos usar essa estratégia, mas ela não é 
  ///interessante pois isso dificulta fazer testes
  ///unitários com esta classe, pois se recebermos 
  ///via parâmetro o repository, podemos simplesmente
  ///passar um mock que queremos.
  // final GiphyRepository _repository = Get.find();

  HomePageController(
    this._repository
  );

  ///Se fosse para fazer da forma padrão com outros
  ///gerenciamentos de estado ou até mesmo com o GetX,
  ///mas com outra estratégia, teríamos que criar uma
  ///lista de [GiphyModel] como observável, um variável
  ///booleana que é se está carregando ou não a requisição
  ///como observável, entre outras variáveis para poder
  ///controlar todo o acontecimento.
  // final gifs = <GiphyModel>[].obs;
  // final isLoading = false.obs;

  ///Para telas que tem apenas a característica de 
  ///buscar um dado e retornar, o GetX tornou mais fácil
  ///isso, usando um mixin chamado [StateMixin]. O 
  ///[StateMixin] tem um controle de estado dentro
  ///dele para esse tipo de coisa que vamos fazer.
  
  @override
  void onInit() {
    super.onInit();

    ///Basta apenas fazer a requisição no [onInit] e 
    ///delegar para o [GetX] agora fazer esse controle
    ///para nós, delegando essa variável, e fazer 
    ///o controle de load, ou até mesmo do error.
    _repository.findAll().then((resp) {
      ///O [change] é do [StateMixin] e passamos para
      ///ele 3 parâmetros, que é o estado que vamos
      ///controlar. Para tal precisamos tipar o 
      ///[StateMixin], pois o tipo do primeiro parâmetro
      ///será esse tipo passado, que no caso é o novo
      ///estado da [List<GiphyModel>], e depois temos 
      ///o parâmetro nomeado status que passamos para 
      ///ele um [RxStatus], que por sua vez pode ser de
      ///[error], [loading] ou de [success]
      change(
        resp,
        status: RxStatus.success(),
      );
    },
    ///Como estamos chamando uma requisição de um 
    ///[GetConnect], temos para a requisição o [onError],
    ///em que podemos tratar o erro
    onError: (err) {
      print(err);
      ///O estado vai para nulo e adiciona um novo estado,
      ///que é de erro ao buscar gifs
      change(
        null,
        status: RxStatus.error(
          'Erro ao buscar Gifs',
        ),
      );
    }
    ///Só com isso temos os 3 status controlados, pois
    ///ao abrir a tela o status inicial do controller
    ///é o de loading. Aí se der sucesso cai no primeiro
    ///change que mostra o success, e se der erro cai no
    ///[onError] onde o change mostra o error.
    
    );
  }
}