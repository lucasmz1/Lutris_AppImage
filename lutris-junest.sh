#!/usr/bin/env bash

APP=lutris
BIN="$APP" #CHANGE THIS IF THE NAME OF THE BINARY IS DIFFERENT FROM "$APP" (for example, the binary of "obs-studio" is "obs")
DEPENDENCES=$(echo "cblas glew glfw lib32-dbus lib32-glew lib32-glu lib32-libice lib32-libsm lib32-libxi lib32-libxkbcommon lib32-libxmu lib32-libxt lib32-mangohud lib32-util-linux python-contourpy python-cycler python-dateutil python-fonttools python-kiwisolver python-matplotlib python-numpy python-pyparsing python-six qhull zenity dbus 7zip fontconfig glu dbus-broker dbus-x11 gamescope goverlay mangohud dbus-broker-units dbus-units vulkan-headers vulkan-mesa-implicit-layers vulkan-icd-loader lib32-vulkan-icd-loader vulkan-radeon lib32-vulkan-radeon vulkan-intel lib32-vulkan-intel vulkan-nouveau lib32-vulkan-nouveau vulkan-swrast lib32-vulkan-swrast vulkan-validation-layers lib32-vulkan-validation-layers vulkan-utility-libraries lib32-vulkan-utility-libraries vulkan-mesa-layers lib32-vulkan-mesa-layers lib32-vulkan-icd-loader lib32-mangohud sdl2 util-linux tar gzip coreutils python-charset-normalizer util-linux 7zip freetype2 lib32-freetype2 file gtk-update-icon-cache pciutils harfbuzz xterm adwaita-icon-theme adwaita-icon-theme-legacy lib32-libglvnd lib32-gnutls cabextract curl gdk-pixbuf2 glib2 gnome-desktop gobject-introspection-runtime gtk3 hicolor-icon-theme mesa-utils p7zip pango psmisc python python-cairo python-certifi python-dbus python-distro python-evdev python-gobject python-lxml python-moddb python-pillow python-requests python-urllib3 python-yaml unzip webkit2gtk-4.1 xdg-desktop-portal-impl xorg-xrandr fluidsynth gamemode gvfs innoextract lib32-gamemode lib32-gnutls lib32-mesa-libgl lib32-vkd3d libayatana-appindicator python-pefile python-protobuf umu-launcher vkd3 vulkan-tools xorg-xgamma git meson ninja protobuf python-poetry-core fluidsynth pciutils python-nose vulkan-tools xorg-server-xvfb xterm" | tr ' ' '\n' | sort -u | xargs)
#BASICSTUFF="binutils debugedit gzip"
#COMPILERS="base-devel"

# Set keywords to searchan include in names of directories and files in /usr/bin (BINSAVED), /usr/share (SHARESAVED) and /usr/lib (LIBSAVED)
BINSAVED="sha256sum glewinfo visualinfo fonttools pyftmerge pyftsubset ttx f2py f2py3 qconvex qdelaun qhalf qhull qvoronoi rbox mangoapp 7z 7za 7zr fc-cache fc-cat fc-conflist fc-list fc-match fc-pattern fc-query fc-scan fc-validate goverlay dbus dbus-daemon dbus-launch dbus-monitor dbus-run-session dbus-send dbus-test-tool dbus-update-activation-environment dbus-uuidgen dbus-broker dbus-broker-launch loadericdscan ldconfig gamescope mangohud mangohudctl mangoplot tar lsblk gzip od zenity free hugetop pgrep pidof pidwait pkill pmap ps pwdx slabtop sysctl tload top uptime vmstat w watch taskset vkcube vkcubepp vulkaninfo cabextract curl p7zip unzip eglgears_wayland eglgears_x11 eglinfo eglkms egltri_wayland egltri_x11 es2_info es2gears_wayland es2gears_x11 es2tri glxgears glxinfo peglgears vkgears xeglgears xeglthreads"
SHARESAVED="vulkan"
LIBSAVED="libEGL_mesa libEGL_mesa libGLX_indirect libGLX_mesa libgbm apple_dri armada-drm_dri asahi_dri crocus_dri d3d12_dri d3d12_drv_video etnaviv_dri exynos_dri gm12u320_dri hdlcd_dri hx8357d_dri i915_dri ili9163_dri ili9225_dri ili9341_dri ili9486_dri imx-dcss_dri imx-drm_dri imx-lcdif_dri ingenic-drm_dri iris_dri kgsl_dri kirin_dri kms_swrast_dri komeda_dri libdril_dri lima_dri mali-dp_dri mcde_dri mediatek_dri meson_dri mi0283qt_dri msm_dri mxsfb-drm_dri nouveau_dri nouveau_drv_video panel-mipi-dbi_dri panfrost_dri panthor_dri pl111_dri r300_dri r600_dri r600_drv_video radeonsi_dri radeonsi_drv_video rcar-du_dri repaper_dri rockchip_dri rzg2l-du_dri ssd130x_dri st7586_dri st7735r_dri sti_dri stm_dri sun4i-drm_dri swrast_dri tegra_dri udl_dri v3d_dri vc4_dri virtio_gpu_dri virtio_gpu_drv_video vkms_dri vmwgfx_dri zink_dri zynqmp-dpsub_dri gbm/dri_gbm libadwaita libcblas libglew libglfw libdbus-1 libGLU libICE libSM libXi libxkbcommon libXmu libXt libmangoapp libmangohud libblkid libmount libfdisk libsmartcols libuuid _contourpy.cpython* libqhull_r libqhullcpp lib32-mangohud lib32-util-linux libvklayer 7z 7za 7zr libglu vulkan-icd-loader lib32-vulkan-icd-loader vulkan-swrast lib32-vulkan-swrast vulkan-headers vulkan-mesa-implicit-layers mangohud vulkan-icd-loader vulkan-validation-layers vulkan-utility-libraries vulkan-mesa-layers libvulkan libmangohud lib32-mangohud vulkan-radeon lib32-vulkan-radeon vulkan-intel lib32-vulkan-intel vulkan-nouveau lib32-vulkan-nouveau libsdl2 libgl lib32-libgl vulkan-icd-loader gnutls lib32-gnutls alsa jack pipewire pulse gdk-pixbuf svg HarfBuzz harfbuzz Atk idna girepository zstd Zstd mesa vulkan-nouveau mesa-libgl vulkan-swrast vulkan-asahi vulkan-mesa-layers vulkan-virtio-gpu vulkan-icd-loader gnutls lib32-gnutls libvulkan_asahi libvulkan_gfxstream libvulkan_virtio"

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
	mkdir -p AppDir/.junest/usr/lib/mangohud/lib64
	mkdir -p AppDir/.junest/usr/lib32/mangohud/lib32
	
	cp -r AppDir/.junest/usr/lib/mangohud/lib* AppDir/.junest/usr/lib/mangohud/lib64/ 2>/dev/null || true
	cp -r AppDir/.junest/usr/lib32/mangohud/lib* AppDir/.junest/usr/lib32/mangohud/lib32/ 2>/dev/null || true
	cp -f AppRun ./AppDir/
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

export MY_PATH="$HOME/.local/share/lutris/runtime/winetricks"

export PATH="$MY_PATH:${PATH}"

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
REPO="Lutris_AppImage"
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

ARCH=x86_64 _appimagetool -u "$UPINFO" AppDir "$APPNAME"_"$VERSION"-"$ARCHIMAGE_VERSION"-x86_64.AppImage
