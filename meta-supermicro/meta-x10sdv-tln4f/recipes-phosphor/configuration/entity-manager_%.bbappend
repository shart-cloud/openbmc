# Install the X10SDV-TLN4F entity-manager sensor configuration.
#
# entity-manager + dbus-sensors are already pulled into the image by
# packagegroup-supermicro-apps; this only supplies our board config. It probes
# against the FRU product name "X10SDV-TLN4F" (see Probe in the JSON).
#
# We also drop entity-manager's stock example board configs: none of them match
# our FRU, so they never instantiate, and on the 32 MiB static flash (~0.65 MiB
# rofs headroom after the M1 iKVM trim) the unused JSON is pure dead weight.
# Same pattern as meta-amd/meta-daytonax.

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:x10sdv-tln4f = " file://X10SDV-TLN4F.json"

do_install:append:x10sdv-tln4f() {
    # Modern Yocto unpacks file:// SRC_URI into UNPACKDIR, not WORKDIR
    # (same gotcha that bit the M1 DTS install).
    rm -f ${D}${datadir}/entity-manager/configurations/*.json
    install -d ${D}${datadir}/entity-manager/configurations
    install -m 0644 ${UNPACKDIR}/X10SDV-TLN4F.json \
        ${D}${datadir}/entity-manager/configurations/
}
