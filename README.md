## TheMovieDB
> Aplicación en Dart (Flutter) para consultar peliculas, tiene acceso a la api de [TheMovieDB](https://www.themoviedb.org/?language=es-ES).

![Imagen de la página web](https://imgs.search.brave.com/fB9NtYkhv0ws5e0CM103TJAllrUGFLxHFcySdXIbhuw/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9zaXRl/LWltYWdlcy5zaW1p/bGFyY2RuLmNvbS9p/bWFnZT91cmw9dGhl/bW92aWVkYi5vcmcm/dD0xJnM9MSZoPTcz/MDZiODdkNTBlZDRl/MjE2YzA5YjhjYmY4/YTFkOGQxNDM5N2E5/MjYxMjIyYTE1ZmI3/Mjk3ZDBiODMwYjE5/NWU)

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

storePassword=<contraseña keytool>

keyPassword=<contraseña keytool>

keyAlias=upload

storeFile=<ubicación de clave generada>


Exporta las apks con
~~~Bash
flutter build apk --split-per-abi
~~~

> Con el comando anterior se deberían haber generado las apks en la ruta `build/app/outputs/apk/release/`



