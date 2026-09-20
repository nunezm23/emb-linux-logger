SUMMARY = "ADS1263 data logger and test application"
DESCRIPTION = "User-space ADS1263 acquisition and data logging application for STM32MP1"
LICENSE = "CLOSED"

DEPENDS = "libgpiod"

inherit externalsrc pkgconfig

EXTERNALSRC = "${TOPDIR}/../programs/IdS_project"
EXTERNALSRC_BUILD = "${WORKDIR}/build"

do_configure[noexec] = "1"

do_compile() {
    oe_runmake -C "${S}" \
        BUILD_DIR="${B}" \
        CC="${CC}" \
        PKG_CONFIG="${PKG_CONFIG}"
}

do_install() {
    install -d "${D}${bindir}"
    install -m 0755 "${B}/ads1263_app" "${D}${bindir}/ads1263_app"
}
