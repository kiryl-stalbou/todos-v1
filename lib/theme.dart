import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/constants/colors.dart';
import 'src/constants/fonts.dart';
import 'src/constants/sizes.dart';

void resolveSystemUiOverlayStyle(ThemeData theme, [Color? color]) {
  if (kIsWeb) return;

  final resolvedColor = color ?? theme.colorScheme.surface;
  final oppositeBrightness = theme.brightness == Brightness.light ? Brightness.dark : Brightness.light;
  final resolvedBrightness = Platform.isIOS ? theme.brightness : oppositeBrightness;

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: resolvedColor,
      systemNavigationBarColor: resolvedColor,
      systemNavigationBarDividerColor: resolvedColor,
      statusBarBrightness: resolvedBrightness,
      statusBarIconBrightness: resolvedBrightness,
      systemNavigationBarIconBrightness: resolvedBrightness,
    ),
  );
}

abstract final class AppTheme {
  static ThemeData resolveFor(BuildContext context, ThemeMode mode) {
    final theme = switch (mode) {
      ThemeMode.dark => _buildFor(Brightness.dark),
      ThemeMode.light => _buildFor(Brightness.light),
      ThemeMode.system => _buildFor(MediaQuery.platformBrightnessOf(context)),
    };

    resolveSystemUiOverlayStyle(theme);

    return theme;
  }

  static ThemeData _buildFor(Brightness brightness) {
    final colorScheme = _colorSchemeFor(brightness);
    final textTheme = _textThemeFor(colorScheme);
    return _themeFor(colorScheme, textTheme);
  }
}

ColorScheme _colorSchemeFor(Brightness brightness) => brightness == Brightness.light
    ? const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.green,
        onPrimary: AppColors.white,
        primaryContainer: AppColors.green42,
        onPrimaryContainer: AppColors.black,
        secondary: AppColors.blue,
        onSecondary: AppColors.black,
        secondaryContainer: AppColors.blue,
        onSecondaryContainer: AppColors.black,
        tertiary: Color.fromARGB(235, 147, 146, 143),
        onTertiary: AppColors.black,
        tertiaryContainer: AppColors.beige,
        onTertiaryContainer: AppColors.black,
        error: AppColors.red,
        onError: AppColors.white,
        errorContainer: AppColors.red8,
        onErrorContainer: AppColors.red,
        background: AppColors.beige,
        onBackground: AppColors.black,
        surface: AppColors.white,
        onSurface: AppColors.black,
        surfaceTint: AppColors.white,
        onSurfaceVariant: AppColors.black,
        surfaceVariant: AppColors.grey,
        outline: AppColors.grey,
        outlineVariant: AppColors.black26,
        shadow: AppColors.black38,
      )
    : const ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.green,
        onPrimary: AppColors.white,
        primaryContainer: AppColors.green42,
        onPrimaryContainer: AppColors.white,
        secondary: AppColors.blue,
        onSecondary: AppColors.black,
        secondaryContainer: AppColors.blue,
        onSecondaryContainer: AppColors.white,
        tertiary: Color.fromARGB(235, 147, 146, 143),
        onTertiary: AppColors.black,
        tertiaryContainer: Color(0xFF5A5A5A),
        onTertiaryContainer: AppColors.white,
        error: Color.fromARGB(255, 235, 37, 23),
        onError: AppColors.white,
        errorContainer: AppColors.red8,
        onErrorContainer: AppColors.red,
        background: AppColors.beige,
        onBackground: AppColors.black,
        surface: Color(0xff292929),
        onSurface: AppColors.white,
        surfaceTint: AppColors.white,
        onSurfaceVariant: AppColors.white,
        surfaceVariant: AppColors.grey,
        outline: AppColors.grey,
        outlineVariant: AppColors.grey,
        shadow: AppColors.black38,
      );

