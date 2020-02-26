import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate{

  final peliculas = ['pelicula 1','pelicula 2','pelicula 3','pelicula 4','pelicula 5','pelicula 6','pelicula 7','pelicula 8'];

  final peliculasRecientes = ['pelicula reciente 1','pelicula reciente 2','pelicula reciente 3','pelicula reciente 4','pelicula reciente 5'];


  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones de nuestro AppBar (cancelar, borrar....)
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: (){
        print('click en clear!!!!');
        query = '';
      }),

    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del Appbar
    return  IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow, progress: transitionAnimation
        ), 
      onPressed: (){
        print('leading pulsado!!!!');
        close(context , null);
      }
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    //Crea los resultados que vamos a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias que aparecen cuando se escribe
    
    final listaSugerida = (query.isEmpty) 
                            ? peliculasRecientes 
                            : peliculas.where(
                              (p) => p.toLowerCase().startsWith(query.toLowerCase())
                            ).toList();
    
    return ListView.builder(
      itemCount: listaSugerida.length,
      itemBuilder: (context , i){
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listaSugerida[i]),
          onTap: (){
            //print(listaSugerida[i]);
          },
        );
      }
      );
  }

}