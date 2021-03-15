import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_interface/application/rest_template.dart';
import 'package:getx_interface/models/pessoa_model.dart';
import 'package:getx_interface/repository/i_login_repository.dart';

class HomePage extends StatelessWidget {
  final restTemplate = Get.find<RestTemplate>(tag: RestTemplate.AUTH_TAG);
  final pessoa = Get.find<PessoaModel>();
  final ILoginRepository repository = Get.find<ILoginRepository>();

   @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restTemplate.name),
        centerTitle: true,
      ),
      body: Text(pessoa.nome, style: TextStyle(fontSize: 50.0)),
    );
  }
}