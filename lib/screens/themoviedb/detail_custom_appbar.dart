import 'package:flutter/material.dart';
import 'package:peliculas/models/themoviedb/model_movie.dart';

class DetailCustomAppbar extends StatelessWidget {
  final ModelMovie pelicula;
  const DetailCustomAppbar({super.key, required this.pelicula});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      floating: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        title: Container(
          alignment: Alignment.bottomCenter,
          width: double.infinity,
          height: 30,
          color: Colors.black38,
          child: Text(
            pelicula.title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        background: FadeInImage.assetNetwork(
          placeholder: "assets/cardswiper/loading.gif",
          image: pelicula.path,
          width: 200,
          height: 300,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
