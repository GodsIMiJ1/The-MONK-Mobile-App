# Contributing to The MONK Mobile

![GodsIMiJ AI Solutions](https://www.godsimij-ai-solutions.com/logo.png)

Thank you for your interest in contributing to The MONK Mobile! This document provides guidelines and instructions for contributing to this project.

Developed by [GodsIMiJ AI Solutions](https://www.godsimij-ai-solutions.com)

## Code of Conduct

By participating in this project, you agree to abide by our Code of Conduct. Please be respectful, inclusive, and considerate in all interactions.

## How to Contribute

### Reporting Bugs

If you find a bug, please create an issue with the following information:

1. A clear, descriptive title
2. Steps to reproduce the issue
3. Expected behavior
4. Actual behavior
5. Screenshots (if applicable)
6. Device information (Android version, device model)
7. Any additional context

### Suggesting Features

We welcome feature suggestions! To suggest a feature:

1. Check existing issues to avoid duplicates
2. Create a new issue with the "Feature Request" label
3. Clearly describe the feature and its benefits
4. Provide any relevant examples or mockups

### Pull Requests

We actively welcome pull requests:

1. Fork the repository
2. Create a new branch from `main`
3. Make your changes
4. Ensure tests pass
5. Submit a pull request

#### Pull Request Process

1. Update the README.md or documentation with details of changes if needed
2. Update the CHANGELOG.md with details of changes
3. The PR will be merged once it has been reviewed and approved

## Development Setup

Please refer to the [Setup Guide](docs/SETUP_GUIDE.md) for detailed instructions on setting up the development environment.

## Coding Standards

### Kotlin Style Guide

We follow the official [Kotlin Coding Conventions](https://kotlinlang.org/docs/coding-conventions.html) with the following additions:

- Use meaningful variable and function names
- Keep functions small and focused
- Add comments for complex logic
- Use extension functions where appropriate

### Compose UI Guidelines

For Jetpack Compose code:

- Follow the [Compose API Guidelines](https://github.com/androidx/androidx/blob/androidx-main/compose/docs/compose-api-guidelines.md)
- Use Material Design components when possible
- Extract reusable composables
- Keep composable functions pure and stateless when possible
- Use proper naming: `SomeScreen`, `SomeComponent`, etc.

### Architecture Guidelines

- Follow MVVM architecture pattern
- Use Clean Architecture principles
- Keep UI logic in ViewModels
- Use repositories for data operations
- Use use cases for business logic

## Testing

All code should be tested:

- Unit tests for ViewModels, repositories, and use cases
- UI tests for critical user flows
- Integration tests for data layer components

## Git Workflow

We use a simplified Git flow:

1. `main` branch contains stable code
2. Feature branches are created from `main`
3. Pull requests are merged back to `main`
4. Use descriptive branch names: `feature/journal-entry-screen`, `fix/sync-issue`

### Commit Messages

Follow these guidelines for commit messages:

- Use the present tense ("Add feature" not "Added feature")
- Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
- Limit the first line to 72 characters
- Reference issues and pull requests after the first line
- Consider using the following format:
  ```
  feat: Add journal entry search functionality

  - Implement search by title and content
  - Add search history
  - Optimize search performance

  Fixes #123
  ```

## Release Process

1. Version numbers follow [Semantic Versioning](https://semver.org/)
2. Releases are created from the `main` branch
3. Release notes are generated from commit messages
4. Beta releases are available through Google Play Beta Program

## Documentation

- Update documentation when changing functionality
- Document public APIs and complex internal components
- Keep the README.md up to date
- Add code comments for complex logic

## Community

Join our community:

- Website: [www.godsimij-ai-solutions.com](https://www.godsimij-ai-solutions.com)
- Email: [james@godsimij-ai-solutions.com](mailto:james@godsimij-ai-solutions.com)

## License

By contributing, you agree that your contributions will be licensed under the project's MIT License.

---

© 2023 GodsIMiJ AI Solutions. All rights reserved.
