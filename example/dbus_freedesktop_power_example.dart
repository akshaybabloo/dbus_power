import 'package:dbus_power/dbus_power.dart';

void main() async {
  final power = DBusFreedesktopPower();

  print('On battery: ${await power.isOnBattery()}');
  print('Battery: ${await power.getBatteryPercentage()}%');
  print('Battery state: ${await power.getBatteryState()}');

  final keyboard = await power.getKeyboardBrightness();
  print('Keyboard backlight: $keyboard%');

  await power.close();
}
