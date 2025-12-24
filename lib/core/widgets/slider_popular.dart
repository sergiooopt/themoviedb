import 'package:flutter/material.dart';
import 'package:peliculas/models/themoviedb/model_movie.dart';
import 'package:peliculas/core/routes_peliculas.dart';

class SliderPopular extends StatefulWidget {
  final List<ModelMovie> peliculas;
  final Function cargarSeguintePaxina;

  const SliderPopular({
    super.key,
    required this.peliculas,
    required this.cargarSeguintePaxina,
  });

  @override
  State<SliderPopular> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<SliderPopular> {
  ScrollController scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (!isLoading &&
          scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200) {
        isLoading = true;
        debugPrint('SIGUIENTE PÁGINA');
        widget.cargarSeguintePaxina;
        isLoading = false;
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              'Popular',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: _getLista()),
        ],
      ),
    );
  }

  Widget _getLista() => ListView.builder(
    scrollDirection: Axis.horizontal,
    controller: scrollController,
    itemBuilder: (_, indice) =>
        _MoviePoster(pelicula: widget.peliculas[indice]),
    itemCount: widget.peliculas.length,
  );
}

class _MoviePoster extends StatelessWidget {
  final ModelMovie pelicula;
  const _MoviePoster({required this.pelicula});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 180,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: GestureDetector(
              onTap: () {
                Navigator.of(
                  context,
                ).pushNamed(RoutesPeliculas.detail, arguments: pelicula);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: FadeInImage(
                    placeholder: const AssetImage(
                      'assets/cardswiper/loading.gif',
                    ),
                    image: pelicula.path == ""
                        ? const AssetImage('assets/cardswiper/no-image.jpg')
                        : NetworkImage(pelicula.path),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              pelicula.originalTitle,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
