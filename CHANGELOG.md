# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.1] - 2024-12-19

### Fixed

- 🔧 Fixed executable configuration for `dart pub global activate`
- 📦 Added proper `executables` section in pubspec.yaml
- 🚀 CLI now accessible as `aitranslation` command after global activation

## [1.0.0] - 2024-12-19

### Added

- 🚀 Initial release of AI Translation Generator
- ✨ Professional CLI interface with beautiful terminal output
- 🌍 Multi-language translation support using Google Gemini AI
- 🔧 Flutter l10n standard output format (`lib/l10n/` directory)
- 🔐 Secure API key management with environment variables
- 📁 YAML-based configuration system
- 🎨 Progress indicators and loading animations
- 🌐 Internet connectivity checking
- ⚡ Fast and efficient translation processing
- 🛡️ Comprehensive error handling and validation
- 📖 Complete documentation and setup guides

### Features

- `aitranslation init` - Initialize configuration
- `aitranslation generate` - Generate translations
- Support for 100+ languages
- Environment variable and .env file support
- Professional CLI with colors and animations
- Flutter l10n compatible output

### Security

- No hardcoded API keys
- User-specific API key management
- Secure environment variable handling
- Local processing only

### Documentation

- Comprehensive README with setup instructions
- API key security guidelines
- Contributing guidelines
- MIT License
