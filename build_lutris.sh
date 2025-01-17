#!/bin/bash
sudo apt install -y wget binutils coreutils desktop-file-utils
wget -c -q "https://github.com/AppImageCrafters/appimage-builder/releases/download/v1.1.0/appimage-builder-1.1.0-x86_64.AppImage" -o appimage-builder ; chmod +x appimage-builder
./appimage-builder --recipe lutris.yml --skip-appimage
cp -f sitecustomize.py ./AppDir/etc/python3.*/
cp -f loaders.cache ./AppDir/usr/lib/x86_64-linux-gnu/gdk-pixbuf-2.0/2.10.0/
wget -c -q "https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-x86_64.AppImage" -o appimagetool ; chmod +x appimagetool
./appimagetool -n ./AppDir/
