import 'dart:io';
import '../services/config_service.dart';
import '../utils/cli_utils.dart';

/// Command for initializing the AI Translation Generator
class InitCommand {
  final ConfigService _configService;

  InitCommand({ConfigService? configService})
    : _configService = configService ?? ConfigService();

  /// Execute the init command
  Future<void> execute() async {
    try {
      CliUtils.printHeader();
      CliUtils.printInfo('Initializing AI Translation Generator...');
      CliUtils.printSeparator();

      // Check if config already exists
      if (_configService.configExists()) {
        CliUtils.printWarning('Configuration file already exists.');
        CliUtils.printInfo(
          'Current directory: ${_configService.getCurrentDirectory()}',
        );
        return;
      }

      // Create default configuration
      CliUtils.printInfo('Creating default configuration file...');
      await _configService.createDefaultConfig();

      CliUtils.printSuccess('Configuration file created successfully!');
      CliUtils.printInfo('File: ai_translation_generator.yaml');
      stdout.writeln();
      CliUtils.printSeparator();
      stdout.writeln();

      CliUtils.printInfo('Next steps:');
      stdout.writeln();
      CliUtils.printColored(
        '1. Edit ai_translation_generator.yaml to add your strings',
        color: 'cyan',
      );
      CliUtils.printColored(
        '2. Run "aitranslation generate" to start translation',
        color: 'cyan',
      );
      stdout.writeln();
    } catch (e) {
      CliUtils.printError('Failed to initialize: ${e.toString()}');
      exit(1);
    }
  }
}
