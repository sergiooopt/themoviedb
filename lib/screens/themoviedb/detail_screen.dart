import 'package:flutter/material.dart';
import 'package:peliculas/core/widgets/slider_actors.dart';
import 'package:peliculas/models/mis_peliculas/model_mi_pelicula.dart';
import 'package:peliculas/models/themoviedb/model_actor.dart';
import 'package:peliculas/models/themoviedb/model_movie.dart';
import 'package:peliculas/providers/provider_themoviedb.dart';
import 'package:peliculas/core/routes_peliculas.dart';
import 'package:peliculas/screens/themoviedb/detail_custom_appbar.dart';
import 'package:peliculas/screens/themoviedb/detail_poster_and_title.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pelicula = ModalRoute.of(context)!.settings.arguments as ModelMovie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          DetailCustomAppbar(pelicula: pelicula),
          SliverList(
            delegate: SliverChildListDelegate([
              DetailPosterAndTitle(pelicula: pelicula),
              _getSinopsis(texto: pelicula.overview),
              _getActores(context, movie: pelicula),
            ]),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add_box_rounded),
        onPressed: () => Navigator.pushNamed(context, RoutesPeliculas.misPeliculasDetalle, arguments: ModelMiPelicula.convertModelMovie(pelicula))
        ),
    );
  }

  Widget _getSinopsis({required String texto}) => Container(
    width: double.infinity,
    margin: const EdgeInsets.all(5),
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Text(texto),
  );

  Widget _getActores(BuildContext context, {required ModelMovie movie}) {
    final providerPelis = Provider.of<ProviderThemoviedb>(
      context,
      listen: false,
    );

    return FutureBuilder(
      future: providerPelis.getActores(id: movie.id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return  Center(child: Text('Hubo un error :( --> ${snapshot.error}'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        List<ModelActor> data = snapshot.data ?? [];
        return SliderActors(actores: data);
      },
    );
  }
}
