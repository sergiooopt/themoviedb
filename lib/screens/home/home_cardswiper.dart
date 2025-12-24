import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/core/routes_peliculas.dart';
import 'package:peliculas/models/themoviedb/model_movie.dart';
import 'package:peliculas/providers/provider_themoviedb.dart';
import 'package:provider/provider.dart';

class HomeCardswiper extends StatelessWidget {
  const HomeCardswiper({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final providerTheMovieDB = Provider.of<ProviderThemoviedb>(
      context,
      listen: false,
    );

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.5,
      child: FutureBuilder(
        future: providerTheMovieDB.getTopRatedMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Hubo un error :('));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<ModelMovie> movies = snapshot.data ?? [];
          return _Swiper(movies: movies);
        },
      ),
    );
  }
}

class _Swiper extends StatelessWidget {
  final List<ModelMovie> movies;

  const _Swiper({required this.movies});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () => Navigator.pushNamed(context, RoutesPeliculas.detail, arguments: movies[index]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/cardswiper/loading.gif'),
              image: movies[index].posterPath.isNotEmpty
                  ? NetworkImage(movies[index].path)
                  : const AssetImage('assets/cardswiper/no-image.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      itemCount: movies.length,
      itemWidth: size.width * 0.6,
      itemHeight: size.height * 0.4,
      layout: SwiperLayout.STACK,
    );
  }
}
