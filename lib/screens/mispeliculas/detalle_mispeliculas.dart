import 'package:flutter/material.dart';
import 'package:peliculas/core/widgets/formulario_mis_peliculas.dart';
import 'package:peliculas/models/mis_peliculas/model_mi_pelicula.dart';

class DetalleMispeliculas extends StatelessWidget {
  const DetalleMispeliculas({super.key});

  @override
  Widget build(BuildContext context) {
    final ModelMiPelicula miPelicula =
        ModalRoute.of(context)!.settings.arguments as ModelMiPelicula? ??
        ModelMiPelicula.getModelEmpty();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(flex: 4, child: MiCaratula(miPelicula: miPelicula)),
            Expanded(
              flex: 6,
              child: SingleChildScrollView(
                child: FormularioMisPeliculas(miPelicula: miPelicula),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MiCaratula extends StatefulWidget {
  final ModelMiPelicula miPelicula;
  const MiCaratula({super.key, required this.miPelicula});

  @override
  State<MiCaratula> createState() => _MiCaratulaState();
}

class _MiCaratulaState extends State<MiCaratula> {
  Widget _getImaxe() {
    return Container(color: Colors.amber, width: 100, height: 100);
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
          child: _getImaxe(),
        ),
        Positioned(
          top: 5,
          left: 5,
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            iconSize: 40,
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.photo_camera),
            alignment: Alignment.topRight,
            color: Colors.white,
            iconSize: 40,
          ),
        ),
      ],
    ),
  );
}