// This file was generated using the following command and may be overwritten.
// dart-dbus generate-remote-object ./interfaces/org.freedesktop.UPower.xml

import 'dart:io';
import 'package:dbus/dbus.dart';

/// Signal data for org.freedesktop.UPower.DeviceAdded.
class OrgFreedesktopUPowerDeviceAdded extends DBusSignal {
  DBusObjectPath get device => values[0].asObjectPath();

  OrgFreedesktopUPowerDeviceAdded(DBusSignal signal) : super(sender: signal.sender, path: signal.path, interface: signal.interface, name: signal.name, values: signal.values);
}

/// Signal data for org.freedesktop.UPower.DeviceRemoved.
class OrgFreedesktopUPowerDeviceRemoved extends DBusSignal {
  DBusObjectPath get device => values[0].asObjectPath();

  OrgFreedesktopUPowerDeviceRemoved(DBusSignal signal) : super(sender: signal.sender, path: signal.path, interface: signal.interface, name: signal.name, values: signal.values);
}

class OrgFreedesktopUPower extends DBusRemoteObject {
  /// Stream of org.freedesktop.UPower.DeviceAdded signals.
  late final Stream<OrgFreedesktopUPowerDeviceAdded> deviceAdded;

  /// Stream of org.freedesktop.UPower.DeviceRemoved signals.
  late final Stream<OrgFreedesktopUPowerDeviceRemoved> deviceRemoved;

  OrgFreedesktopUPower(DBusClient client, String destination, {DBusObjectPath path = const DBusObjectPath.unchecked('/org/freedesktop/UPower')}) : super(client, name: destination, path: path) {
    deviceAdded = DBusRemoteObjectSignalStream(object: this, interface: 'org.freedesktop.UPower', name: 'DeviceAdded', signature: DBusSignature('o')).asBroadcastStream().map((signal) => OrgFreedesktopUPowerDeviceAdded(signal));

    deviceRemoved = DBusRemoteObjectSignalStream(object: this, interface: 'org.freedesktop.UPower', name: 'DeviceRemoved', signature: DBusSignature('o')).asBroadcastStream().map((signal) => OrgFreedesktopUPowerDeviceRemoved(signal));
  }

  /// Gets org.freedesktop.UPower.DaemonVersion
  Future<String> getDaemonVersion() async {
    var value = await getProperty('org.freedesktop.UPower', 'DaemonVersion', signature: DBusSignature('s'));
    return value.asString();
  }

  /// Gets org.freedesktop.UPower.OnBattery
  Future<bool> getOnBattery() async {
    var value = await getProperty('org.freedesktop.UPower', 'OnBattery', signature: DBusSignature('b'));
    return value.asBoolean();
  }

  /// Gets org.freedesktop.UPower.LidIsClosed
  Future<bool> getLidIsClosed() async {
    var value = await getProperty('org.freedesktop.UPower', 'LidIsClosed', signature: DBusSignature('b'));
    return value.asBoolean();
  }

  /// Gets org.freedesktop.UPower.LidIsPresent
  Future<bool> getLidIsPresent() async {
    var value = await getProperty('org.freedesktop.UPower', 'LidIsPresent', signature: DBusSignature('b'));
    return value.asBoolean();
  }

  /// Invokes org.freedesktop.UPower.EnumerateDevices()
  Future<List<DBusObjectPath>> callEnumerateDevices({bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.freedesktop.UPower', 'EnumerateDevices', [], replySignature: DBusSignature('ao'), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asObjectPathArray().toList();
  }

  /// Invokes org.freedesktop.UPower.GetDisplayDevice()
  Future<DBusObjectPath> callGetDisplayDevice({bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.freedesktop.UPower', 'GetDisplayDevice', [], replySignature: DBusSignature('o'), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asObjectPath();
  }

  /// Invokes org.freedesktop.UPower.GetCriticalAction()
  Future<String> callGetCriticalAction({bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.freedesktop.UPower', 'GetCriticalAction', [], replySignature: DBusSignature('s'), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asString();
  }
}
