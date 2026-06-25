import 'package:dbus_power/dbus_power.dart';
import 'package:test/test.dart';

void main() {
  group('DBusGnomePower', () {
    late DBusGnomePower power;

    setUp(() {
      power = DBusGnomePower();
    });

    tearDown(() async {
      await power.close();
    });

    test('reads screen brightness', () async {
      final brightness = await power.getScreenBrightness();
      expect(brightness, isA<int>());
    });

    test('reads keyboard brightness', () async {
      final brightness = await power.getKeyboardBrightness();
      expect(brightness, isA<int>());
    });

    test('reads keyboard steps', () async {
      final steps = await power.getKeyboardSteps();
      expect(steps, isA<int>());
    });
  });
}
