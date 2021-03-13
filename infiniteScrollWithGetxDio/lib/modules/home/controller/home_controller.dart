import 'package:get/get.dart';
import 'package:infiniteScrollWithGetxDio/models/pagination_filter.dart';
import 'package:infiniteScrollWithGetxDio/models/user_model.dart';
import 'package:infiniteScrollWithGetxDio/repositories/user_repository.dart';

class HomeController extends GetxController {
  ///O próprio getX trata a renderização da tela novamente 
  ///quando um observável sofre uma alteração, uma vez
  ///que todos os listeners são notificados
  HomeController(
    this._userRepository
  );

  final UserRepository _userRepository;
  ///Obrigatoriamente o getX pede para que essa variável
  ///de usuários seja observável
  // final users = <UserModel>[];
  ///Podemos fazer isso de 2 formas:
  // final _users = Rx<List<UserModel>>();
  ///ou:
  final _users = <UserModel>[].obs;
  ///Se não deixarmos essa variável [_users] privada,
  ///então poderíamos acessar ela direto a partir do 
  ///controller que é passado via Bindings para a view,
  ///porém se fizermos isso, estamos dando para a view a
  ///change dela fazer alterações nesse controller, nesse
  ///observável, e não queremos que seja feito isso. As únicas
  ///atualizações de estados nas nossas classes devem ser feitas
  ///pelo controller. Só ele pode alterar o estado, isso é 
  ///organização de código, mas podemos ter acesso a leitura
  ///desses atributos lá.
  
  ///Queremos tirar uma lista dos valores de todos os 
  ///[value] da lista de usuários
  List<UserModel> get users => _users.toList();

  ///isso troca a lista normal para um [RxList]
  final _paginationFilter = PaginationFilter().obs;
  final _lastPage = false.obs;

  ///No GetX nossos controllers têm ciclo de vidas, pois 
  ///não precisamos usar [StatefulWidget] usando o GetX,
  ///salvo poucas exceções.

  @override 
  void onInit() {
    _changePaginationFilter(1, 15);
    _findUsers();

    super.onInit();
  }

  void _findUsers() async {
    final usersData = await _userRepository.findAll(
      _paginationFilter.value,
    );

    if (usersData.isEmpty) {
      _lastPage.value = true;
    }

    ///A classe [RXList] foi encapsulada pelo GetX, então já
    ///foi adicionado uma atualização automática da tela 
    ///quando chamamos o método [add] ou o [addAll]
    _users.addAll(usersData);
    ///Se não fosse esse o caso, teríamos que chamar o 
    ///método [refresh()] para atualizar a tela:
    // refresh();
    ///Só é feito isso automático devido ao fato do 
    ///[RXList] ter sido encapsulado para isso.
  }

  void _changePaginationFilter(int page, int limit) {
    ///Assim conseguimos atualizar a classe que está sendo
    ///observada
    _paginationFilter.update((val) {
      val.page = page;
      val.limit = limit;
    });
  }
}