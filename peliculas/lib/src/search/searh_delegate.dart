import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate{

  final peliculas = ['pelicula 1','pelicula 2','pelicula 3','pelicula 4','pelicula 5','pelicula 6','pelicula 7','pelicula 8'];

  final peliculasRecientes = ['pelicula reciente 1','pelicula reciente 2','pelicula reciente 3','pelicula reciente 4','pelicula reciente 5'];

  String seleccion = "";

  final peliculasProvider = new PeliculasProvider();

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
    return Center(
      child: Container(
        width: 100,
        height: 100,
        color: Colors.blueAccent,
        child: Text(seleccion),
      )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias que aparecen cuando se escribe

  if (query.isEmpty) return Container();

  return FutureBuilder(
    future: peliculasProvider.buscarPelicula(query),
    builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot){

      if (snapshot.hasData) {
        final peliculas = snapshot.data;
        return ListView(
          children: peliculas.map((pelicula){
            return ListTile(
              leading: FadeInImage(
                 placeholder: AssetImage('assets/img/no-image.jpg'),
                 image: NetworkImage(pelicula.getPosterImg()),
                 width: 50,
                 fit: BoxFit.contain,
                 ),
                 title: Text(pelicula.title),
                 subtitle: Text(pelicula.originalTitle),
                 onTap: (){
                   pelicula.uniqueID = "";
                   close(context, null);
                   Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                 },
            );
          }).toList()
        );

      }else{
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    }
  );


    /*
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
            seleccion = listaSugerida[i];
            showResults(context);
          },
        );
      }
      );*/
  }

}