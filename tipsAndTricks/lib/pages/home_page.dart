import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tipsAndTricks/application/rest_template.dart';
import 'package:tipsAndTricks/models/pessoa_model.dart';

class HomePage extends StatelessWidget {

  ///Isso aqui estaria em um repository, é só um exemplo. A 
  ///partir do momento que temos tags em uma instância que estamos
  ///buscando, na hora de dar um [Get.find], obrigatoriamente
  ///temos que passar qual tag estamos buscando se não dá erro
  ///mostrando que não conseguiu encontrar.
  final restTemplate = Get.find<RestTemplate>(tag: RestTemplate.AUTH_TAG);
  // final restTemplate = Get.find<RestTemplate>();

  // final pessoa = Get.find<PessoaModel>(tag: 'rahman');
  final pessoa = Get.find<PessoaModel>();

   @override
   Widget build(BuildContext context) {
    return Scaffold(
      ///Mesmo após adicionar tanto a instância do
      ///[RestTemplate], quanto a instância do 
      ///[RestTemplate.auth] dentro do bindings do 
      ///[HomePage], será usado apenas a primeira instância
      ///criada, que no caso é do [RestTemplate]. Para
      ///fazer isso, basta criarmos tags para as nossas
      ///instâncias na hora de dar um [Get.lazyPut] ou um
      ///[Get.put],
      appBar: AppBar(
        title: Text(restTemplate.name),
        centerTitle: true,
      ),
      body: Text(pessoa.nome, style: TextStyle(fontSize: 50.0)),
    );
  }
}