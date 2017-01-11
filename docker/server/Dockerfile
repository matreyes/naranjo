FROM honeycomb/base

# key tools are highlighted

# get erlang packages
RUN wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && dpkg -i erlang-solutions_1.0_all.deb

# update
RUN apt update

# ELIXIR
RUN apt install -y esl-erlang

# ELIXIR
RUN apt install elixir

# HEX
RUN yes Y | mix local.hex

# PHOENIX
#   also installs these default projects:
#     PLUG: A spec for composeable elixir modules
#     COWBOY: an http server in ERLANG
#     ECTO: A database wrapper in ELIXIR
RUN yes Y | mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez

# inotify: Linux-only filesystem watcher that Phoenix uses for
# live code reloading.
RUN apt install -y inotify-tools

# NODE
#    (for BRUNCH.IO, which PHOENIX installs in order to:
#       - compile source files using plugins
#       - concatenate compiled source files
#       - write result into file
#       - copy assets
       
RUN apt install -y nodejs-legacy npm
# PHOENIX install directions suggest
# that a symbolic link must be created,
# but this wasn't necessary on AUSTIN's machine.
# RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN apt install -y postgresql postgresql-contrib