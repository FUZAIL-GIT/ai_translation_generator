// Copyright (c) 2024 AI Translation Generator
// Licensed under the MIT License

/// Example usage of AI Translation Generator
///
/// This example demonstrates how to use the AI Translation Generator
/// to create Flutter l10n translation files programmatically.
///
/// ## Setup
///
/// 1. Set your Gemini API key:
///    ```bash
///    export GEMINI_API_KEY=your_gemini_api_key_here
///    ```
///
/// 2. Run this example:
///    ```bash
///    dart run example/example.dart
///    ```
library;

import 'dart:io';
import 'package:ai_translation_generator/ai_translation_generator.dart';

Future<void> main() async {
  print('🚀 AI Translation Generator Example');
  print('=====================================\n');

  try {
    // Create a sample configuration
    final config = TranslationConfig(
      languages: ['en', 'ar', 'es', 'fr'],
      strings: [
        'welcome',
        'settings',
        'profile',
        'logout',
        'search',
        'filter',
        'save',
        'cancel',
      ],
    );

    print('📋 Configuration:');
    print('Languages: ${config.languages.join(', ')}');
    print('Strings: ${config.strings.length} strings to translate\n');

    // Create services
    final geminiService = GeminiService();
    final translationService = TranslationService(
      geminiService: geminiService,
      config: config,
    );

    print('🔧 Services initialized successfully\n');

    // Check internet connectivity
    print('🌐 Checking internet connectivity...');
    final hasConnection = await geminiService.checkConnectivity();
    if (!hasConnection) {
      print('❌ No internet connection. Please check your network.');
      return;
    }
    print('✅ Internet connection verified\n');

    // Generate translations
    print('🔄 Generating translations...');
    final translations = await translationService.generateTranslations(
      onProgress: (message) {
        print('   $message');
      },
      onLanguageComplete: (message) {
        print('   ✅ $message');
      },
    );

    print('\n💾 Saving translation files...');
    await translationService.saveTranslations(translations);

    print('\n🎉 Translation generation completed!');
    print('📁 Generated files:');
    for (final language in config.languages) {
      print('   - lib/l10n/$language.json');
    }

    print('\n📖 Next steps:');
    print('1. Copy the generated files to your Flutter project');
    print('2. Configure your Flutter app for l10n');
    print('3. Use the translations in your app');
  } catch (e) {
    print('❌ Error: $e');
    print('\n💡 Make sure to set your GEMINI_API_KEY environment variable');
    print('   export GEMINI_API_KEY=your_gemini_api_key_here');
    exit(1);
  }
}
