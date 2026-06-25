// This file was generated using the following command and may be overwritten.
// dart-dbus generate-remote-object ./interfaces/org.gnome.SettingsDaemon.Power.xml

import 'dart:io';
import 'package:dbus/dbus.dart';

/// Signal data for org.gnome.SettingsDaemon.Power.Keyboard.BrightnessChanged.
class OrgGnomeSettingsDaemonPowerBrightnessChanged extends DBusSignal {
  int get brightness => values[0].asInt32();
  String get source => values[1].asString();

  OrgGnomeSettingsDaemonPowerBrightnessChanged(DBusSignal signal) : super(sender: signal.sender, path: signal.path, interface: signal.interface, name: signal.name, values: signal.values);
}

class OrgGnomeSettingsDaemonPower extends DBusRemoteObject {
  /// Stream of org.gnome.SettingsDaemon.Power.Keyboard.BrightnessChanged signals.
  late final Stream<OrgGnomeSettingsDaemonPowerBrightnessChanged> brightnessChanged;

  OrgGnomeSettingsDaemonPower(DBusClient client, String destination, {DBusObjectPath path = const DBusObjectPath.unchecked('/org/gnome/SettingsDaemon/Power')}) : super(client, name: destination, path: path) {
    brightnessChanged = DBusRemoteObjectSignalStream(object: this, interface: 'org.gnome.SettingsDaemon.Power.Keyboard', name: 'BrightnessChanged', signature: DBusSignature('is')).asBroadcastStream().map((signal) => OrgGnomeSettingsDaemonPowerBrightnessChanged(signal));
  }

  /// Gets org.gnome.SettingsDaemon.Power.Keyboard.Brightness
  Future<int> getBrightness() async {
    var value = await getProperty('org.gnome.SettingsDaemon.Power.Keyboard', 'Brightness', signature: DBusSignature('i'));
    return value.asInt32();
  }

  /// Sets org.gnome.SettingsDaemon.Power.Keyboard.Brightness
  Future<void> setBrightness (int value) async {
    await setProperty('org.gnome.SettingsDaemon.Power.Keyboard', 'Brightness', DBusInt32(value));
  }

  /// Gets org.gnome.SettingsDaemon.Power.Keyboard.Steps
  Future<int> getSteps() async {
    var value = await getProperty('org.gnome.SettingsDaemon.Power.Keyboard', 'Steps', signature: DBusSignature('i'));
    return value.asInt32();
  }

  /// Invokes org.gnome.SettingsDaemon.Power.Keyboard.StepUp()
  Future<int> callStepUp({bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.gnome.SettingsDaemon.Power.Keyboard', 'StepUp', [], replySignature: DBusSignature('i'), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asInt32();
  }

  /// Invokes org.gnome.SettingsDaemon.Power.Keyboard.StepDown()
  Future<int> callStepDown({bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.gnome.SettingsDaemon.Power.Keyboard', 'StepDown', [], replySignature: DBusSignature('i'), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asInt32();
  }

  /// Invokes org.gnome.SettingsDaemon.Power.Keyboard.Toggle()
  Future<int> callToggle({bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.gnome.SettingsDaemon.Power.Keyboard', 'Toggle', [], replySignature: DBusSignature('i'), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asInt32();
  }

  /// Gets org.gnome.SettingsDaemon.Power.Screen.Brightness
  Future<int> getBrightness_() async {
    var value = await getProperty('org.gnome.SettingsDaemon.Power.Screen', 'Brightness', signature: DBusSignature('i'));
    return value.asInt32();
  }

  /// Sets org.gnome.SettingsDaemon.Power.Screen.Brightness
  Future<void> setBrightness_ (int value) async {
    await setProperty('org.gnome.SettingsDaemon.Power.Screen', 'Brightness', DBusInt32(value));
  }

  /// Invokes org.gnome.SettingsDaemon.Power.Screen.StepUp()
  Future<List<DBusValue>> callStepUp_({bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.gnome.SettingsDaemon.Power.Screen', 'StepUp', [], replySignature: DBusSignature('is'), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues;
  }

  /// Invokes org.gnome.SettingsDaemon.Power.Screen.StepDown()
  Future<List<DBusValue>> callStepDown_({bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.gnome.SettingsDaemon.Power.Screen', 'StepDown', [], replySignature: DBusSignature('is'), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues;
  }

  /// Invokes org.gnome.SettingsDaemon.Power.Screen.Cycle()
  Future<List<DBusValue>> callCycle({bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.gnome.SettingsDaemon.Power.Screen', 'Cycle', [], replySignature: DBusSignature('ii'), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues;
  }
}
