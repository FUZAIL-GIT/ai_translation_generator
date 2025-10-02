import 'dart:async';
import 'dart:io';
import '../services/config_service.dart';
import '../services/gemini_service.dart';
import '../services/translation_service.dart';
import '../utils/cli_utils.dart';

/// Command for generating translations
class GenerateCommand {
  final ConfigService _configService;
  final GeminiService _geminiService;

  GenerateCommand({ConfigService? configService, GeminiService? geminiService})
    : _configService = configService ?? ConfigService(),
      _geminiService = geminiService ?? GeminiService();

  /// Execute the generate command
  Future<void> execute() async {
    try {
      CliUtils.printHeader();
      CliUtils.printInfo('Starting translation generation...');
      CliUtils.printSeparator();

      // Load and validate configuration
      CliUtils.printInfo('Loading configuration...');
      final config = await _configService.loadConfig();

      CliUtils.printInfo('Validating configuration...');
      await _configService.validateConfig();

      CliUtils.printSuccess('Configuration loaded and validated successfully!');
      CliUtils.printInfo('Languages: ${config.languages.join(', ')}');
      CliUtils.printInfo('Strings to translate: ${config.strings.length}');
      CliUtils.printSeparator();

      // Create translation service
      final translationService = TranslationService(
        geminiService: _geminiService,
        config: config,
      );

      // Generate translations with progress tracking
      final translations = await _generateWithProgress(translationService);

      // Save translations
      CliUtils.printInfo('Saving translation files...');
      await translationService.saveTranslations(translations);

      // Add proper spacing
      stdout.writeln();
      CliUtils.printSeparator();
      stdout.writeln();
      CliUtils.printSuccess('Translation generation completed successfully!');
      stdout.writeln();
      CliUtils.printInfo('Generated files:');
      for (final language in config.languages) {
        CliUtils.printColored('  - lib/l10n/$language.json', color: 'cyan');
      }
      stdout.writeln();
      CliUtils.printInfo('You can now use these files in your Flutter app!');
      stdout.writeln();
    } catch (e) {
      CliUtils.printError('Translation generation failed: ${e.toString()}');
      exit(1);
    }
  }

  /// Generate translations with progress indicators
  Future<Map<String, Map<String, String>>> _generateWithProgress(
    TranslationService translationService,
  ) async {
    final completer = Completer<Map<String, Map<String, String>>>();
    final stopwatch = Stopwatch()..start();

    Timer? spinnerTimer;
    String currentMessage = '';
    bool isProcessing = false;

    // Start spinner
    spinnerTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (isProcessing) {
        CliUtils.clearLine();
        CliUtils.showSpinner(currentMessage);
      }
    });

    try {
      final result = await translationService.generateTranslations(
        onProgress: (message) {
          currentMessage = message;
          isProcessing = true;
        },
        onLanguageComplete: (message) {
          CliUtils.clearAndPrint('✓ $message');
          isProcessing = false;
        },
      );

      spinnerTimer.cancel();
      stopwatch.stop();

      // Add proper spacing
      stdout.writeln();
      CliUtils.printInfo('Total time: ${stopwatch.elapsed.inSeconds}s');

      completer.complete(result);
    } catch (e) {
      spinnerTimer.cancel();
      completer.completeError(e);
    }

    return completer.future;
  }
}
