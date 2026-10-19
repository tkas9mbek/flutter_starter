import 'package:flutter_test/flutter_test.dart';
import 'package:starter/core/global/global_variables.dart';
import 'package:starter/core/remote_config/configs/remote_config_module.dart';
import 'package:starter/core/remote_config/domain/remote_config_registry.dart';
import 'package:starter/core/remote_config/model/remote_general_settings.dart';
import 'package:starter/core/remote_config/model/remote_phone_codes.dart';

void main() {
  const generalSettings = RemoteGeneralSettings(
    appVersion: AppVersion(
      minimal: AppVersionPlatform(ios: '1.0.0', android: '1.0.0'),
      current: AppVersionPlatform(ios: '2.0.0', android: '2.0.0'),
    ),
  );

  group('descriptorFor', () {
    final registry = RemoteConfigRegistry([
      const RemoteConfigDescriptor<RemoteGeneralSettings>(
        key: 'general',
        fromJson: RemoteGeneralSettings.fromJson,
        defaultValue: generalSettings,
      ),
    ]);

    test('resolves the descriptor registered for the type', () {
      final descriptor = registry.descriptorFor<RemoteGeneralSettings>();

      expect(descriptor.key, 'general');
      expect(descriptor.defaultValue, generalSettings);
      expect(
        descriptor.fromJson({
          'appVersion': {
            'minimal': {'ios': '1.0.0', 'android': '1.0.0'},
            'current': {'ios': '2.0.0', 'android': '2.0.0'},
          },
        }),
        generalSettings,
      );
    });

    test(
      'throws a StateError for a type with no descriptor',
      () => expect(
        registry.descriptorFor<RemotePhoneCodes>,
        throwsA(isA<StateError>()),
      ),
    );
  });

  group('module defaults from assets/remote_config', () {
    late RemoteConfigRegistry registry;

    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await getIt.reset();
      await RemoteConfigModule().register();
      registry = getIt<RemoteConfigRegistry>();
    });

    tearDown(() async => getIt.reset());

    test('parses the general.json object default', () {
      final descriptor = registry.descriptorFor<RemoteGeneralSettings>();

      expect(descriptor.key, 'general');
      expect(descriptor.defaultValue.appVersion.minimal.ios, '1.0.0');
      expect(descriptor.defaultValue.appVersion.current.android, '1.0.0');
    });

    test('wraps the phone_code.json list default into items', () {
      final descriptor = registry.descriptorFor<RemotePhoneCodes>();
      final kyrgyzstan = descriptor.defaultValue.items.first;

      expect(descriptor.key, 'phone_code');
      expect(descriptor.defaultValue.items, isNotEmpty);
      expect(kyrgyzstan.countryCode, 'kg');
      expect(kyrgyzstan.dialCode, '+996');
      expect(kyrgyzstan.name.resolve('en'), 'Kyrgyzstan');
    });
  });
}
