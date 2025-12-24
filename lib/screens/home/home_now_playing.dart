import 'package:flutter/material.dart';
import 'package:peliculas/core/widgets/slider_now_playing.dart';
import 'package:peliculas/models/themoviedb/model_movie.dart';
import 'package:peliculas/providers/provider_themoviedb.dart';
import 'package:provider/provider.dart';

class HomeNowPlaying extends StatelessWidget {
  const HomeNowPlaying({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final providerTheMovieDB = Provider.of<ProviderThemoviedb>(
      context,
      listen: false,
    );
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.3,
      child: FutureBuilder(
        future: providerTheMovieDB.getNowPlaying(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Hubo un error :( --> ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<ModelMovie> movies = snapshot.data ?? [];
          return Consumer<ProviderThemoviedb>(
            builder: (BuildContext context, ProviderThemoviedb provider, Widget? child) {
              return SliderNowPlaying(
                peliculas: movies,
                cargarSeguintePaxina: provider.getNowPlaying,
              );
            },
          );
        },
      ),
    );
  }
}
