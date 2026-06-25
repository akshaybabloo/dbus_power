import 'package:dbus/dbus.dart';
import 'package:dbus_power/interfaces/upower_remote_object.dart';
import 'package:dbus_power/interfaces/upower_kbd_backlight_remote_object.dart';
import 'package:dbus_power/interfaces/upower_device_remote_object.dart';

const _destination = 'org.freedesktop.UPower';

/// A class to interact with the freedesktop UPower service using D-Bus.
class DBusFreedesktopPower {
  final DBusClient _client;

  DBusFreedesktopPower() : _client = DBusClient.system();

  // Keyboard backlight

  /// Get the keyboard backlight brightness as a percentage (0-100)
  Future<int> getKeyboardBrightness() async {
    final kbd = OrgFreedesktopUPowerKbdBacklight(_client, _destination);
    final value = await kbd.callGetBrightness();
    final max = await kbd.callGetMaxBrightness();
    return max == 0 ? 0 : (value / max * 100).round();
  }

  /// Set the keyboard backlight brightness from a percentage (0-100)
  Future<void> setKeyboardBrightness(int percent) async {
    final kbd = OrgFreedesktopUPowerKbdBacklight(_client, _destination);
    final max = await kbd.callGetMaxBrightness();
    await kbd.callSetBrightness((percent / 100 * max).round());
  }

  // Battery

  /// Whether the system is currently running on battery
  Future<bool> isOnBattery() async {
    final upower = OrgFreedesktopUPower(_client, _destination);
    return upower.getOnBattery();
  }

  /// Get the battery charge percentage (0-100)
  Future<double> getBatteryPercentage() async {
    final device = OrgFreedesktopUPowerDevice(_client, _destination);
    return device.getPercentage();
  }

  /// Get the battery state (1=charging, 2=discharging, 3=empty, 4=fully charged)
  Future<int> getBatteryState() async {
    final device = OrgFreedesktopUPowerDevice(_client, _destination);
    return device.getState();
  }

  /// UPower's estimate of the seconds until the battery is empty
  Future<int> getTimeToEmpty() async {
    final device = OrgFreedesktopUPowerDevice(_client, _destination);
    return device.getTimeToEmpty();
  }

  /// UPower's estimate of the seconds until the battery is full
  Future<int> getTimeToFull() async {
    final device = OrgFreedesktopUPowerDevice(_client, _destination);
    return device.getTimeToFull();
  }

  /// Closes the D-Bus client connection
  Future<void> close() => _client.close();
}
