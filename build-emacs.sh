#!/usr/bin/env bash

## Author: FiveArms
## Original Author: Abidán Brito
## This script builds GNU Emacs 30 with support for native elisp compilation,
## tree-sitter, and mailutils.

# Exit on error and print out commands before executing them.
set -euxo pipefail

# Let's set the number of jobs to something reasonable; keep 2 cores
# free to avoid choking the computer during compilation.
JOBS=$(nproc --ignore=2)

# Clone repo locally and get into it.
git clone --depth 1 --branch emacs-30 git://git.savannah.gnu.org/emacs.git
pushd emacs

# Get essential dependencies.
sudo apt install -y build-essential \
    texinfo \
    libgnutls28-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff5-dev \
    libgif-dev \
    libxpm-dev \
    libncurses-dev \
    libgtk-3-dev \
    libtree-sitter-dev \
    libmagick++-dev \
    #libwebkit2gtk-4.1-dev

# Get dependencies for gcc-10 and the build process.
sudo apt update -y
sudo apt install -y gcc-11 \
    g++-11 \
    libgccjit0 \
    libgccjit-11-dev \
    autoconf \

# Get dependencies for fast JSON.
sudo apt install -y libjansson4 libjansson-dev

# Get GNU Mailutils (protocol-independent mail framework).
sudo apt install -y mailutils

# Enable source packages and get dependencies for whatever
# Emacs version Ubuntu supports by default.
#
# Taken from here:
# https://www.masteringemacs.org/article/speed-up-emacs-libjansson-native-elisp-compilation
#sudo sed -i 's/# deb-src/deb-src/' /etc/apt/sources.list \
#    && apt update \
#    && apt build-dep -y emacs

# Install dependencies as reccomended by hpptf://www.github.com/hubisan/emacs-wsl
sudo apt install -y autoconf automake bsd-mailx build-essential \
  dbus-x11 debhelper dpkg-dev emacs-bin-common emacs-common gawk \
  git gvfs ibus-gtk3 language-pack-en-base libacl1-dev libasound2 \
  libasound2-dev libaspell15 libasyncns0 libatk1.0-0 libatk-bridge2.0-0 \
  libatspi2.0-0 libbrotli1 libc6 libc6 libc6-dev libc6-dev libcairo2 \
  libcairo2-dev libcairo-gobject2 libcanberra0 libcanberra-gtk3-0 \
  libcanberra-gtk3-module libdatrie1 libdb5.3 libdbus-1-3 libdbus-1-dev \
  libdrm2 libegl1 libenchant-2-dev libepoxy0 libflac8 libfontconfig1 \
  libfontconfig1-dev libfreetype6 libfreetype6-dev libgbm1 \
  libgccjit-10-dev libgcc-s1 libgdk-pixbuf2.0-0 libgif7 libgif-dev \
  libgl1 libglib2.0-0 libglvnd0 libglx0 libgmp10 libgnutls28-dev \
  libgnutls30 libgpm2 libgpm2 libgpm-dev libgraphite2-3 \
  libgstreamer1.0-0 libgstreamer-gl1.0-0 libgstreamer-plugins-base1.0-0 \
  libgtk-3-0 libgtk-3-dev libgudev-1.0-0 libharfbuzz0b libharfbuzz0b \
  libharfbuzz-icu0 libhyphen0 libibus-1.0-5 libice6 libicu70 libisl23 \
  libjansson4 libjansson-dev libjbig0 libjpeg8-dev libjpeg-dev \
  libjpeg-turbo8 liblcms2-2 liblcms2-dev liblockfile1 liblockfile-dev \
  libltdl7 libm17n-0 libm17n-dev libmpc3 libmpfr6 libncurses5-dev \
  libnotify4 libnss-mdns libnss-myhostname libnss-sss libnss-systemd \
  libogg0 liborc-0.4-0 liboss4-salsa2 libotf1 libotf-dev libpango-1.0-0 \
  libpangocairo-1.0-0 libpangoft2-1.0-0 libpixman-1-0 libpng16-16 \
  libpng-dev libpulse0 librsvg2-2 librsvg2-dev libsasl2-2 libsecret-1-0 \
  libselinux1-dev libsm6 libsndfile1 libsoup2.4-1 libsqlite3-0 \
  libsqlite3-dev libssl3 libsss-nss-idmap0 libstdc++6 libsystemd-dev \
  libtdb1 libthai0 libtiff5 libtiff-dev libtinfo-dev libtree-sitter0 \
  libtree-sitter-dev libvorbis0a libvorbisenc2 libvorbisfile3 \
  libwayland-client0 libwayland-cursor0 libwayland-egl1 \
  libwayland-server0 libwebkit2gtk-4.0-dev libwebp7 libwebpdemux2 \
  libwebp-dev libwoff1 libx11-6 libx11-xcb1 libxau6 libxcb1 \
  libxcb-render0 libxcb-shm0 libxcomposite1 libxcursor1 libxdamage1 \
  libxdmcp6 libxext6 libxfixes3 libxfixes-dev libxi6 libxi-dev \
  libxinerama1 libxkbcommon0 libxml2 libxml2-dev libxpm4 libxpm-dev \
  libxrandr2 libxrender1 libxrender-dev libxslt1.1 libxt-dev libyajl2 \
  mailutils procps quilt sharutils texinfo zlib1g-dev

