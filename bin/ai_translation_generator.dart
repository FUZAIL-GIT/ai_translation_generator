import 'dart:io';
import 'package:args/args.dart';
import 'package:ai_translation_generator/commands/init_command.dart';
import 'package:ai_translation_generator/commands/generate_command.dart';
import 'package:ai_translation_generator/utils/cli_utils.dart';

void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addCommand('init')
    ..addCommand('generate')
    ..addFlag('help', abbr: 'h', help: 'Show help information');

  try {
    final results = parser.parse(arguments);

    if (results['help'] == true || arguments.isEmpty) {
      _showHelp();
      return;
    }

    final command = results.command;

    switch (command?.name) {
      case 'init':
        await InitCommand().execute();
        exit(0);
      case 'generate':
        await GenerateCommand().execute();
        exit(0);
      default:
        CliUtils.printError('Unknown command: ${command?.name}');
        _showHelp();
        exit(1);
    }
  } catch (e) {
    CliUtils.printError('Error: ${e.toString()}');
    exit(1);
  }
}

void _showHelp() {
  CliUtils.printHeader();
  CliUtils.printInfo('Available commands:');
  CliUtils.printColored(
    '  init      Initialize the AI Translation Generator',
    color: 'cyan',
  );
  CliUtils.printColored(
    '  generate  Generate translations using Gemini AI',
    color: 'cyan',
  );
  CliUtils.printSeparator();
  CliUtils.printInfo('Usage:');
  CliUtils.printColored('  aitranslation init', color: 'yellow');
  CliUtils.printColored('  aitranslation generate', color: 'yellow');
}
