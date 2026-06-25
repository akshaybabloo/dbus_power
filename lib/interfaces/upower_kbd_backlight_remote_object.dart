// This file was generated using the following command and may be overwritten.
// dart-dbus generate-remote-object ./interfaces/org.freedesktop.UPower.KbdBacklight.xml

import 'dart:io';
import 'package:dbus/dbus.dart';

/// Signal data for org.freedesktop.UPower.KbdBacklight.BrightnessChanged.
class OrgFreedesktopUPowerKbdBacklightBrightnessChanged extends DBusSignal {
  int get value => values[0].asInt32();

  OrgFreedesktopUPowerKbdBacklightBrightnessChanged(DBusSignal signal) : super(sender: signal.sender, path: signal.path, interface: signal.interface, name: signal.name, values: signal.values);
}

/// Signal data for org.freedesktop.UPower.KbdBacklight.BrightnessChangedWithSource.
class OrgFreedesktopUPowerKbdBacklightBrightnessChangedWithSource extends DBusSignal {
  int get value => values[0].asInt32();
  String get source => values[1].asString();

  OrgFreedesktopUPowerKbdBacklightBrightnessChangedWithSource(DBusSignal signal) : super(sender: signal.sender, path: signal.path, interface: signal.interface, name: signal.name, values: signal.values);
}

class OrgFreedesktopUPowerKbdBacklight extends DBusRemoteObject {
  /// Stream of org.freedesktop.UPower.KbdBacklight.BrightnessChanged signals.
  late final Stream<OrgFreedesktopUPowerKbdBacklightBrightnessChanged> brightnessChanged;

  /// Stream of org.freedesktop.UPower.KbdBacklight.BrightnessChangedWithSource signals.
  late final Stream<OrgFreedesktopUPowerKbdBacklightBrightnessChangedWithSource> brightnessChangedWithSource;

  OrgFreedesktopUPowerKbdBacklight(DBusClient client, String destination, {DBusObjectPath path = const DBusObjectPath.unchecked('/org/freedesktop/UPower/KbdBacklight')}) : super(client, name: destination, path: path) {
    brightnessChanged = DBusRemoteObjectSignalStream(object: this, interface: 'org.freedesktop.UPower.KbdBacklight', name: 'BrightnessChanged', signature: DBusSignature('i')).asBroadcastStream().map((signal) => OrgFreedesktopUPowerKbdBacklightBrightnessChanged(signal));

    brightnessChangedWithSource = DBusRemoteObjectSignalStream(object: this, interface: 'org.freedesktop.UPower.KbdBacklight', name: 'BrightnessChangedWithSource', signature: DBusSignature('is')).asBroadcastStream().map((signal) => OrgFreedesktopUPowerKbdBacklightBrightnessChangedWithSource(signal));
  }

  /// Invokes org.freedesktop.UPower.KbdBacklight.GetMaxBrightness()
  Future<int> callGetMaxBrightness({bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.freedesktop.UPower.KbdBacklight', 'GetMaxBrightness', [], replySignature: DBusSignature('i'), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asInt32();
  }

  /// Invokes org.freedesktop.UPower.KbdBacklight.GetBrightness()
  Future<int> callGetBrightness({bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.freedesktop.UPower.KbdBacklight', 'GetBrightness', [], replySignature: DBusSignature('i'), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asInt32();
  }

  /// Invokes org.freedesktop.UPower.KbdBacklight.SetBrightness()
  Future<void> callSetBrightness(int value, {bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.freedesktop.UPower.KbdBacklight', 'SetBrightness', [DBusInt32(value)], replySignature: DBusSignature(''), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
  }
}
