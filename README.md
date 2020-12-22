
# mine_sweeper_rb
Buscaminas en Ruby/Sinatra

Ejecutar:

    $ bundle install

Para ejecutar Tests con bundler:

    $ bundle exec rspec

Para iniciar servidor:

    $ bundle exec rackup

Luego ingresar a http://localhost:9292

Para ver en los campos "problem" y "solution", un buscaminas con el mapa y su solución

Se generará la tabla de buscaminas con dimensión aleatoria entre 3 y 45, o 3 y MINE_MAX_SIZE
Ej:

    $ MINE_MAX_SIZE=20 bundle exec rackup

https://mine-sweeper-jpgarritano.herokuapp.com/solver



