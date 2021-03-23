#!/bin/bash

# Clean old sources
rm -rf sources/*
mkdir -p sources/materia-theme

# Upstream sync
mkdir -p upstream
cd upstream || exit 1

if [ -d materia-theme ]; then
  rm -rf materia-theme
fi

git clone https://github.com/nana-4/materia-theme.git

# Install to sources
cd materia-theme || exit 1
./install.sh --dest ../../sources/materia-theme

# Modify sources
cd ../../sources || exit 1
sed -i 's/font-family: "M+ 1c", Roboto, Cantarell, Sans-Serif;/font-family: Noto Sans, Sans-Serif;/g' materia-theme/Materia*/gnome-shell/gnome-shell.css
sed -i 's/background-color: rgba(0, 0, 0, 0.6);/background-color: rgba(40, 40, 40, 0.6);/g' materia-theme/Materia*/gnome-shell/gnome-shell.css
find . -type f -exec sed -i 's/#121212/#232323/g' {} \;

# Compile gresources
for themedir in materia-theme/Materia*/gnome-shell; do
  cd "${themedir}" || exit 1
  glib-compile-resources gnome-shell-theme.gresource.xml
  cd ../../../ || exit 1
done

# Create source tarball
mkdir -p ../rpmbuild/
rm -rf ../rpmbuild/*.*
tar cfz materia-theme.tar.gz materia-theme
mv materia-theme.tar.gz ../rpmbuild/

# Back to buildroot
cd ../ || exit 1
