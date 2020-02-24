import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  
  final List<Pelicula> peliculas;

  MovieHorizontal({@required this.peliculas});

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * 0.25,
      child: PageView(
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3
        ),
        children: _listaTarjetas(context),
      ),
    );
  }


  List<Widget> _listaTarjetas(context){

    return peliculas.map((pelicula){
      return Container(
        margin: EdgeInsets.only(right: 10),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'), 
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: 160,
                ),
            ),
            SizedBox(height: 5,),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      );
    }).toList();

  }
}