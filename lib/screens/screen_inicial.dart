import 'package:flutter/material.dart';
import 'package:peliculas/core/routes_peliculas.dart';

class ScreenInicial extends StatelessWidget {
  const ScreenInicial({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: Drawer(
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.02),
            ListTile(
              textColor: Colors.indigo,
              iconColor: Colors.indigo,
              trailing: const Icon(Icons.movie),
              title: const Text('TheMovieDB'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(RoutesPeliculas.home);
              },
            ),
            ListTile(
              textColor: Colors.indigo,
              iconColor: Colors.indigo,
              trailing: const Icon(Icons.filter_drama_outlined),
              title: const Text('Mis Películas'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(
                  context,
                ).pushNamed(RoutesPeliculas.misPeliculasLista);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('PELICULAS'),
      ),
      body: Center(child: Image.asset('assets/movie.png')),
    );
  }
}
