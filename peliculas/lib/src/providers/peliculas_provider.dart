import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PeliculasProvider{
  String _apikey='1865f43a0549ca50d341dd9ab8b29f49';
  String _url = 'api.themoviedb.org';
  String _languaje = 'es-ES';

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async{
    final respuesta = await http.get(url);
    final decodedData = json.decode(respuesta.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return  peliculas.items;
  }

Future<List<Pelicula>> getEnCines() async{

  final url = Uri.https(_url, '/3/movie/now_playing',{
    'api_key': _apikey,
    'languaje': _languaje
  });
  return await _procesarRespuesta(url);
}

Future<List<Pelicula>> getPopulares() async{

  final url = Uri.https(_url, '/3/movie/popular',{
    'api_key': _apikey,
    'languaje': _languaje
  });
  return await _procesarRespuesta(url);

}

}