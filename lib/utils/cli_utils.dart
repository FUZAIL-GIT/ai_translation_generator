import 'dart:io';

/// Utility class for CLI formatting and animations.
///
/// Provides methods for creating beautiful terminal output with colors,
/// progress indicators, and professional formatting for the AI Translation Generator CLI.
class CliUtils {
  static const String _spinnerChars = '⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏';
  static int _spinnerIndex = 0;

  /// Print colored text to the terminal.
  /// 
  /// [text] The text to print.
  /// [color] The color to use (red, green, blue, yellow, cyan, magenta, white, gray).
  static void printColored(String text, {String color = 'white'}) {
    final colorCode = _getColorCode(color);
    stdout.writeln('$colorCode$text$_resetColor');
  }

  /// Print success message with green color
  static void printSuccess(String message) {
    printColored('✓ $message', color: 'green');
  }

  /// Print error message with red color
  static void printError(String message) {
    printColored('✗ $message', color: 'red');
  }

  /// Print info message with blue color
  static void printInfo(String message) {
    printColored('ℹ $message', color: 'blue');
  }

  /// Print loading message with blue color
  static void printLoading(String message) {
    printColored('⏳ $message', color: 'blue');
  }

  /// Print warning message with yellow color
  static void printWarning(String message) {
    printColored('⚠ $message', color: 'yellow');
  }

  /// Show loading spinner
  static void showSpinner(String message) {
    stdout.write('\r${_spinnerChars[_spinnerIndex]} $message');
    _spinnerIndex = (_spinnerIndex + 1) % _spinnerChars.length;
  }

  /// Clear current line
  static void clearLine() {
    stdout.write('\r${' ' * 100}\r');
  }

  /// Print with proper line spacing
  static void printWithSpacing(String message) {
    stdout.writeln(message);
  }

  /// Clear line and print new message with proper spacing
  static void clearAndPrint(String message) {
    clearLine();
    stdout.writeln(message);
  }

  /// Print header
  static void printHeader() {
    printColored('''
╔══════════════════════════════════════════════════════════════╗
║                    AI Translation Generator                   ║
║              Powered by Gemini 2.0 Flash                    ║
╚══════════════════════════════════════════════════════════════╝
''', color: 'cyan');
  }

  /// Print section separator
  static void printSeparator() {
    printColored('─' * 60, color: 'gray');
  }

  /// Print progress bar
  static void printProgressBar(int current, int total, {String label = ''}) {
    final percentage = (current / total * 100).round();
    final barLength = 30;
    final filledLength = (current / total * barLength).round();

    final bar = '█' * filledLength + '░' * (barLength - filledLength);

    stdout.write('\r$label [$bar] $percentage% ($current/$total)');
  }

  /// Get color code for terminal
  static String _getColorCode(String color) {
    switch (color.toLowerCase()) {
      case 'red':
        return '\x1B[31m';
      case 'green':
        return '\x1B[32m';
      case 'yellow':
        return '\x1B[33m';
      case 'blue':
        return '\x1B[34m';
      case 'magenta':
        return '\x1B[35m';
      case 'cyan':
        return '\x1B[36m';
      case 'white':
        return '\x1B[37m';
      case 'gray':
        return '\x1B[90m';
      default:
        return '\x1B[37m';
    }
  }

  static const String _resetColor = '\x1B[0m';
}
