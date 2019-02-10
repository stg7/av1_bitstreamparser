#!/bin/bash
# This file is part of av1_parser.
# av1_parser is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# av1_parser is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with av1_parser. If not, see <http://www.gnu.org/licenses/>.

aom() {
    echo "clone aom & build"
    git clone https://aomedia.googlesource.com/aom
    git checkout 3a9e4672be019bcd2478863f8218f560e06bed27
    mkdir -p build_aom
    mkdir -p libaom
    cd build_aom

    cmake ../aom -DCMAKE_INSTALL_PREFIX="$(pwd)/../libaom"
    make -j 10
    make install
    cd ..
}

requirements() {
    echo "install requirements"
    sudo apt-get update -qq

    sudo apt-get -y install autoconf automake build-essential cmake git \
        libass-dev libfreetype6-dev libsdl2-dev libtheora-dev libtool \
        libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev \
        libxcb-xfixes0-dev mercurial pkg-config texinfo wget \
        zlib1g-dev yasm
        # some dependencies are probably not required
}

requirements
aom

PKG_CONFIG_PATH="$(pwd)/libaom/lib/pkgconfig"
export PKG_CONFIG_PATH

cd ffmpeg-4.1


echo "configure ffmpeg"
./configure --pkg-config-flags="--static" \
  --disable-doc \
  --enable-pthreads \
  --enable-debug=2 \
  --disable-nvenc \
  --disable-libx265 \
  --enable-libaom \
  --enable-decoder=libaom_av1 \
  --enable-parser=av1 \
  --enable-demuxer=matroska \
  --extra-ldflags="-L$(pwd)/../libaom/lib" \
  --disable-vaapi \
  --enable-gpl

make -j 12