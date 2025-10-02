# AI Translation Generator Example

This example demonstrates how to use the AI Translation Generator programmatically to create Flutter l10n translation files.

## Prerequisites

1. **Set up your Gemini API key:**

   ```bash
   export GEMINI_API_KEY=your_gemini_api_key_here
   ```

2. **Get your API key from:**
   - Visit [Google AI Studio](https://makersuite.google.com/app/apikey)
   - Create a free account
   - Generate an API key

## Running the Example

```bash
# Run the example
dart run example/example.dart
```

## What This Example Does

1. **Creates a sample configuration** with multiple languages and strings
2. **Initializes the translation services** (Gemini API, config, translation)
3. **Checks internet connectivity** before proceeding
4. **Generates translations** for all configured languages
5. **Saves the results** to `lib/l10n/` directory
6. **Shows the generated files** and next steps

## Expected Output

```
🚀 AI Translation Generator Example
=====================================

📋 Configuration:
Languages: en, ar, es, fr
Strings: 8 strings to translate

🔧 Services initialized successfully

🌐 Checking internet connectivity...
✅ Internet connection verified

🔄 Generating translations...
   Generating en translation...
   ✅ en translation generated successfully
   Generating ar translation...
   ✅ ar translation generated successfully
   Generating es translation...
   ✅ es translation generated successfully
   Generating fr translation...
   ✅ fr translation generated successfully

💾 Saving translation files...

🎉 Translation generation completed!
📁 Generated files:
   - lib/l10n/en.json
   - lib/l10n/ar.json
   - lib/l10n/es.json
   - lib/l10n/fr.json

📖 Next steps:
1. Copy the generated files to your Flutter project
2. Configure your Flutter app for l10n
3. Use the translations in your app
```

## Generated Files

The example creates Flutter l10n compatible JSON files:

**lib/l10n/ar.json:**

```json
{
  "welcome": "مرحباً",
  "settings": "إعدادات",
  "profile": "الملف الشخصي",
  "logout": "تسجيل الخروج",
  "search": "بحث",
  "filter": "تصفية",
  "save": "حفظ",
  "cancel": "إلغاء"
}
```

**lib/l10n/es.json:**

```json
{
  "welcome": "bienvenido",
  "settings": "configuración",
  "profile": "perfil",
  "logout": "cerrar sesión",
  "search": "buscar",
  "filter": "filtrar",
  "save": "guardar",
  "cancel": "cancelar"
}
```

## Integration with Flutter

To use these translations in your Flutter app:

1. **Copy the generated files** to your Flutter project's `lib/l10n/` directory
2. **Configure your `pubspec.yaml`:**

   ```yaml
   dependencies:
     flutter_localizations:
       sdk: flutter

   flutter:
     generate: true
   ```

3. **Create `l10n.yaml`:**

   ```yaml
   arb-dir: lib/l10n
   template-arb-file: en.json
   output-localization-file: app_localizations.dart
   ```

4. **Use in your widgets:**

   ```dart
   import 'package:flutter_gen/gen_l10n/app_localizations.dart';

   Text(AppLocalizations.of(context)!.welcome)
   ```

## Troubleshooting

**API Key Issues:**

- Make sure `GEMINI_API_KEY` is set correctly
- Verify the API key is valid and active
- Check your internet connection

**Translation Issues:**

- Some languages may not be supported
- Check the Gemini API documentation for supported languages
- Verify your API key has sufficient quota

## Learn More

- [AI Translation Generator Documentation](https://pub.dev/packages/ai_translation_generator)
- [Flutter Internationalization](https://docs.flutter.dev/development/accessibility-and-localization/internationalization)
- [Google Gemini AI](https://ai.google.dev/)
