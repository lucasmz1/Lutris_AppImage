#!/usr/bin/env bash

APP=lutris
export ICON="lutris.png"
BIN="$APP" #CHANGE THIS IF THE NAME OF THE BINARY IS DIFFERENT FROM "$APP" (for example, the binary of "obs-studio" is "obs")
DEPENDENCES="7zip freetype2 lib32-freetype2 file gtk-update-icon-cache pciutils xterm adwaita-icon-theme adwaita-icon-theme-legacy lib32-libglvnd lib32-vulkan-icd-loader lib32-gnutls cabextract curl gdk-pixbuf2 glib2 gnome-desktop gobject-introspection-runtime gtk3 hicolor-icon-theme mesa-utils p7zip pango psmisc python python-cairo python-certifi python-dbus python-distro python-evdev python-gobject python-lxml python-moddb python-pillow python-requests python-urllib3 python-yaml unzip webkit2gtk-4.1 xdg-desktop-portal-impl xorg-xrandr fluidsynth gamemode gvfs innoextract lib32-gamemode lib32-gnutls lib32-mesa-libgl lib32-vkd3d lib32-vulkan-icd-loader libayatana-appindicator python-pefile python-protobuf umu-launcher vkd3d vulkan-icd-loader vulkan-tools xorg-xgamma git meson ninja protobuf python-poetry-core fluidsynth pciutils python-nose vulkan-tools xorg-server-xvfb xterm" #SYNTAX: "APP1 APP2 APP3 APP4...", LEAVE BLANK IF NO OTHER DEPENDENCIES ARE NEEDED
#BASICSTUFF="binutils debugedit gzip"
#COMPILERS="base-devel"

# Set keywords to searchan include in names of directories and files in /usr/bin (BINSAVED), /usr/share (SHARESAVED) and /usr/lib (LIBSAVED)
BINSAVED="SAVEBINSPLEASE"
SHARESAVED="SAVESHAREPLEASE"
lib_audio_keywords="alsa jack pipewire pulse"
lib_browser_launcher="gio-launch-desktop libasound.so libatk-bridge libatspi libcloudproviders libdb- libdl.so libedit libepoxy libgtk-3.so.0 libjson-glib libnssutil libpthread.so librt.so libtinysparql libwayland-cursor libX11-xcb.so libxapp-gtk3-module.so libXcursor libXdamage libXi.so libxkbfile.so libXrandr p11 pk"
LIBSAVED="gdk-pixbuf svg $lib_audio_keywords $lib_browser_launcher"

# Set the items you want to manually REMOVE. Complete the path in /etc/, /usr/bin/, /usr/lib/, /usr/lib/python*/ and /usr/share/ respectively.
# The "rm" command will take into account the listed object/path and add an asterisk at the end, completing the path to be removed.
# Some keywords and paths are already set. Remove them if you consider them necessary for the AppImage to function properly.
ETC_REMOVED="makepkg.conf pacman"
BIN_REMOVED="gcc"
LIB_REMOVED="gcc"
PYTHON_REMOVED="__pycache__/"
SHARE_REMOVED="gcc icons/AdwaitaLegacy icons/Adwaita/cursors/ terminfo"

# Set mountpoints, they are ment to be set into the AppRun.
# Default mounted files are /etc/resolv.conf, /etc/hosts, /etc/nsswitch.conf, /etc/passwd, /etc/group, /etc/machine-id, /etc/asound.conf and /etc/localtime
# Default mounted directories are /media, /mnt, /opt, /run/media, /usr/lib/locale, /usr/share/fonts, /usr/share/themes, /var, and Nvidia-related directories
# Do not touch this if you are not sure.
mountpoint_files=""
mountpoint_dirs=""

# Post-installation processes (add whatever you want)
_post_installation_processes() {
	printf "\n◆ User's processes: \n\n"
	echo " - None"
	# Add here your code
}

##########################################################################################################################################################
#	SETUP THE ENVIRONMENT
##########################################################################################################################################################

