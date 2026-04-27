# shellcheck disable=SC2034
# shellcheck disable=SC2148

pkgname="betterbird-bin"
# gives="betterbird"
_appname="betterbird"
pkgver="140.10.0esr"
_build=bb21
pkgdesc="Fine-tuned version of Mozilla Thunderbird, Thunderbird on steroids, if you will"
maintainer=("tranquil <tranquiltr0@proton.me>")
arch=("x86_64")
url='https://www.betterbird.eu/index.html'
repology=("project: betterbird")
depends=("libdbus-glib-1-2" "hunspell")

source=(
    "https://www.betterbird.eu/downloads/LinuxArchive/${_appname}-${pkgver}-${_build}.en-US.linux-x86_64.tar.xz"
    "eu.betterbird.Betterbird.desktop"
)

sha256sums=(
    "521e79c569ff723a08bad5f6c5d33f8d45b0f5cd80b3c3f87de7cae4a42d6d0a"
    "bce809385dc48951ca6309776ed8fe5213ebbce301a790349172a799d8987151"
)

package() {

    # Create directories
    # shellcheck disable=SC2154
    install -d "${pkgdir}/opt"
    install -d "${pkgdir}/usr/bin"
    install -d "${pkgdir}/usr/share/applications"
    
    # Install main files
    # shellcheck disable=SC2154
    cp -r "${srcdir}/${_appname}/" "${pkgdir}/opt/${_appname}"

    install -m644 "${srcdir}/eu.${_appname}.Betterbird.desktop" \
        "${pkgdir}/usr/share/applications/eu.${_appname}.Betterbird.desktop"
    
    # Create symlinks
    ln -s "/opt/${_appname}/betterbird" "${pkgdir}/usr/bin/${_appname}"
    
    # Install icons
    for i in 16 22 24 32 48 64 128 256; do
        install -d "${pkgdir}/usr/share/icons/hicolor/${i}x${i}/apps/"
        ln -s "/opt/${_appname}/chrome/icons/default/default${i}.png" \
        "${pkgdir}/usr/share/icons/hicolor/${i}x${i}/apps/${_appname}.png"
    done
}

# vim: set filetype=bash tabstop=4 foldmethod=marker expandtab:
