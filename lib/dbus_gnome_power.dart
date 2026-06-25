import 'package:dbus/dbus.dart';
import 'package:dbus_power/interfaces/gnome_power_remote_object.dart';

/// A class to interact with the GNOME Settings Daemon Power settings using D-Bus.
class DBusGnomePower {
  final DBusClient _client;
  late final OrgGnomeSettingsDaemonPower _power;

  DBusGnomePower() : _client = DBusClient.session() {
    _power = OrgGnomeSettingsDaemonPower(
      _client,
      'org.gnome.SettingsDaemon.Power',
    );
  }

  // Keyboard backlight

  /// Get the keyboard backlight brightness
  Future<int> getKeyboardBrightness() => _power.getBrightness();

  /// Set the keyboard backlight brightness
  Future<void> setKeyboardBrightness(int value) => _power.setBrightness(value);

  /// Get the number of keyboard backlight steps
  Future<int> getKeyboardSteps() => _power.getSteps();

  /// Step the keyboard backlight up, returns the new percentage
  Future<int> keyboardStepUp() => _power.callStepUp();

  /// Step the keyboard backlight down, returns the new percentage
  Future<int> keyboardStepDown() => _power.callStepDown();

  /// Toggle the keyboard backlight, returns the new percentage
  Future<int> keyboardToggle() => _power.callToggle();

  // Screen backlight

  /// Get the screen brightness
  Future<int> getScreenBrightness() => _power.getBrightness_();

  /// Set the screen brightness
  Future<void> setScreenBrightness(int value) => _power.setBrightness_(value);

  /// Step the screen brightness up, returns the new percentage and connector
  Future<List<DBusValue>> screenStepUp() => _power.callStepUp_();

  /// Step the screen brightness down, returns the new percentage and connector
  Future<List<DBusValue>> screenStepDown() => _power.callStepDown_();

  /// Cycle the screen brightness, returns the new percentage and output id
  Future<List<DBusValue>> screenCycle() => _power.callCycle();

  /// Closes the D-Bus client connection
  Future<void> close() => _client.close();
}
