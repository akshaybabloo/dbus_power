import 'package:dbus_power/dbus_power.dart';

Future<void> main() async {
  final power = DBusFreedesktopPower();
  try {
    // Daemon and system state
    print('UPower version: ${await power.getDaemonVersion()}');
    print('On battery: ${await power.isOnBattery()}');
    print('Lid closed: ${await power.isLidClosed()}');

    // Composite battery (the display device)
    print('Battery: ${await power.getBatteryPercentage()}%');
    print('Battery state: ${await power.getBatteryState()}');
    print('Energy rate: ${await power.getEnergyRate()} W');
    print('Time to empty: ${await power.getTimeToEmpty()}s');

    // Inspect a specific device by path
    final devices = await power.enumerateDevices();
    print('Devices: $devices');
    final bat = devices.firstWhere(
      (d) => d.contains('battery_BAT'),
      orElse: () => '',
    );
    if (bat.isNotEmpty) {
      print(
        'BAT vendor/model: ${await power.getVendor(bat)} ${await power.getModel(bat)}',
      );
      print('BAT health: ${await power.getCapacity(bat)}%');
    }

    // Keyboard backlight (percentage and raw)
    print('Keyboard backlight: ${await power.getKeyboardBrightness()}%');
    print(
      'Keyboard raw: ${await power.getKeyboardBrightnessRaw()}'
      ' / ${await power.getMaxKeyboardBrightness()}',
    );
  } finally {
    await power.close();
  }
}
