#!/bin/bash

# Local project directory
PROJECT="$(pwd)/"

# Clean old sources
mkdir -p "${PROJECT}sources/"
rm -rf "${PROJECT}sources/*"

# Upstream sync
mkdir -p "${PROJECT}upstream"
cd "${PROJECT}upstream" || exit 1

if [ -d materia-theme ]; then
    rm -rf materia-theme
fi

git clone https://github.com/nana-4/materia-theme.git

# Install
cd materia-theme || exit 1
meson _build -Dprefix="${PROJECT}sources"
meson install -C _build

# Modify sources
cd "${PROJECT}sources" || exit 1
find . -type f -name gnome-shell.css -exec sed -i 's/background-color: rgba(0, 0, 0, 0.6);/background-color: rgba(40, 40, 40, 0.6);/g' {} \;
find . -type f -exec sed -i 's/#121212/#232323/g' {} \;

mv share/themes materia-theme
rm -rf share/

# Create source tarball
mkdir -p "${PROJECT}rpmbuild/"
rm -rf "${PROJECT}rpmbuild/*.*"
tar cfz materia-theme.tar.gz materia-theme
mv materia-theme.tar.gz "${PROJECT}rpmbuild/"

# Back to buildroot
cd "${PROJECT}" || exit 1