# Stop debconf from complaining about postfix nonsense.
DEBIAN_FRONTEND=noninteractive

# Needed for compiling libgccjit or we'll get cryptic error messages.
export CC=/usr/bin/gcc-11 CXX=/usr/bin/g++-11

# Configure and run.
# NOTE(abi): binaries should go to /usr/local/bin by default.
#
# Options:
#    --with-native-compilation  ->  use the libgccjit native compiler
#    --with-pgtk                ->  better font rendering
#    --with-x-toolkit=gtk3      ->  widgets toolkit
#    --with-tree-sitter         ->  syntax parsing
#    --with-wide-int            ->  larger file size limit
#    --with-json                ->  fast JSON
#    --with-gnutls              ->  TLS/SSL
#    --with-mailutils           ->  e-mail
#    --without-pop              ->  no pop3 (insecure channels)
#    --with-cairo               ->  vector graphics backend
#    --with-imagemagick         ->  raster images backend

./autogen.sh \
    && ./configure \
    --with-native-compilation \
    --with-pgtk \
    --with-tree-sitter \
    --with-wide-int \
    --with-json \
    --with-modules \
    --without-dbus \
    --with-gnutls \
    --with-mailutils \
    --without-pop \
    --with-cairo \
    --with-imagemagick \
        
    # Other interesting compilation options:
    #
    #--prefix=""                    # output binaries location
    #--with-x-toolkit=lucid         # supposedly more stable
    #--with-xwidgets

    # Compiler flags:
    # -O2                   ->  Turn on a bunch of optimization flags. There's also -O3, but it increases
    #                           the instruction cache footprint, which may end up reducing performance.
    # -pipe                 ->  Reduce temporary files to the minimum.
    # -mtune=native         ->  Optimize code for the local machine (under ISA constraints).
    # -march=native         ->  Enable all instruction subsets supported by the local machine.
    # -fomit-frame-pointer  ->  Small functions don't need a frame pointer (optimization).
    #
    # https://lemire.me/blog/2018/07/25/it-is-more-complicated-than-i-thought-mtune-march-in-gcc/
    CFLAGS="-O2 -pipe -mtune=native -march=native -fomit-frame-pointer"

# Build.
# NOTE(abi): NATIVE_FULL_AOT=1 ensures native compilation ahead-of-time for all
#            elisp files included in the distribution.
make -j"${JOBS}" NATIVE_FULL_AOT=1 \
    && make install

# Return to the original path.
popd
