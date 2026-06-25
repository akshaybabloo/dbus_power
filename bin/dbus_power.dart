import 'package:dart_console/dart_console.dart';
import 'package:dbus_power/dbus_power.dart';

void main() async {
  final power = DBusGnomePower();
  final console = Console();

  printMenu(console);
  var option = int.tryParse(console.readLine() ?? '');

  while (option != 8) {
    switch (option) {
      case 1:
        await getScreenBrightness(power, console);
        break;
      case 2:
        await setScreenBrightness(power, console);
        break;
      case 3:
        await stepScreen(power, console, up: true);
        break;
      case 4:
        await stepScreen(power, console, up: false);
        break;
      case 5:
        await getKeyboardBrightness(power, console);
        break;
      case 6:
        await setKeyboardBrightness(power, console);
        break;
      case 7:
        await toggleKeyboard(power, console);
        break;
      default:
        console.writeLine('Invalid option. Please try again.');
    }

    console.writeLine('');
    printMenu(console);
    option = int.tryParse(console.readLine() ?? '');
  }

  await power.close();
}

void printMenu(Console console) {
  console.writeLine('GNOME Power Manager');
  console.writeLine('-------------------');
  console.writeLine('1. Get screen brightness');
  console.writeLine('2. Set screen brightness');
  console.writeLine('3. Step screen brightness up');
  console.writeLine('4. Step screen brightness down');
  console.writeLine('5. Get keyboard brightness');
  console.writeLine('6. Set keyboard brightness');
  console.writeLine('7. Toggle keyboard backlight');
  console.writeLine('8. Exit');
  console.writeLine('');
  console.writeLine('Select an option:');
}

Future<void> getScreenBrightness(DBusGnomePower power, Console console) async {
  final brightness = await power.getScreenBrightness();
  console.writeLine('Screen brightness: $brightness%');
}

Future<void> setScreenBrightness(DBusGnomePower power, Console console) async {
  console.writeLine('Enter brightness (0-100):');
  final value = int.tryParse(console.readLine() ?? '');
  if (value == null || value < 0 || value > 100) {
    console.writeLine('Invalid value.');
    return;
  }
  await power.setScreenBrightness(value);
  console.writeLine('Screen brightness set to $value%');
}

Future<void> stepScreen(DBusGnomePower power, Console console, {required bool up}) async {
  final result = up ? await power.screenStepUp() : await power.screenStepDown();
  console.writeLine('Screen brightness: ${result[0].asInt32()}%');
}

Future<void> getKeyboardBrightness(DBusGnomePower power, Console console) async {
  final brightness = await power.getKeyboardBrightness();
  console.writeLine('Keyboard brightness: $brightness%');
}

Future<void> setKeyboardBrightness(DBusGnomePower power, Console console) async {
  console.writeLine('Enter brightness (0-100):');
  final value = int.tryParse(console.readLine() ?? '');
  if (value == null || value < 0 || value > 100) {
    console.writeLine('Invalid value.');
    return;
  }
  await power.setKeyboardBrightness(value);
  console.writeLine('Keyboard brightness set to $value%');
}

Future<void> toggleKeyboard(DBusGnomePower power, Console console) async {
  final brightness = await power.keyboardToggle();
  console.writeLine('Keyboard brightness: $brightness%');
}
