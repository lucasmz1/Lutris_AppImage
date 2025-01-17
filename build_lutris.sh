#!/bin/bash
set -e
set -x
sudo apt install -y wget binutils coreutils desktop-file-utils libfuse2
wget -c -q "https://github.com/AppImageCrafters/appimage-builder/releases/download/v1.1.0/appimage-builder-1.1.0-x86_64.AppImage" -O appimage-builder ; chmod +x appimage-builder
./appimage-builder --recipe lutris.yml --skip-appimage --skip-tests
cp -f sitecustomize.py ./AppDir/etc/python3.*/
cp -f loaders.cache ./AppDir/usr/lib/x86_64-linux-gnu/gdk-pixbuf-2.0/2.10.0/
cp -f net.lutris.Lutris.desktop ./AppDir/
cp -f lutris.png ./AppDir/
wget -c -q "https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-x86_64.AppImage" -O appimagetool ; chmod +x appimagetool
ARCH=x86_64 ./appimagetool -n ./AppDir/
