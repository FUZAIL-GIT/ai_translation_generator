# Contributing to AI Translation Generator

Thank you for your interest in contributing to AI Translation Generator! We welcome contributions from the community.

## 🚀 Getting Started

### Prerequisites

- Dart SDK 3.8.1 or higher
- Git
- A GitHub account

### Development Setup

1. **Fork the repository**

   ```bash
   # Fork on GitHub, then clone your fork
   git clone https://github.com/your-username/ai_translation_generator.git
   cd ai_translation_generator
   ```

2. **Install dependencies**

   ```bash
   dart pub get
   ```

3. **Set up your environment**

   ```bash
   # Create .env file with your Gemini API key
   echo "GEMINI_API_KEY=your_api_key_here" > .env
   ```

4. **Run tests**
   ```bash
   dart test
   ```

## 🛠️ Development Workflow

### Making Changes

1. **Create a feature branch**

   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**

   - Write clean, well-documented code
   - Follow the existing code style
   - Add tests for new functionality

3. **Test your changes**

   ```bash
   dart test
   dart analyze
   dart format .
   ```

4. **Test the CLI**
   ```bash
   dart run bin/ai_translation_generator.dart init
   dart run bin/ai_translation_generator.dart generate
   ```

### Code Style

- Follow Dart's official style guide
- Use meaningful variable and function names
- Add documentation for public APIs
- Keep functions small and focused
- Use proper error handling

### Testing

- Write unit tests for new functionality
- Test edge cases and error conditions
- Ensure all tests pass before submitting

## 📝 Submitting Changes

### Pull Request Process

1. **Update CHANGELOG.md**

   - Add your changes to the appropriate version section
   - Follow the existing format

2. **Create a Pull Request**

   - Use a clear, descriptive title
   - Describe what your changes do
   - Reference any related issues

3. **PR Template**

   ```markdown
   ## Description

   Brief description of changes

   ## Type of Change

   - [ ] Bug fix
   - [ ] New feature
   - [ ] Breaking change
   - [ ] Documentation update

   ## Testing

   - [ ] Tests pass locally
   - [ ] CLI tested manually
   - [ ] No breaking changes

   ## Checklist

   - [ ] Code follows style guidelines
   - [ ] Self-review completed
   - [ ] Documentation updated
   - [ ] CHANGELOG.md updated
   ```

## 🐛 Reporting Issues

### Bug Reports

When reporting bugs, please include:

- **Description**: Clear description of the issue
- **Steps to Reproduce**: Detailed steps to reproduce the bug
- **Expected Behavior**: What you expected to happen
- **Actual Behavior**: What actually happened
- **Environment**: OS, Dart version, package version
- **Logs**: Any relevant error messages or logs

### Feature Requests

For feature requests, please include:

- **Use Case**: Why this feature would be useful
- **Proposed Solution**: How you think it should work
- **Alternatives**: Other solutions you've considered
- **Additional Context**: Any other relevant information

## 🏗️ Project Structure

```
lib/
├── models/           # Data models
├── services/         # Business logic
├── commands/         # CLI commands
└── utils/            # Utility functions

bin/                  # CLI entry point
test/                 # Unit tests
```

## 📋 Areas for Contribution

### High Priority

- [ ] Additional AI model support (OpenAI, Claude)
- [ ] Performance optimizations
- [ ] Better error messages
- [ ] More language support

### Medium Priority

- [ ] VS Code extension
- [ ] Web interface
- [ ] Batch processing improvements
- [ ] Custom prompt templates

### Low Priority

- [ ] Documentation improvements
- [ ] Additional test coverage
- [ ] Code refactoring
- [ ] Performance monitoring

## 🤝 Code of Conduct

### Our Pledge

We are committed to providing a welcoming and inspiring community for all. We pledge to respect all people who contribute through reporting issues, posting feature requests, updating documentation, submitting pull requests or patches, and other activities.

### Our Standards

- Use welcoming and inclusive language
- Be respectful of differing viewpoints and experiences
- Gracefully accept constructive criticism
- Focus on what is best for the community
- Show empathy towards other community members

## 📞 Getting Help

- 💬 [GitHub Discussions](https://github.com/your-username/ai_translation_generator/discussions)
- 🐛 [GitHub Issues](https://github.com/your-username/ai_translation_generator/issues)
- 📧 Email: your-email@example.com

## 🙏 Recognition

Contributors will be recognized in:

- README.md contributors section
- CHANGELOG.md for significant contributions
- Release notes for major contributions

Thank you for contributing to AI Translation Generator! 🎉
