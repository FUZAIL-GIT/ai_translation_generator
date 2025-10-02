/// AI Translation Generator - Main Library
///
/// This library provides a professional CLI tool for AI-powered translation generation
/// using Google's Gemini AI. It generates Flutter l10n compatible translation files
/// for multiple languages with a beautiful command-line interface.
///
/// ## Features
///
/// - Multi-language translation support
/// - Flutter l10n standard output format
/// - Professional CLI with progress indicators
/// - Secure API key management
/// - Environment variable support
///
/// ## Usage
///
/// ```bash
/// # Install globally
/// dart pub global activate ai_translation_generator
///
/// # Initialize configuration
/// aitranslation init
///
/// # Generate translations
/// aitranslation generate
/// ```
library;

// Export models
export 'models/translation_config.dart';

// Export services
export 'services/config_service.dart';
export 'services/gemini_service.dart';
export 'services/translation_service.dart';

// Export commands
export 'commands/init_command.dart';
export 'commands/generate_command.dart';

// Export utilities
export 'utils/cli_utils.dart';
