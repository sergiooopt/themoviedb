import 'package:flutter/material.dart';
import 'package:peliculas/models/themoviedb/model_movie.dart';
import 'package:peliculas/providers/provider_themoviedb.dart';
import 'package:peliculas/core/routes_peliculas.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar pelicula';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.close), // Icons.highlight_remove
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  Widget _listaBusqueda(BuildContext context, List<ModelMovie> peliculas) {
    final Size size = MediaQuery.of(context).size;

    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: FadeInImage(
            placeholder: const AssetImage('assets/cardswiper/loading.gif'),
            image: peliculas[index].posterPath.isNotEmpty
                ? NetworkImage(peliculas[index].path)
                : const AssetImage('assets/cardswiper/no-image.jpg'),
            fit: BoxFit.cover,
            width: size.width * 0.2,            
          ),
          title: Text(peliculas[index].title),
          subtitle: Text(peliculas[index].originalTitle),
          onTap: () => Navigator.of(
            context,
          ).pushNamed(RoutesPeliculas.detail, arguments: peliculas[index]),
        );
      },
      itemCount: peliculas.length,
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(height: 5, thickness: 1, color: Colors.grey),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final provider = Provider.of<ProviderThemoviedb>(context, listen: false);

    return FutureBuilder(
      future: provider.getPeliculasPorNombre(texto: query),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Hubo un error :( --> ${snapshot.error}'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        List<ModelMovie> movies = snapshot.data ?? [];
        return _listaBusqueda(context, movies);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
