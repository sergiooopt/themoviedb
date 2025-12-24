
import 'package:flutter/material.dart';
import 'package:peliculas/core/app.dart';
import 'package:peliculas/providers/provider_mis_peliculas.dart';
import 'package:peliculas/providers/provider_themoviedb.dart';
import 'package:provider/provider.dart';

class Providers extends StatelessWidget {
const Providers({ super.key });

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => ProviderThemoviedb()),
        ChangeNotifierProvider(create: ( _ ) => ProviderMispeliculas())
      ],
      child: const App(),
      
    );
  }
}