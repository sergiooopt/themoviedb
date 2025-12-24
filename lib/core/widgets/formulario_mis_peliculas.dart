import 'package:flutter/material.dart';
import 'package:peliculas/core/app.dart';
import 'package:peliculas/models/mis_peliculas/model_mi_pelicula.dart';
import 'package:peliculas/providers/provider_mis_peliculas.dart';
import 'package:peliculas/services/service_mis_peliculas.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class FormularioMisPeliculas extends StatefulWidget {
  final ModelMiPelicula miPelicula;
  const FormularioMisPeliculas({super.key, required this.miPelicula});

  @override
  State<FormularioMisPeliculas> createState() => _MiFormularioState();
}

class _MiFormularioState extends State<FormularioMisPeliculas> {
  final _formKey = GlobalKey<FormState>();

  List<String> generos = [
    'Ciencia ficción',
    'Drama',
    'Aventura',
    'Terror',
  ];
  late String genero;

  late TextEditingController controllerTitulo;
  late TextEditingController controllerDescripcion;
  late TextEditingController controllerValoracion;
  late bool esVista;

  @override
  void initState() {
    super.initState(); // llamar a clase padre
    controllerTitulo = TextEditingController(text: widget.miPelicula.titulo);
    controllerDescripcion = TextEditingController(
      text: widget.miPelicula.resumen,
    );
    controllerValoracion = TextEditingController(
      text: widget.miPelicula.valoracion.toStringAsFixed(1),
    );
    esVista = widget.miPelicula.vista;
    genero = widget.miPelicula.genero.isNotEmpty
        ? widget.miPelicula.genero
        : 'Ciencia ficción';

    // Obtener generos de base de datos
    /* final provider = Provider.of<ProviderMispeliculas>(context, listen: false);
    generos = provider.generos; */
  }

  @override
  void dispose() {
    // Borrar controladores
    controllerTitulo.dispose();
    controllerDescripcion.dispose();
    controllerValoracion.dispose();

    // Llamar a clase padre
    super.dispose();
  }

  List<Widget> getGeneros() {
    return generos
        .map(
          (e) => RadioListTile<String>(
            title: Text(e),
            value: e,
            groupValue: genero,
            onChanged: (valor) {
              setState(() {
                genero = valor ?? '';
              });
            },
          ),
        )
        .toList();
  }

  InputDecoration getDecorationTextField(Icon icon, String text) {
    return InputDecoration(
      suffixIcon: icon,
      hintText: text,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderMispeliculas>(context, listen: false);

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: TextFormField(
              validator: (valor) {
                if (valor == null || valor.isEmpty) return 'Campo obligatorio';
                if (valor.length < 3) return 'Mínimo de carácteres de 3';
              },
              controller: controllerTitulo,
              decoration: getDecorationTextField(
                const Icon(Icons.movie),
                'Titulo',
              ),
              maxLength: 50,
              maxLines: 1,
              keyboardType: TextInputType.name,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: TextFormField(
              validator: (valor) {
                if (valor == null || valor.isEmpty) return 'Campo obligatorio';
                if (valor.length < 5) return 'Mínimo de carácteres de 5';
              },
              controller: controllerDescripcion,
              decoration: getDecorationTextField(
                const Icon(Icons.text_format),
                'Descrición',
              ),
              maxLength: 500,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: TextFormField(
              validator: (valor) {
                if (valor == null || valor.isEmpty) return 'Campo obligatorio';

                double? numero = double.tryParse(valor);
                if (numero == null) return 'Introduce un número';
                if (numero < 1 || numero > 10)
                  return 'Introduce un número del 1 al 10';
              },
              controller: controllerValoracion,
              decoration: getDecorationTextField(
                const Icon(Icons.tag),
                'Valoración',
              ),
              maxLength: 5,
              maxLines: 1,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: SwitchListTile(
              title: const Text('Viste la pelicula?'),
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1),
                borderRadius: BorderRadiusGeometry.circular(10),
              ),
              value: esVista,
              onChanged: (valor) {
                setState(() {
                  esVista = valor;
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Container(
              decoration: BoxDecoration(
                border: BoxBorder.all(width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(children: getGeneros()),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Añadir pelicula a base de datos
                ModelMiPelicula miPelicula = ModelMiPelicula(
                  titulo: controllerTitulo.text,
                  resumen: controllerDescripcion.text,
                  vista: esVista,
                  valoracion: double.parse(controllerValoracion.text),
                  genero: genero,
                );

                provider.addPeliculaLocal(miPelicula);

                // Mostrar mensaje de confirmación
                App.scaffoldMessenger.currentState?.showSnackBar(
                  const SnackBar(content: Text('Pelicula registrada :)')),
                );

                Navigator.pop(context);
              }
            },
            child: const Text('ALTA PELICULA'),
          ),
        ],
      ),
    );
  }
}
