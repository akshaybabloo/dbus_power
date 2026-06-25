import 'package:dbus_power/dbus_power.dart';

void main() async {
  final power = DBusGnomePower();

  final screen = await power.getScreenBrightness();
  print('Screen brightness: $screen%');

  final keyboard = await power.getKeyboardBrightness();
  print('Keyboard brightness: $keyboard%');

  await power.close();
}
