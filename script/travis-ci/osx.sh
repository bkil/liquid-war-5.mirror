#!/bin/sh -e

build_allegro() {
  local OPWD=`pwd`
#  git clone -b 4.4 git@github.com:liballeg/allegro5.git
#  cd allegro5

  wget http://download.gna.org/allegro/allegro/4.4.2/allegro-4.4.2.7z
  7z x *.7z
  cd allegro
  cmake .
# -DMACOSX_DEPLOYMENT_TARGET=10.2
# -DCMAKE_OSX_DEPLOYMENT_TARGET=10.2
# -DCMAKE_OSX_TARGET=10.2

  local ALLEGRO="$HOME/install/liballegro"
  make -keep-going V=1 install DESTDIR=$ALLEGRO
  export PATH=$PATH:"$ALLEGRO"/usr/local/bin
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:"$ALLEGRO"/usr/local/lib
  cd $OPWD
}

build_osx() {
  build_allegro

  cd liquidwar
  autoconf

  local PREFIX="$HOME/install/liquid-war-5"

  ./configure --prefix="$PREFIX"
  make
  make install
  make dist
}

build_osx "$@"

