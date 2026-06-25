import 'package:dbus_power/dbus_power.dart';

Future<void> main() async {
  final power = DBusGnomePower();
  try {
    final screen = await power.getScreenBrightness();
    print('Screen brightness: $screen%');

    final keyboard = await power.getKeyboardBrightness();
    print('Keyboard brightness: $keyboard%');
  } finally {
    await power.close();
  }
}
