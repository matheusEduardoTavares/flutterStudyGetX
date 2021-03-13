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

  ///Sempre é interessante criar getters para proteger
  ///os observáveis
  int get limit => _paginationFilter.value.limit;

  void changeTotalPerPage(int limitValue) {
    _users.clear();
    _changePaginationFilter(1, limitValue);
  }

  @override 
  void onInit() {
    ///Não é interessante chamarmos aqui na mão a 
    ///função para buscar os usuários. Isso pode ser
    ///melhorado um pouco. O GetX tem as reactions que
    ///são observadores, listeners para buscar as
    ///coisas. Nós os chamamos de workers. Temos vários
    ///workers muito interessantes, como o [debounce], o
    ///[timeout]. E temos um que chama [ever]. Esse [ever]
    ///irá ficar escutando para sempre que acontecer uma
    ///alteração dentro do listener, será chamado algum 
    ///método, executar alguma coisa. Temos também o 
    ///[once], que irá executar uma única vez. Temos ainda
    ///outros.
    // _findUsers();

    ///Agora sempre que nosso pagination for alterado,
    ///a função de buscar os usuários será chamada.
    ever(_paginationFilter, (_) => _findUsers());

    ///De início ao chamar o [_changePaginationFilter]
    ///agora, automaticamente o ever captura que o 
    ///[_paginationFilter] é alterado e então já chama o
    ///[_findUsers], fazendo que já tenhamos de início 
    ///os usuários da página 1
    _changePaginationFilter(1, 15);

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