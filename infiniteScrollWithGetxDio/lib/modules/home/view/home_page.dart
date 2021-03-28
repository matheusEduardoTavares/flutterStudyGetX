import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infiniteScrollWithGetxDio/modules/home/controller/home_controller.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

///Além de todos esses ganhos, o GetX possui muitos 
///outros recursos como por exemplo a boa organização
///da gerência de estado, em que há vários métodos de
///ciclo de vida como o [onClosed]; caso precisemos 
///trabalhar com streams temos suporte também; temos
///o [onReady] para quando a página já está pronta;
///temos a parte de dependências e muitas outras coisas

///Podemos extender o [GetView<HomeController>] aqui para
///pegar o controller automaticamente sem ter que passar
///por parâmetro. O problema de fazer isso, é que se quisermos
///fazer um teste de UI por exemplo, com o [GetView] teremos
///muito mais trabalho para fazer isso. Então por boa
///prática, deixamos ele como [StatelessWidget] e o
///recebemos via construtor.
class HomePage extends StatelessWidget {
  ///É interessante recebermos todas as dependências dentro
  ///do construtor, pois assim a nossa classe fica testável,
  ///é fácil de trabalhar com mocks
  HomePage(this._controller, {Key key}) : super(key: key);

  final HomeController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Infinite Scroll'),
        actions: [
          PopupMenuButton(
            initialValue: _controller.limit,
            icon: Icon(Icons.more_vert),
            onSelected: (value) => _controller.changeTotalPerPage(value),
            itemBuilder: (ctx) => [
              CheckedPopupMenuItem(
                value: 15,
                child: Text('15 por página'),
                checked: _controller.limit == 15,
              ),
              CheckedPopupMenuItem(
                value: 20,
                child: Text('20 por página'),
                checked: _controller.limit == 20,
              ),
              CheckedPopupMenuItem(
                value: 50,
                child: Text('50 por página'),
                checked: _controller.limit == 50,
              ),
            ]
          )
        ],
      ),
      ///Por fim só é preciso agora usar um widget que ao
      ///atributo observável ser alterado, altere a tela
      ///também. Para isso podemos usar um [GetBuilder] que não
      ///utiliza reatividade e é mais voltado para [Provider],
      ///ou [GetX] que é um widget que tem algumas outras
      ///vantagens, como quando queremos inicializar uma classe,
      ///uma controller ou algo assim; e temos também o [Obx].
      ///Usaremos uma lib chamada [lazy_load_scrollview] para
      ///poder fazer um wrapper do [ListView.builder] de 
      ///forma que fica fácil controlar quando chegou no 
      ///fim das opções, para que quando isso ocorrer, 
      ///possamos mudar de página.
      body: Obx(() => LazyLoadScrollView(
        onEndOfPage: () => _controller.nextPage(),
        ///Ao chegar na última página não queremos 
        ///mais ficar atualizando a página, pois não
        ///há mais dados para buscar, então 
        ///trabalhamos com o [isLoading] do [LazyLoadScrollView]
        isLoading: _controller.lastPage,
        child: ListView.builder(
          
          itemCount: _controller.users.length,
          itemBuilder: (ctx, index) {
            final user = _controller.users[index];

            return ListTile(
              leading: Text(user.id),
              title: Text(user.name),
              subtitle: Text(user.username),
            );
          }),
      )),
    );
  }
}
