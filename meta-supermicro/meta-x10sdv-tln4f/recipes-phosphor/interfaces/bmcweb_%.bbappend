# Silence the boot-time warning
#   bmcweb.service:NN: StateDirectory= path is absolute, ignoring: /home/root
#
# bmcweb's upstream (meson-generated) unit ships `StateDirectory=/home/root`.
# systemd only accepts StateDirectory= relative to /var/lib, so it rejects the
# absolute value and logs the warning while parsing that line at unit load --
# a systemd drop-in can't suppress it because the warning fires before any later
# reset. bmcweb persists its data to /home/root (ROOT_HOME) directly, not via
# systemd's StateDirectory machinery, so the directive is inert; we just strip
# the offending line from the installed unit. Scoped via the :x10sdv-tln4f
# override so it only touches our machine.

do_install:append:x10sdv-tln4f() {
    unit="${D}${systemd_system_unitdir}/bmcweb.service"
    if [ -f "$unit" ]; then
        sed -i '\#^StateDirectory=/home/root$#d' "$unit"
    fi
}
