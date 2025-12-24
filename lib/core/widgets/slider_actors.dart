import 'package:flutter/material.dart';
import 'package:peliculas/models/themoviedb/model_actor.dart';

class SliderActors extends StatelessWidget {
  final List<ModelActor> actores;
  const SliderActors({super.key, required this.actores});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, indice) => _Actor(actor: actores[indice]),
        itemCount: actores.length,
      ),
    );
  }
}

class _Actor extends StatelessWidget {
  final ModelActor actor;
  const _Actor({required this.actor});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                width: size.width * 0.2,
                placeholder: const AssetImage('assets/cardswiper/loading.gif'),
                image: actor.profilePath.isNotEmpty
                    ? NetworkImage(actor.path)
                    : const AssetImage('assets/cardswiper/no-image.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              actor.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
