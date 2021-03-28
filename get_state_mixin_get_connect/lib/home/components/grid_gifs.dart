import 'package:flutter/material.dart';
import 'package:get_state_mixin_get_connect/models/giphy_model.dart';
import 'package:transparent_image/transparent_image.dart';

class GridGifs extends StatelessWidget {
  final List<GiphyModel> gifs;

  GridGifs({@required this.gifs});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      ///2 imagens por linha
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: gifs.length,
      itemBuilder: (_, index) {
        final gif = gifs[index];

        ///Mostra a imagem em forma de loading, em 
        ///forma de fade. O [memoryNetwork] serve para
        ///trazer uma imagem transparente e depois vai
        ///mostrar a imagem. Porém não há uma imagem
        ///transparente dentro do loader, por isso 
        ///usaremos um package que irá trazer isso
        ///para nósm que é o package [transparent_image]
        return FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: gif.url,
        );
      }
    );
  }
}