import 'package:flutter/material.dart';
import 'package:peliculas/screens/home/home_cardswiper.dart';
import 'package:peliculas/screens/home/home_now_playing.dart';
import 'package:peliculas/screens/home/home_popular.dart';
import 'package:peliculas/screens/home/home_upcoming.dart';
import 'package:peliculas/screens/themoviedb/movie_search_delegate.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<ProvidersPeliculas>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: MovieSearchDelegate());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            HomeCardswiper(),
            HomeNowPlaying(),
            HomePopular(),
            HomeUpcoming(),
          ],
        ),
      ),
    );
  }
}
