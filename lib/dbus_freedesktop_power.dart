import 'package:dbus/dbus.dart';
import 'package:dbus_power/interfaces/upower_remote_object.dart';
import 'package:dbus_power/interfaces/upower_kbd_backlight_remote_object.dart';
import 'package:dbus_power/interfaces/upower_device_remote_object.dart';

const _destination = 'org.freedesktop.UPower';

/// A class to interact with the freedesktop UPower service using D-Bus.
class DBusFreedesktopPower {
  final DBusClient _client;

  DBusFreedesktopPower() : _client = DBusClient.system();

  OrgFreedesktopUPower get _upower =>
      OrgFreedesktopUPower(_client, _destination);

  OrgFreedesktopUPowerKbdBacklight get _kbd =>
      OrgFreedesktopUPowerKbdBacklight(_client, _destination);

  /// The device to read, defaulting to the composite display device.
  OrgFreedesktopUPowerDevice _device([String? path]) => path == null
      ? OrgFreedesktopUPowerDevice(_client, _destination)
      : OrgFreedesktopUPowerDevice(
          _client,
          _destination,
          path: DBusObjectPath(path),
        );

  // Daemon

  /// Get the running UPower daemon version
  Future<String> getDaemonVersion() => _upower.getDaemonVersion();

  /// Whether the system is currently running on battery
  Future<bool> isOnBattery() => _upower.getOnBattery();

  /// Whether the laptop lid is closed
  Future<bool> isLidClosed() => _upower.getLidIsClosed();

  /// Whether the system has a laptop lid
  Future<bool> isLidPresent() => _upower.getLidIsPresent();

  /// Get the action taken on a critically low battery (e.g. "PowerOff")
  Future<String> getCriticalAction() => _upower.callGetCriticalAction();

  /// List the object paths of all known power devices
  Future<List<String>> enumerateDevices() async {
    final devices = await _upower.callEnumerateDevices();
    return devices.map((d) => d.value).toList();
  }

  /// Get the object path of the composite display device
  Future<String> getDisplayDevicePath() async {
    final device = await _upower.callGetDisplayDevice();
    return device.value;
  }

  // Keyboard backlight

  /// Get the keyboard backlight brightness as a percentage (0-100)
  Future<int> getKeyboardBrightness() async {
    final value = await _kbd.callGetBrightness();
    final max = await _kbd.callGetMaxBrightness();
    return max == 0 ? 0 : (value / max * 100).round();
  }

  /// Set the keyboard backlight brightness from a percentage (0-100)
  Future<void> setKeyboardBrightness(int percent) async {
    if (percent < 0 || percent > 100) {
      throw RangeError.range(percent, 0, 100, 'percent');
    }
    final max = await _kbd.callGetMaxBrightness();
    await _kbd.callSetBrightness((percent / 100 * max).round());
  }

  /// Get the raw keyboard backlight brightness
  Future<int> getKeyboardBrightnessRaw() => _kbd.callGetBrightness();

  /// Set the raw keyboard backlight brightness
  Future<void> setKeyboardBrightnessRaw(int value) =>
      _kbd.callSetBrightness(value);

  /// Get the maximum raw keyboard backlight brightness
  Future<int> getMaxKeyboardBrightness() => _kbd.callGetMaxBrightness();

  // Device / battery (defaults to the composite display device)

  /// Get the battery charge percentage (0-100)
  Future<double> getBatteryPercentage([String? device]) =>
      _device(device).getPercentage();

  /// Get the battery state (1=charging, 2=discharging, 3=empty, 4=fully charged)
  Future<int> getBatteryState([String? device]) => _device(device).getState();

  /// UPower's estimate of the seconds until the battery is empty
  Future<int> getTimeToEmpty([String? device]) =>
      _device(device).getTimeToEmpty();

  /// UPower's estimate of the seconds until the battery is full
  Future<int> getTimeToFull([String? device]) =>
      _device(device).getTimeToFull();

  /// Get the battery type (1=line power, 2=battery, 3=ups, ...)
  Future<int> getDeviceType([String? device]) => _device(device).getType();

  /// Get the device's kernel native path
  Future<String> getNativePath([String? device]) =>
      _device(device).getNativePath();

  /// Get the device vendor
  Future<String> getVendor([String? device]) => _device(device).getVendor();

  /// Get the device model
  Future<String> getModel([String? device]) => _device(device).getModel();

  /// Get the device serial number
  Future<String> getSerial([String? device]) => _device(device).getSerial();

  /// Get the icon name suggested for the device
  Future<String> getIconName([String? device]) => _device(device).getIconName();

  /// Whether the device is present
  Future<bool> isPresent([String? device]) => _device(device).getIsPresent();

  /// Whether the device is rechargeable
  Future<bool> isRechargeable([String? device]) =>
      _device(device).getIsRechargeable();

  /// Whether the device is a power supply (as opposed to e.g. a peripheral)
  Future<bool> isPowerSupply([String? device]) =>
      _device(device).getPowerSupply();

  /// Whether a line-power device is online
  Future<bool> isOnline([String? device]) => _device(device).getOnline();

  /// Get the current energy in watt-hours
  Future<double> getEnergy([String? device]) => _device(device).getEnergy();

  /// Get the energy when empty in watt-hours
  Future<double> getEnergyEmpty([String? device]) =>
      _device(device).getEnergyEmpty();

  /// Get the energy when full in watt-hours
  Future<double> getEnergyFull([String? device]) =>
      _device(device).getEnergyFull();

  /// Get the design energy when full in watt-hours
  Future<double> getEnergyFullDesign([String? device]) =>
      _device(device).getEnergyFullDesign();

  /// Get the energy rate (power draw) in watts
  Future<double> getEnergyRate([String? device]) =>
      _device(device).getEnergyRate();

  /// Get the device voltage
  Future<double> getVoltage([String? device]) => _device(device).getVoltage();

  /// Get the device temperature in degrees Celsius
  Future<double> getTemperature([String? device]) =>
      _device(device).getTemperature();

  /// Get the battery capacity (health) as a percentage of design capacity
  Future<double> getCapacity([String? device]) => _device(device).getCapacity();

  /// Get the battery technology (1=lithium ion, ...)
  Future<int> getTechnology([String? device]) =>
      _device(device).getTechnology();

  /// Get the number of charge cycles, or -1 if unknown
  Future<int> getChargeCycles([String? device]) =>
      _device(device).getChargeCycles();

  /// Get the warning level (1=none, 3=low, 4=critical, 5=action)
  Future<int> getWarningLevel([String? device]) =>
      _device(device).getWarningLevel();

  /// Get the coarse battery level (1=none, 3=low, 6=normal, 8=full)
  Future<int> getBatteryLevel([String? device]) =>
      _device(device).getBatteryLevel();

  /// Get the time the device was last updated (seconds since epoch)
  Future<int> getUpdateTime([String? device]) =>
      _device(device).getUpdateTime();

  /// Refresh the cached data for the device
  Future<void> refresh([String? device]) => _device(device).callRefresh();

  /// Get charge/rate/charge history samples for the device
  Future<List<List<DBusValue>>> getHistory(
    String type,
    int timespan,
    int resolution, {
    String? device,
  }) => _device(device).callGetHistory(type, timespan, resolution);

  /// Get statistics (charging/discharging) for the device
  Future<List<List<DBusValue>>> getStatistics(String type, {String? device}) =>
      _device(device).callGetStatistics(type);

  /// Closes the D-Bus client connection
  Future<void> close() => _client.close();
}
