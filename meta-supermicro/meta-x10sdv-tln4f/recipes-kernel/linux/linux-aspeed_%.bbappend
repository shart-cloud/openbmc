# Ship the out-of-tree board DTS into the aspeed kernel build and register it
# in the per-vendor dtb Makefile. Once the DTS is upstreamed, drop this bbappend.
# Kernel 6.18 keeps ARM aspeed DTS under arch/arm/boot/dts/aspeed/.

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:x10sdv-tln4f = " file://aspeed-bmc-supermicro-x10sdv-tln4f.dts"

do_configure:prepend:x10sdv-tln4f() {
    dtsdir="${S}/arch/arm/boot/dts/aspeed"
    install -m 0644 "${WORKDIR}/aspeed-bmc-supermicro-x10sdv-tln4f.dts" "${dtsdir}/"
    if ! grep -q "x10sdv-tln4f" "${dtsdir}/Makefile"; then
        echo 'dtb-$(CONFIG_ARCH_ASPEED) += aspeed-bmc-supermicro-x10sdv-tln4f.dtb' >> "${dtsdir}/Makefile"
    fi
}
