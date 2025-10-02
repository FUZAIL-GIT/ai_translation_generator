/// Configuration model for AI Translation Generator
class TranslationConfig {
  final List<String> languages;
  final List<String> strings;

  const TranslationConfig({required this.languages, required this.strings});

  factory TranslationConfig.fromMap(Map<String, dynamic> map) {
    return TranslationConfig(
      languages: List<String>.from(map['languages'] ?? []),
      strings: List<String>.from(map['strings'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {'languages': languages, 'strings': strings};
  }

  factory TranslationConfig.defaultConfig() {
    return const TranslationConfig(
      languages: ['en', 'ar'],
      strings: ['settings', 'home', 'profile', 'logout'],
    );
  }

  bool get isValid {
    return languages.isNotEmpty && strings.isNotEmpty;
  }

  @override
  String toString() {
    return 'TranslationConfig(languages: $languages, strings: $strings)';
  }
}
