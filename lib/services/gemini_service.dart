import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dotenv/dotenv.dart';

/// Service for interacting with Gemini API
class GeminiService {
  static const String _baseUrl =
      'https://generativelanguage.googleapis.com/v1beta';

  final http.Client _client;
  final String _apiKey;

  GeminiService({http.Client? client, String? apiKey})
    : _client = client ?? http.Client(),
      _apiKey = apiKey ?? _getApiKeyFromEnv();

  /// Check internet connectivity
  Future<bool> checkConnectivity() async {
    try {
      final response = await _client
          .get(
            Uri.parse('https://www.google.com'),
            headers: {'Connection': 'close'},
          )
          .timeout(const Duration(seconds: 5));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  /// Generate translation for a single string to target language
  Future<String> translateString({
    required String text,
    required String targetLanguage,
    required String sourceLanguage,
  }) async {
    try {
      final prompt = _buildTranslationPrompt(
        text: text,
        targetLanguage: targetLanguage,
        sourceLanguage: sourceLanguage,
      );

      final response = await _client.post(
        Uri.parse(
          '$_baseUrl/models/gemini-2.0-flash-exp:generateContent?key=$_apiKey',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': prompt},
              ],
            },
          ],
          'generationConfig': {'temperature': 0.1, 'maxOutputTokens': 100},
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final candidates = data['candidates'] as List?;

        if (candidates != null && candidates.isNotEmpty) {
          final content = candidates[0]['content'];
          final parts = content['parts'] as List?;

          if (parts != null && parts.isNotEmpty) {
            return parts[0]['text']?.toString().trim() ?? text;
          }
        }

        throw Exception('Invalid response format from Gemini API');
      } else {
        throw Exception(
          'API request failed with status: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is SocketException) {
        throw Exception('No internet connection. Please check your network.');
      } else if (e is HttpException) {
        throw Exception('HTTP error occurred: ${e.message}');
      } else {
        throw Exception('Translation failed: ${e.toString()}');
      }
    }
  }

  String _buildTranslationPrompt({
    required String text,
    required String targetLanguage,
    required String sourceLanguage,
  }) {
    return '''
Translate the following text from $sourceLanguage to $targetLanguage.

Text to translate: "$text"

Requirements:
- Provide only the translated text
- Do not include any explanations or additional text
- Maintain the same tone and context
- If the text is a UI element, keep it concise and user-friendly

Translated text:''';
  }

  void dispose() {
    _client.close();
  }

  /// Get API key from environment variable or .env file
  static String _getApiKeyFromEnv() {
    const envKey = 'GEMINI_API_KEY';

    // Try to load .env file first
    try {
      final env = DotEnv(includePlatformEnvironment: true);
      env.load(['.env']);
    } catch (e) {
      // .env file not found, continue with system environment
    }

    // Check system environment variables first
    String? apiKey = Platform.environment[envKey];

    // If not found in system env, try .env file
    if (apiKey == null || apiKey.isEmpty) {
      try {
        final env = DotEnv(includePlatformEnvironment: true);
        env.load(['.env']);
        apiKey = env[envKey];
      } catch (e) {
        // .env file not found or couldn't be loaded
      }
    }

    if (apiKey == null || apiKey.isEmpty) {
      throw Exception(
        'GEMINI_API_KEY not found. Please set it using one of these methods:\n'
        '1. Environment variable: export GEMINI_API_KEY=your_api_key_here\n'
        '2. .env file: Create .env file in project root with GEMINI_API_KEY=your_api_key_here\n'
        '3. System environment: Set GEMINI_API_KEY in your shell profile',
      );
    }

    return apiKey;
  }
}
