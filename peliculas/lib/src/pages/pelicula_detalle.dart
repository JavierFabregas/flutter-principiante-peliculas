import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class PeliculaDetalle extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            _crearAppbar(pelicula,context),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox( height: 10),
                  _posterTitulo(pelicula,context),
                  _descripcion(pelicula),
                  _crearReparto(pelicula),
                ]
                )
            )
          ],
        ),
      ),
    );
  }


  Widget _crearAppbar(Pelicula pelicula, BuildContext context){
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(fontSize: 20, color: Colors.white, shadows: [Shadow(blurRadius: 3,color: Colors.black,offset: Offset(1.5, 1.5))]),
          overflow:  TextOverflow.ellipsis,
          ),
          background: FadeInImage(
            placeholder: AssetImage('assets/img/loading.gif'),
            image: NetworkImage(pelicula.getBackgroundImg()),
            fadeInDuration: Duration(seconds: 1),
            fit: BoxFit.cover,
          ),
        

      ),
    );
  }

  Widget _posterTitulo(Pelicula pelicula, BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          Hero(
            tag: pelicula.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                image: NetworkImage(pelicula.getPosterImg()),
                height: 150,
              ),
            ),
          ),
          SizedBox(width: 20,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(pelicula.title, style: Theme.of(context).textTheme.title,overflow:  TextOverflow.ellipsis,),
                Text(pelicula.originalTitle,  style: Theme.of(context).textTheme.subhead,overflow:  TextOverflow.ellipsis),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(pelicula.voteAverage.toString(), style: Theme.of(context).textTheme.subhead,),
                  ],
                )
              ],
            )
            )
        ],
      ),
    );
  }

  Widget _descripcion(Pelicula pelicula){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Text(
        pelicula.overview, 
        textAlign: TextAlign.justify,
        ),
    );
  }

  Widget _crearReparto(Pelicula pelicula){
    final peliProvider = new PeliculasProvider();

    return FutureBuilder(
      future: peliProvider.getCast(pelicula.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot){
        if(snapshot.hasData){
          return _crearActoresPageView(snapshot.data);
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
      );

  }

  Widget _crearActoresPageView(List<Actor> actores){
      return SizedBox(
        height: 200,
        child: PageView.builder(
          pageSnapping: false,
          itemCount: actores.length,
          controller: PageController(
            viewportFraction: 0.3,
            initialPage: 1
          ), 
          itemBuilder: (context, i){
            return _tarjetaActor(actores[i]);
          },
        ),
      );
  }

  Widget _tarjetaActor(Actor actor){
      return Container(
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'), 
                image: NetworkImage(actor.getActorImg()),
                height: 150,
                fit: BoxFit.cover,
              )
            ),
            Text(actor.name, overflow: TextOverflow.ellipsis)
            
          ],
        ),
      ); 
  }
}