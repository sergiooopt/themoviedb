import 'package:flutter/material.dart';
import 'package:peliculas/models/mis_peliculas/model_mi_pelicula.dart';
import 'package:peliculas/providers/provider_mis_peliculas.dart';
import 'package:peliculas/core/routes_peliculas.dart';
import 'package:provider/provider.dart';

class ScreenListaPeliculas extends StatelessWidget {
  const ScreenListaPeliculas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis Películas')),
      body: Consumer<ProviderMispeliculas>(
        builder:
            (
              BuildContext context,
              ProviderMispeliculas provider,
              Widget? child,
            ) => _ListaPeliculas(peliculas: provider.peliculasLocales),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        onPressed: () =>
            Navigator.pushNamed(context, RoutesPeliculas.misPeliculasDetalle),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ListaPeliculas extends StatelessWidget {
  final List<ModelMiPelicula> peliculas;

  const _ListaPeliculas({required this.peliculas});

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<ProviderMispeliculas>(context, listen: false);
    // final size = MediaQuery.of(context).size;

    return ListView.builder(
      itemBuilder: (context, index) {
        return Row(
          children: [
            Expanded(
              flex: 4,
              child: ListTile(
                leading: Image.asset(
                  'assets/cardswiper/no-image.jpg',
                ), // hasa implementar imagen => FadeInImage()
                title: Text(peliculas[index].titulo),
                subtitle: Text(
                  peliculas[index].resumen,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () => Navigator.pushNamed(
                  context,
                  RoutesPeliculas.misPeliculasDetalle,
                  arguments: peliculas[index],
                ),
              ),
            ),
            IconButton(
              onPressed: () async =>
                  await _mostrarDialogoEditar(context, peliculas[index]),
              icon: const Icon(Icons.remove_circle_outline),
            ),
          ],
        );
      },
      itemCount: peliculas.length,
    );
  }

  Future _mostrarDialogoEditar(BuildContext context, ModelMiPelicula pelicula) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Estas seguro de eliminar la pelicula?',
                style: TextStyle(fontSize: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      final provider = Provider.of<ProviderMispeliculas>(
                        context,
                        listen: false,
                      );
                      provider.removePeliculaLocal(pelicula.titulo);
                      Navigator.pop(context);
                    },
                    child: const Text('Aceptar'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