# Download archimage-builder.sh
if [ ! -f ./archimage-builder.sh ]; then
	ARCHIMAGE_BUILDER="https://raw.githubusercontent.com/ivan-hc/ArchImage/refs/heads/main/core/archimage-builder.sh"
	wget --retry-connrefused --tries=30 "$ARCHIMAGE_BUILDER" -O ./archimage-builder.sh || exit 0
fi

# Create and enter the AppDir
mkdir -p AppDir archlinux && cd archlinux || exit 1

_JUNEST_CMD() {
	./.local/share/junest/bin/junest "$@"
}

# Set archlinux as a temporary $HOME directory
HOME="$(dirname "$(readlink -f "$0")")"

##########################################################################################################################################################
#	DOWNLOAD, INSTALL AND CONFIGURE JUNEST
##########################################################################################################################################################

_enable_archlinuxcn() {	ARCHLINUXCN_ON="1"; }
_enable_chaoticaur() { CHAOTICAUR_ON="1"; }
_enable_multilib() { MULTILIB_ON="1"; }

#_enable_archlinuxcn
#_enable_chaoticaur
_enable_multilib

[ -f ../archimage-builder.sh ] && source ../archimage-builder.sh junest-setup "$@"

##########################################################################################################################################################
#	INSTALL PROGRAMS USING YAY
##########################################################################################################################################################

_JUNEST_CMD -- yay -Syy
#_JUNEST_CMD -- gpg --keyserver keyserver.ubuntu.com --recv-key C01E1CAD5EA2C4F0B8E3571504C367C218ADD4FF # UNCOMMENT IF YOU USE THE AUR

[ -f ../archimage-builder.sh ] && source ../archimage-builder.sh install "$@"

cd ..

##########################################################################################################################################################
#	APPDIR
##########################################################################################################################################################

[ -f ./archimage-builder.sh ] && source ./archimage-builder.sh appdir "$@"

##########################################################################################################################################################
#	APPRUN
##########################################################################################################################################################

rm -f AppDir/AppRun

# Set to "1" if you want to add Nvidia drivers manager in the AppRun
export NVIDIA_ON=1

[ -f ./archimage-builder.sh ] && source ./archimage-builder.sh apprun "$@"

# AppRun footer, here you can add options and change the way the AppImage interacts with its internal structure
cat <<-'HEREDOC' >> AppDir/AppRun

EXEC=$(grep -e '^Exec=.*' "${HERE}"/*.desktop | head -n 1 | cut -d "=" -f 2- | sed -e 's|%.||g')
if ! echo "$EXEC" | grep -q "/usr/bin"; then EXEC="/usr/bin/$EXEC"; fi

_JUNEST_CMD -- $EXEC "$@"

HEREDOC
chmod a+x AppDir/AppRun

##########################################################################################################################################################
#	COMPILE
##########################################################################################################################################################

[ -f ./archimage-builder.sh ] && source ./archimage-builder.sh compile "$@"

##########################################################################################################################################################
#	CREATE THE APPIMAGE
##########################################################################################################################################################

if test -f ./*.AppImage; then rm -Rf ./*archimage*.AppImage; fi

APPNAME=$(cat AppDir/*.desktop | grep '^Name=' | head -1 | cut -c 6- | sed 's/ /-/g')
REPO="$APPNAME-appimage"
TAG="latest"
UPINFO="gh-releases-zsync|$GITHUB_REPOSITORY_OWNER|$REPO|$TAG|*x86_64.AppImage.zsync"

echo "$VERSION" > ./version

_appimagetool() {
	if ! command -v appimagetool 1>/dev/null; then
		if [ ! -f ./appimagetool ]; then
			echo " Downloading appimagetool..." && curl -#Lo appimagetool https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-"$ARCH".AppImage && chmod a+x ./appimagetool || exit 1
		fi
		./appimagetool "$@"
	else
		appimagetool "$@"
	fi
}

ARCH=x86_64 _appimagetool -u "$UPINFO" \
	AppDir "$APPNAME"_"$VERSION"-archimage5.0-x86_64.AppImage
