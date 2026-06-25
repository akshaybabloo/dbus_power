import 'package:dbus/dbus.dart';
import 'package:dbus_power/dbus_power.dart';
import 'package:test/test.dart';

void main() {
  group('DBusGnomePower', () {
    late DBusGnomePower power;
    var available = false;

    setUpAll(() async {
      // These tests require a live GNOME Settings Daemon Power service on the
      // session bus, which is not present in headless/CI environments.
      final client = DBusClient.session();
      try {
        final names = await client.listNames();
        available = names.contains('org.gnome.SettingsDaemon.Power');
      } catch (_) {
        available = false;
      } finally {
        await client.close();
      }
    });

    setUp(() {
      power = DBusGnomePower();
    });

    tearDown(() async {
      await power.close();
    });

    test('reads screen brightness', () async {
      if (!available) return markTestSkipped('GNOME power service unavailable');
      expect(await power.getScreenBrightness(), isA<int>());
    });

    test('reads keyboard brightness', () async {
      if (!available) return markTestSkipped('GNOME power service unavailable');
      expect(await power.getKeyboardBrightness(), isA<int>());
    });

    test('reads keyboard steps', () async {
      if (!available) return markTestSkipped('GNOME power service unavailable');
      expect(await power.getKeyboardSteps(), isA<int>());
    });
  });
}
