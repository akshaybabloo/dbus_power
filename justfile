# use PowerShell instead of sh:
set windows-shell := ["pwsh.exe", "-c"]

default: (help)

# Print this help message
@help:
    echo "run 'just list' to list targets"
    echo "more information can be found at http://just.systems/"
    just list

# List the recipes and descriptions
list:
    @just --list

generate:
    dart pub global activate dbus
    dart-dbus generate-remote-object ./interfaces/org.gnome.SettingsDaemon.Power.xml -o lib/interfaces/gnome_power_remote_object.dart --class-name OrgGnomeSettingsDaemonPower
    dart-dbus generate-remote-object ./interfaces/org.freedesktop.UPower.xml -o lib/interfaces/upower_remote_object.dart --class-name OrgFreedesktopUPower
    dart-dbus generate-remote-object ./interfaces/org.freedesktop.UPower.KbdBacklight.xml -o lib/interfaces/upower_kbd_backlight_remote_object.dart --class-name OrgFreedesktopUPowerKbdBacklight
    dart-dbus generate-remote-object ./interfaces/org.freedesktop.UPower.Device.xml -o lib/interfaces/upower_device_remote_object.dart --class-name OrgFreedesktopUPowerDevice
