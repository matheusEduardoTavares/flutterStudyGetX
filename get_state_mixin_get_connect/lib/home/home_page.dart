import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_state_mixin_get_connect/home/components/grid_gifs.dart';
import 'package:get_state_mixin_get_connect/home/home_page_controller.dart';

///A [GetView] é um StatelessComponent e a 
///principal diferença é que ela já nos dá uma 
///instância de controller. Através do Generics
///passamos o controller que queremos que seja
///recebido automaticamente aqui
class HomePage extends GetView<HomePageController> {
  ///Para fazermos requisições a API do giphy, usaremos
  ///o [GetConnect] que é um concorrente direto do 
  ///[Http] e do [Dio]. Trouxe para dentro do micro-framework
  ///essa funcionalidade para fazer as requisições. Por
  ///debaixo do pano, esse [GetConnect] não usa nem o 
  ///[http] e nem o [Dio] para requisições. Já o [Dio]
  ///usa por debaixo dos panos o [http]. Já o [http] 
  ///usa o dart, e o [GetConnect] é uma outra implementação
  ///em dart também.

  @override
  Widget build(BuildContext context) {
    ///Aqui temos uma instância de controller. Porém,
    ///nesse momento, se tentarmos o acessar ela 
    ///estará nula, pois o get é um microframework,
    ///ou seja, tem várias funcionalidades: controle de
    ///estado, rotas e serviceLocator (gerência de 
    ///dependências). Na hora que vai buscar essa 
    ///instância de PageController, irá ser buscado 
    ///tal instância no ServiceLocator, no seu 
    ///gerenciador de dependências, porém ele não 
    ///irá encontrar essa classe, a adicionando
    ///como nulo. Ao tentar usar o controller, será
    ///dado um erro que não foi encontrado a instância
    ///de controller, e que precisamos chamar ou o 
    ///[Get.put] ou o [Get.lazyPut]. Para resolver isso
    ///podemos adicionar o [Get.put] no initState, no
    ///início da nossa classe, ou podemos usar os 
    ///Bindings, que é o ideal. Após adicionar o 
    ///[Binding] no [GetPage] referente ao [HomePage],
    ///esse erro irá parar de aparecer pois iremos 
    ///ter a instância do [HomeController] criada
    // print(controller);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        centerTitle: true,
      ),
      ///Por estarmos usando o [StateMixin], através 
      ///da controller podemos acessar um método chamado
      ///[obx] que retorna o estado que precisamos, e que
      ///podemos passar o widget que queremos mostrar no 
      ///[onError] e no [onLoading]. Caso não passemos o 
      ///[onLoading], automaticamente é feito para nós um
      ///[CircularProgressIndicator], então não precisamos
      ///o adicionar mas podemos customizá-lo caso queiramos
      body: controller.obx(
        (state) => GridGifs(gifs: state),
        onError: (error) => Center(
          child: Text(error),
        ),
        // onLoading: Center(child: Text('Carregando')),
      )
    );
  }
}