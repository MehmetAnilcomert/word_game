# Clean Architecture & Refactor Patterns - Flutter

This document outlines the modern architectural patterns implemented in this project, designed for scalability, type-safety, and clean separation of concerns. This guide serves as a reference for both developers and AI agents for future development.

## 1. Application Lifecycle & Initialization

To keep `main.dart` clean and maintainable, initialization logic is encapsulated in the `ProductInitialize` class.

### [ProductInitialize](file:///c:/repos/word_game/lib/product/init/product_initialize.dart)
Responsible for starting core services (Firebase, EasyLocalization, System Configurations) and Setting up the DI container.

**Example `main.dart`:**
```dart
Future<void> main() async {
  await ProductInitialize().startApplication();
  runApp(
    ProductLocalization(
      child: const StateInitialize(
        child: WordArenaApp(),
      ),
    ),
  );
}
```

---

## 2. Dependency Injection (DI)

We use `GetIt` for service location, wrapped in a specialized `ProductContainer` class for easier access.

### [ProductContainer](file:///c:/repos/word_game/lib/product/state/container/product_state_container.dart)
- **Static Setup**: Centralized registration of services.
- **Type-Safe Access**: Uses `ProductContainer.read<T>()`.

**Implementation Pattern:**
```dart
static void setUp() {
  _getIt.registerLazySingleton<GameService>(
    () => GameService(firestore: FirebaseFirestore.instance),
  );
}
// Usage in code
final service = ProductContainer.read<GameService>();
```

---

## 3. Localization Architecture

The project uses `EasyLocalization` with a centralized, type-safe management layer.

### [Locales Enum](file:///c:/repos/word_game/lib/product/utility/constants/enums/locales.dart)
Centralizes supported languages.
```dart
enum Locales {
  tr(Locale('tr')),
  en(Locale('en'));
  final Locale locale;
  const Locales(this.locale);
}
```

### [ProductLocalization](file:///c:/repos/word_game/lib/product/init/product_localization.dart)
A wrapper widget that provides the static `updateLang` method to standardize language switching.
- **Usage**: `ProductLocalization.updateLang(context: context, locale: Locales.en);`
- **Key Access**: Use generated `LocaleKeys.keyName.tr()`.

---

## 4. Theme & Color Management

We utilize `ThemeExtension` to provide semantic, theme-aware colors beyond the standard `ColorScheme`.

### [AppColorsExtension](file:///c:/repos/word_game/lib/product/init/theme/app_colors_extension.dart)
Defines custom semantic colors (e.g., `goldColor`, `successColor`).

### [AppThemeExtension](file:///c:/repos/word_game/lib/product/init/theme/app_theme_extension.dart)
Provides easy access via `BuildContext`.
- **Usage**: `context.appColors.successColor` or `context.colorScheme.primary`.

**Rule**: **Never** use hardcoded `Colors.xxx` or `Color(0x...)` in UI widgets. Always use `context.colorScheme` or `context.appColors`.

---

## 5. MVVM Feature Development Pattern

Features are structured to isolate UI, logic, and sub-widgets.

### Atomic Widget Structure
Use `part` and `part of` to split a view into smaller, manageable private widgets.
- **[HomeView](file:///c:/repos/word_game/lib/feature/home/view/home_view.dart)**: The main file containing the scaffold and part declarations.
- **[HomeTitle](file:///c:/repos/word_game/lib/feature/home/view/widget/home_title.dart)**: A private atomic widget (`part of '../home_view.dart'`).

### Logic Separation (Mixin)
UI-specific logic (controllers, animations, focus nodes) is moved into a `Mixin`.
- **Pattern**: `class _HomeViewState extends BaseState<HomeView> with HomeViewMixin`
- Allows logic to be tested and kept separate from the `build` method.

### Base Classes
- **BaseState**: Provides common utilities to all view states.
- **BaseViewModel**: Base for BLoC/ViewModel logic (if applicable).

---

## Summary for AI Agents
When refactoring or adding a new feature:
1. **Locate Keys**: Add new strings to `langs/*.json` and regenerate `LocaleKeys`.
2. **Colors**: If a color is non-standard, add it to `AppColorsExtension`.
3. **Structure**: Create a `view/` folder, use `part/part of` for sub-widgets, and a `mixin/` for UI logic.
4. **DI**: Register services in `ProductContainer`.

---

## 6. Navigation Management

For large-scale apps, we use `auto_route` to handle navigation in a declarative, type-safe, and centralized manner.

### Router Configuration
Route definitions are centralized in the `AppRouter` class.
- **[AppRouter](file:///c:/repos/flutter-architecture/lib/product/navigation/app_router.dart)**: Defines all application routes.

**Implementation:**
```dart
@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(page: HomeDetailRoute.page),
  ];
}
```

### Route Registration
Feature views must be annotated with `@RoutePage()` to be recognized by the generator.
```dart
@RoutePage()
class HomeView extends StatefulWidget { ... }
```

### Usage in Widgets
Navigation is performed via the `context` using generated route classes.
- **Dynamic Navigation**: `context.pushRoute(HomeDetailRoute(title: 'Detail'))`
- **Integration**: In `main.dart`, we use `MaterialApp.router` with `_appRouter.config()`.

### Benefits
- **Type-Safety**: Parameters are passed via constructor arguments in generated classes.
- **Deep Linking**: Built-in support for URL-based navigation.
- **Modularization**: Routes are defined independently of the widget tree.
