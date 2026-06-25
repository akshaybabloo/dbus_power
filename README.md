# DBusPower

`dbus_power` is a Dart library for interacting with Linux power settings over D-Bus. It exposes two backends: `DBusGnomePower` for the GNOME Settings Daemon (session bus, percentage based) and `DBusFreedesktopPower` for freedesktop's UPower (system bus, battery state and keyboard backlight).

## Features

- Get and set the screen brightness (GNOME).
- Get and set the keyboard backlight brightness (GNOME and UPower).
- Step screen brightness up and down, and toggle the keyboard backlight.
- Read battery state via UPower: charge percentage, charging state, and time estimates.
- Check whether the system is running on battery.

## Installation

Add the package to your project using the following command:

```bash
dart pub add dbus_power
```

## Usage

### GNOME (session bus)

```dart
import 'package:dbus_power/dbus_power.dart';

void main() async {
  final power = DBusGnomePower();

  // Get the current screen brightness (0-100)
  final screen = await power.getScreenBrightness();
  print('Screen brightness: $screen%');

  // Set the screen brightness
  await power.setScreenBrightness(50);

  // Get and set the keyboard backlight brightness
  final keyboard = await power.getKeyboardBrightness();
  print('Keyboard brightness: $keyboard%');
  await power.setKeyboardBrightness(75);

  // Toggle the keyboard backlight on/off
  await power.keyboardToggle();

  // Close the D-Bus client connection
  await power.close();
}
```

### UPower (system bus)

GNOME's power daemon is a session-bus policy layer on top of freedesktop's UPower. Use `DBusFreedesktopPower` when you want battery information or to talk to UPower directly. Note that UPower works in raw values; the wrapper converts the keyboard backlight to/from a percentage for you.

```dart
import 'package:dbus_power/dbus_power.dart';

void main() async {
  final power = DBusFreedesktopPower();

  // Whether the system is running on battery
  print('On battery: ${await power.isOnBattery()}');

  // Battery charge percentage and state (1=charging, 2=discharging, 4=full)
  print('Battery: ${await power.getBatteryPercentage()}%');
  print('Battery state: ${await power.getBatteryState()}');

  // Keyboard backlight brightness (0-100)
  print('Keyboard backlight: ${await power.getKeyboardBrightness()}%');
  await power.setKeyboardBrightness(75);

  // Close the D-Bus client connection
  await power.close();
}
```

## Command line

The package ships a `dbus-power` executable with an interactive menu for adjusting
brightness and viewing battery status:

```bash
dart pub global activate dbus_power
dbus-power
```

## License

This project is licensed under the MIT License.
