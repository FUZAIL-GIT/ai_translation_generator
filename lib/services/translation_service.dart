import 'dart:async';
import 'dart:io';
import '../models/translation_config.dart';
import 'gemini_service.dart';

/// Service for handling translation operations
class TranslationService {
  final GeminiService _geminiService;
  final TranslationConfig _config;

  TranslationService({
    required GeminiService geminiService,
    required TranslationConfig config,
  }) : _geminiService = geminiService,
       _config = config;

  /// Generate translations for all strings in all languages
  Future<Map<String, Map<String, String>>> generateTranslations({
    required Function(String) onProgress,
    required Function(String) onLanguageComplete,
  }) async {
    final results = <String, Map<String, String>>{};

    // Check internet connectivity silently
    final hasConnection = await _geminiService.checkConnectivity();
    if (!hasConnection) {
      throw Exception(
        'No internet connection. Please check your network and try again.',
      );
    }

    for (final language in _config.languages) {
      onProgress('Generating $language translation...');

      final languageTranslations = <String, String>{};

      for (final string in _config.strings) {
        try {
          final translatedText = await _geminiService.translateString(
            text: string,
            targetLanguage: language,
            sourceLanguage: 'en', // Assuming source is English
          );

          languageTranslations[string] = translatedText;
        } catch (e) {
          throw Exception(
            'Failed to translate "$string" to $language: ${e.toString()}',
          );
        }
      }

      results[language] = languageTranslations;
      onLanguageComplete('$language translation generated successfully');
    }

    return results;
  }

  /// Save translations to files in lib/l10n directory
  Future<void> saveTranslations(
    Map<String, Map<String, String>> translations,
  ) async {
    // Create lib/l10n directory if it doesn't exist
    final l10nDir = Directory('lib/l10n');
    if (!l10nDir.existsSync()) {
      l10nDir.createSync(recursive: true);
    }

    for (final entry in translations.entries) {
      final language = entry.key;
      final translations = entry.value;

      // Use Flutter l10n naming convention: {languageCode}.json
      final fileName = 'lib/l10n/$language.json';
      final content = _generateJsonContent(translations);

      await File(fileName).writeAsString(content);
    }
  }

  String _generateJsonContent(Map<String, String> translations) {
    final buffer = StringBuffer();
    buffer.writeln('{');

    final entries = translations.entries.toList();
    for (int i = 0; i < entries.length; i++) {
      final entry = entries[i];
      final isLast = i == entries.length - 1;

      buffer.writeln('  "${entry.key}": "${entry.value}"${isLast ? '' : ','}');
    }

    buffer.writeln('}');
    return buffer.toString();
  }
}