TextTheme _textThemeFor(ColorScheme colorScheme) => TextTheme(
      displayLarge: TextStyle(
        fontFamily: FontFamily.omnes,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w900,
        fontSize: FontSize.s48,
      ),
      displayMedium: TextStyle(
        fontFamily: FontFamily.omnes,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w900,
        fontSize: FontSize.s40,
      ),
      displaySmall: TextStyle(
        fontFamily: FontFamily.omnes,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w900,
        fontSize: FontSize.s38,
      ),
      headlineLarge: TextStyle(
        fontFamily: FontFamily.omnes,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w800,
        fontSize: FontSize.s38,
      ),
      headlineMedium: TextStyle(
        fontFamily: FontFamily.omnes,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w800,
        fontSize: FontSize.s34,
      ),
      headlineSmall: TextStyle(
        fontFamily: FontFamily.omnes,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w800,
        fontSize: FontSize.s24,
      ),
      titleLarge: TextStyle(
        fontFamily: FontFamily.omnes,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w700,
        fontSize: FontSize.s30,
      ),
      titleMedium: TextStyle(
        fontFamily: FontFamily.omnes,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w700,
        fontSize: FontSize.s22,
      ),
      titleSmall: TextStyle(
        fontFamily: FontFamily.omnes,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w700,
        fontSize: FontSize.s18,
      ),
      bodyLarge: TextStyle(
        fontFamily: FontFamily.omnes,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w500,
        fontSize: FontSize.s20,
      ),
      bodyMedium: TextStyle(
        fontFamily: FontFamily.omnes,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w500,
        fontSize: FontSize.s16,
      ),
      bodySmall: TextStyle(
        fontFamily: FontFamily.omnes,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w500,
        fontSize: FontSize.s14,
      ),
      labelLarge: TextStyle(
        fontFamily: FontFamily.omnes,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w400,
        fontSize: FontSize.s18,
      ),
      labelMedium: TextStyle(
        fontFamily: FontFamily.omnes,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w400,
        fontSize: FontSize.s16,
      ),
      labelSmall: TextStyle(
        fontFamily: FontFamily.omnes,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w400,
        fontSize: FontSize.s13,
      ),
    );

ThemeData _themeFor(ColorScheme colorScheme, TextTheme textTheme) => ThemeData(
      useMaterial3: true,
      textTheme: textTheme,
      colorScheme: colorScheme,
      shadowColor: colorScheme.shadow,
      scaffoldBackgroundColor: colorScheme.surface,
      focusColor: const Color.fromARGB(161, 158, 158, 158),
      splashColor: const Color.fromARGB(161, 158, 158, 158),
      highlightColor: const Color.fromARGB(161, 158, 158, 158),
      iconTheme: IconThemeData(
        color: colorScheme.onSurface,
        size: Insets.xl,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: colorScheme.primary,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colorScheme.primary,
        selectionHandleColor: colorScheme.primary,
        selectionColor: colorScheme.primaryContainer,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        labelStyle: textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
        ),
        hintStyle: textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface.withOpacity(0.5),
        ),
        errorStyle: const TextStyle(fontSize: 0),
        helperStyle: const TextStyle(fontSize: 0),
        counterStyle: const TextStyle(fontSize: 0),
      ),
      scrollbarTheme: const ScrollbarThemeData(
        interactive: true,
        thumbVisibility: MaterialStatePropertyAll(true),
        trackVisibility: MaterialStatePropertyAll(true),
      ),
      appBarTheme: AppBarTheme(
        scrolledUnderElevation: 16,
        toolbarHeight: kToolbarHeight,
        shadowColor: colorScheme.shadow,
        backgroundColor: colorScheme.surface,
        surfaceTintColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.transparent,
        elevation: 0,
      ),
      badgeTheme: const BadgeThemeData(
        textStyle: TextStyle(height: 1, fontSize: FontSize.s12),
      ),
      navigationRailTheme: NavigationRailThemeData(
        minWidth: 120,
        backgroundColor: colorScheme.surface,
        indicatorColor: colorScheme.primaryContainer,
        indicatorShape: const StadiumBorder(),
        selectedLabelTextStyle: textTheme.bodySmall?.copyWith(height: 1, fontSize: FontSize.s14),
        unselectedLabelTextStyle: textTheme.bodySmall?.copyWith(height: 1, fontSize: FontSize.s14),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 60,
        shadowColor: colorScheme.shadow,
        backgroundColor: colorScheme.surface,
        surfaceTintColor: colorScheme.surfaceTint,
        indicatorColor: colorScheme.primaryContainer,
        indicatorShape: const StadiumBorder(),
        overlayColor: const MaterialStatePropertyAll(AppColors.transparent),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        labelTextStyle: MaterialStatePropertyAll(textTheme.bodySmall?.copyWith(height: 1, fontSize: FontSize.s12)),
        iconTheme: MaterialStatePropertyAll(IconThemeData(size: IconSize.m, color: colorScheme.onPrimaryContainer)),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: colorScheme.surface,
        titleTextStyle: textTheme.titleMedium?.copyWith(height: 1.2),
        contentTextStyle: textTheme.bodySmall,
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
      ),
      checkboxTheme: CheckboxThemeData(
        shape: const CircleBorder(),
        materialTapTargetSize: MaterialTapTargetSize.padded,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        side: BorderSide(color: colorScheme.onSurface, width: 1),
      ),
    );
