# Install the X10SDV-TLN4F entity-manager sensor configuration.
#
# entity-manager + dbus-sensors are already pulled into the image by
# packagegroup-supermicro-apps; this only supplies our board config. It probes
# against the FRU product name "X10SDV-TLN4F" (see Probe in the JSON).
#
# We also drop entity-manager's stock example board configs: none of them match
# our FRU, so they never instantiate, and on the 32 MiB static flash (~0.65 MiB
# rofs headroom after the M1 iKVM trim) the unused JSON is pure dead weight.
# Same intent as meta-amd/meta-daytonax, but that bbappend's `rm -f *.json` is
# stale: our entity-manager srcrev organises the stock configs into per-vendor
# SUBDIRECTORIES (amd/, supermicro/, tyan/, ...), so a top-level glob misses
# them. Clear the whole configurations dir instead. blacklist.json lives under
# ${datadir}/entity-manager/, not here, so nothing else is affected.

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:x10sdv-tln4f = " file://X10SDV-TLN4F.json"

do_install:append:x10sdv-tln4f() {
    # Modern Yocto unpacks file:// SRC_URI into UNPACKDIR, not WORKDIR
    # (same gotcha that bit the M1 DTS install).
    rm -rf ${D}${datadir}/entity-manager/configurations
    install -d ${D}${datadir}/entity-manager/configurations
    install -m 0644 ${UNPACKDIR}/X10SDV-TLN4F.json \
        ${D}${datadir}/entity-manager/configurations/
}
