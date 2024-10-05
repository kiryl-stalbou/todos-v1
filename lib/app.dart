// ignore_for_file: unused_element

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/constants/curves.dart';
import 'src/constants/durations.dart';
import 'src/l10n/s.dart';
import 'src/routing/auth/auth_router.dart';
import 'src/routing/todo/todo_router.dart';
import 'src/scopes/app/app_scope.dart';
import 'src/scopes/app/dependencies/auth/auth.dart';
import 'src/scopes/user/user_scope.dart';
import 'src/ui/_errors/uncaught_errors.dart';
import 'src/ui/_loading/global/global_loading.dart';
import 'theme.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({required this.uncaughtErrorsController, super.key});

  final StreamController<void> uncaughtErrorsController;

  @override
  Widget build(BuildContext context) => _WidgetsApp(
        uncaughtErrorsController: uncaughtErrorsController,
        // debugShowWidgetsInspector: true,
        child: AppScope(
          initialized: Auth(
            unauthenticated: const AuthRouter(),
            authenticated: (user) => UserScope(
              user: user,
              initialized: const TodoRouter(),
            ),
          ),
        ),
      );
}

class _WidgetsApp extends StatelessWidget {
  const _WidgetsApp({
    required this.child,
    required this.uncaughtErrorsController,
    this.debugShowWidgetsInspector = false,
    super.key,
  });

  final Widget child;
  final StreamController<void> uncaughtErrorsController;
  final bool debugShowWidgetsInspector;

  KeyEventResult _onKeyEvent(FocusNode node, KeyEvent event) {
    if ((event is! KeyDownEvent && event is! KeyRepeatEvent) || event.logicalKey != LogicalKeyboardKey.escape) {
      return KeyEventResult.ignored;
    }
    return Tooltip.dismissAllToolTips() ? KeyEventResult.handled : KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    Widget child = this.child;

    assert(() {
      if (debugShowWidgetsInspector) {
        child = WidgetInspector(
          selectButtonBuilder: (_, onPressed) => FloatingActionButton(
            onPressed: onPressed,
            child: const Icon(Icons.search),
          ),
          child: child,
        );
      }
      return true;
    }());

    return MediaQuery.withNoTextScaling(
      child: ScrollConfiguration(
        behavior: const MaterialScrollBehavior(),
        child: Focus(
          canRequestFocus: false,
          onKeyEvent: _onKeyEvent,
          child: Shortcuts(
            shortcuts: WidgetsApp.defaultShortcuts,
            child: DefaultTextEditingShortcuts(
              child: Actions(
                actions: <Type, Action<Intent>>{
                  ...WidgetsApp.defaultActions,
                  ScrollIntent: Action<ScrollIntent>.overridable(context: context, defaultAction: ScrollAction()),
                },
                child: TapRegionSurface(
                  child: TodoLocalizations(
                    child: TodoTheme(
                      child: UncaughtErrors(
                        controller: uncaughtErrorsController,
                        child: GlobalLoading(
                          child: Material(
                            type: MaterialType.transparency,
                            child: child,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TodoLocalizations extends StatefulWidget {
  const TodoLocalizations({required this.child, super.key});

  final Widget child;

  static void toggle(BuildContext context) {
    final state = context.getInheritedWidgetOfExactType<_TodoLocalizationsInheritedWidget>()?.state;

    if (state == null) throw Exception('Invalid context: missing _TodoLocalizationsInheritedWidget');

    state.toggleLocale();
  }

  @override
  State<TodoLocalizations> createState() => _TodoLocalizationsState();
}

class _TodoLocalizationsState extends State<TodoLocalizations> with WidgetsBindingObserver {
  late Locale _locale;

  void toggleLocale() {
    final index = 1 + S.supportedLocales.indexOf(_locale);
    setState(() => _locale = S.supportedLocales[index % S.supportedLocales.length]);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _locale = basicLocaleListResolution(WidgetsBinding.instance.platformDispatcher.locales, S.supportedLocales);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);
    final locale = basicLocaleListResolution(locales, S.supportedLocales);
    if (_locale != locale) setState(() => _locale = locale);
  }

  @override
  Widget build(BuildContext context) => _TodoLocalizationsInheritedWidget(
        state: this,
        child: Localizations(
          locale: _locale,
          delegates: S.localizationsDelegates,
          child: widget.child,
        ),
      );
}

class _TodoLocalizationsInheritedWidget extends InheritedWidget {
  const _TodoLocalizationsInheritedWidget({
    required super.child,
    required this.state,
    super.key,
  });

  final _TodoLocalizationsState state;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}

class TodoTheme extends StatefulWidget {
  const TodoTheme({required this.child, super.key});

  final Widget child;

  static void toggle(BuildContext context) {
    final state = context.getInheritedWidgetOfExactType<_TodoThemeInheritedWidget>()?.state;

    if (state == null) throw Exception('Invalid context: missing _TodoThemeInheritedWidget');

    state.toggleTheme();
  }

  @override
  State<TodoTheme> createState() => _TodoThemeState();
}

class _TodoThemeState extends State<TodoTheme> {
  ThemeMode? _themeMode;

  void toggleTheme() {
    _themeMode ??= MediaQuery.platformBrightnessOf(context) == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
    final mode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    setState(() => _themeMode = mode);
  }

  @override
  Widget build(BuildContext context) => _TodoThemeInheritedWidget(
        state: this,
        child: AnimatedTheme(
          data: AppTheme.resolveFor(context, _themeMode ?? ThemeMode.system),
          duration: AppDurations.themeChange,
          curve: AppCurves.themeChange,
          child: widget.child,
        ),
      );
}

class _TodoThemeInheritedWidget extends InheritedWidget {
  const _TodoThemeInheritedWidget({
    required super.child,
    required this.state,
    super.key,
  });

  final _TodoThemeState state;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
