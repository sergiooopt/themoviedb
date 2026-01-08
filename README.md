## TheMovieDB
> Aplicación en Dart (Flutter) para consultar peliculas, tiene acceso a la api de [TheMovieDB](https://www.themoviedb.org/?language=es-ES).

### Obtener apk de la aplicación (Linux)
Clona el repositorio
~~~Bash
git clone https://github.com/sergiooopt/themoviedb.git
~~~

~~~Bash
cd themoviedb
~~~

Genera una clave (si aun no tienes una)
~~~Bash
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA \
        -keysize 2048 -validity 10000 -alias upload
~~~

Crea tu archivo key.properties
~~~Bash
nano android/key.properties
~~~

Contiene la siguiente información:
> storePassword=<contraseña keytool>
> keyPassword=<contraseña keytool>
> keyAlias=upload
> storeFile=<ubicación de clave generada>

Exporta las apks con:
~~~Bash
flutter build apk --split-per-abi
~~~

> Con el comando anterior se deberían haber generado las apks en la ruta `build/app/outputs/apk/release/`




