import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:peliculas/models/mis_peliculas/model_mi_pelicula.dart';
import 'package:sqflite/sqflite.dart';

class ServiceMisPeliculas {
  // Constantes base de datos
  static const String _nombreBD = 'mispeliculas.db';
  static const int _versionBD = 5;

  // Singleton
  ServiceMisPeliculas._();
  static final ServiceMisPeliculas instance = ServiceMisPeliculas._();

  // Conexión a base de datos
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    final String path = join(await getDatabasesPath(), _nombreBD);
    return openDatabase(
      path,
      version: _versionBD,
      onCreate: createBD,
      onUpgrade: (db, oldVersion, newVersion) async {
        debugPrint("VERSIÓN ANTIGUA $oldVersion --> VERSIÓN NUEVA $newVersion");
        await db.execute('DROP TABLE peliculas');
        await createBD(db, newVersion);
      },
    );
  }

  Future<void> createBD(Database db, int version) async {
    // Tabla peliculas
    await db.execute(''' 
    CREATE TABLE IF NOT EXISTS "peliculas" (
	    "id"	INTEGER UNIQUE,
	    "titulo"	TEXT NOT NULL,
	    "resumen"	TEXT NOT NULL,
	    "vista"	INTEGER NOT NULL,
	    "valoracion"	INTEGER NOT NULL,
	    "genero"	INTEGER NOT NULL,
	    PRIMARY KEY("id" AUTOINCREMENT)
    );''');

    
    // Tabla generos
    await db.execute('''
    CREATE TABLE IF NOT EXISTS "generos" (
    "id" INTEGER UNIQUE,
    "genero" TEXT NOT NULL,
    PRIMARY KEY("id" AUTOINCREMENT)
    );''');

    // Cargar géneros 
    await db.execute('''
    INSERT INTO "generos" (genero) VALUES
    ("Ciencia ficción"),
    ("Drama"),
    ("Aventura"),
    ("Histórica"),
    ("Terror"),
    ("Documental");
    ''');
  }

  Future<List<ModelMiPelicula>> getMisPeliculas() async {
    final Database db = await database;
    final List<Map<String, Object?>> peliculas = await db.query(
      'peliculas',
      orderBy: 'titulo',
    );

    return peliculas.map((e) => ModelMiPelicula.fromMap(e)).toList();
  }

  Future<List<String>> getGeneros() async {
    final Database db = await database;
    final List<Map<String, Object?>> generos = await db.query('generos', orderBy: 'genero');

    return generos.map((e) => '$e').toList();
  }  
}
