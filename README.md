## TheMovieDB

> Aplicación en Dart (Flutter) para consultar peliculas, tiene acceso a la api de [TheMovieDB](https://www.themoviedb.org/?language=es-ES).

### Obtener apk de la aplicación (Linux)
Clona el repositorio
~~~Bash
git clone https://github.com/sergiooopt/themoviedb.git
cd themoviedb
~~~

Genera una clave
~~~Bash
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA \
        -keysize 2048 -validity 10000 -alias upload
~~~

Crea tu archivo key.properties dentro de `android/`
~~~Bash
nano android/key.properties
> storePassword=(contraseña keytool)
> keyPassword=(contraseña keytool)
> keyAlias=upload
> storeFile=(ubicación de clave generada)
~~~

Exporta las apks con:
~~~Bash
flutter build apk --split-per-abi
~~~

> Con el comando anterior se deberían haber generado apks para x86 y arm en la ruta `build/app/outputs/apk/release/`


