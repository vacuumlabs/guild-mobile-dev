# flutter_bank_sample

Sample Flutter project to showcase most of basic flutter application principles.

As this is demo/sample project, it provides guidelines to follow when starting with new Flutter application.
All parts are open to discussion and further improvement.

## Getting Started

This project is a starting point for future VL Flutter developers.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Architecture

Application is divided into:
- repositories (elementary operation over data, no business logic should be present)
- main project (uses repositories to construct business logic and present it to user)

## Directory structure

Repositories belong to "./packages/'your_repo_name'".

Assets belong to "./assets/".

Core of project is located in "./lib" directory.

### Directory structure of core project

- main.dart (entry point to app)
- app.dart (theme setup for app)
- other global classes can be located in root "./lib"
- "./lib/src/extension" contains all extension definitions
- "./lib/src/theme" contains all theming classes (dark, light, or other utilities)
- "./lib/src/features" contains all features of app

### Feature directory structure

- "./lib/src/features/your_feature" is root for all classes of your feature
- "./lib/src/features/your_feature/your_feature_flow.dart" contains root navigation of your feature
- "./lib/src/features/your_feature/bloc" contains Bloc business logic for your navigation flow
- "./lib/src/features/your_feature/models" contains data objects of your feature
- "./lib/src/features/your_feature/view" contains common UI elements of your feature

Same structure is also applied for nested features (except flow can be replaced directly with page or view).
All parts are optional, so not every feature should contains all part from directory structure. But if applicable,
structure should be maintained in consistent matter instead of creating new patterns.
