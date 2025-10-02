import 'package:ai_translation_generator/ai_translation_generator.dart';
import 'package:test/test.dart';

void main() {
  group('AI Translation Generator', () {
    test('TranslationConfig default config should be valid', () {
      final config = TranslationConfig.defaultConfig();
      expect(config.isValid, true);
      expect(config.languages, isNotEmpty);
      expect(config.strings, isNotEmpty);
    });

    test('TranslationConfig should create from map', () {
      final map = {
        'languages': ['en', 'ar'],
        'strings': ['settings', 'home'],
      };
      final config = TranslationConfig.fromMap(map);
      expect(config.languages, ['en', 'ar']);
      expect(config.strings, ['settings', 'home']);
    });
  });
}
