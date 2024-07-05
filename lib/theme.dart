import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4278203853),
      surfaceTint: Color(4283783826),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4292927743),
      onPrimaryContainer: Color(4279243851),
      secondary: Color(4283718290),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4292927743),
      onSecondaryContainer: Color(4279178315),
      tertiary: Color(4284634768),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4293385983),
      onTertiaryContainer: Color(4280160328),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      background: Color(4294703359),
      onBackground: Color(4279966497),
      surface: Color(4294703359),
      onSurface: Color(4279966497),
      surfaceVariant: Color(4293124588),
      onSurfaceVariant: Color(4282795599),
      outline: Color(4286019200),
      outlineVariant: Color(4291282384),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281348150),
      inverseOnSurface: Color(4294111223),
      inversePrimary: Color(4290691839),
      primaryFixed: Color(4292927743),
      onPrimaryFixed: Color(4279243851),
      primaryFixedDim: Color(4290691839),
      onPrimaryFixedVariant: Color(4282204793),
      secondaryFixed: Color(4292927743),
      onSecondaryFixed: Color(4279178315),
      secondaryFixedDim: Color(4290626303),
      onSecondaryFixedVariant: Color(4282204793),
      tertiaryFixed: Color(4293385983),
      onTertiaryFixed: Color(4280160328),
      tertiaryFixedDim: Color(4291608319),
      onTertiaryFixedVariant: Color(4283055734),
      surfaceDim: Color(4292598240),
      surfaceBright: Color(4294703359),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294308602),
      surfaceContainer: Color(4293979380),
      surfaceContainerHigh: Color(4293584879),
      surfaceContainerHighest: Color(4293190121),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  



  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4278203853),
      surfaceTint: Color(4290691839),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4282204793),
      onPrimaryContainer: Color(4292927743),
      secondary: Color(4290626303),
      onSecondary: Color(4280691553),
      secondaryContainer: Color(4282204793),
      onSecondaryContainer: Color(4292927743),
      tertiary: Color(4291608319),
      onTertiary: Color(4281542494),
      tertiaryContainer: Color(4283055734),
      onTertiaryContainer: Color(4293385983),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      background: Color(4279440152),
      onBackground: Color(4293190121),
      surface: Color(4279440152),
      onSurface: Color(4293190121),
      surfaceVariant: Color(4282795599),
      onSurfaceVariant: Color(4291282384),
      outline: Color(4287729818),
      outlineVariant: Color(4282795599),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293190121),
      inverseOnSurface: Color(4281348150),
      inversePrimary: Color(4283783826),
      primaryFixed: Color(4292927743),
      onPrimaryFixed: Color(4279243851),
      primaryFixedDim: Color(4290691839),
      onPrimaryFixedVariant: Color(4282204793),
      secondaryFixed: Color(4292927743),
      onSecondaryFixed: Color(4279178315),
      secondaryFixedDim: Color(4290626303),
      onSecondaryFixedVariant: Color(4282204793),
      tertiaryFixed: Color(4293385983),
      onTertiaryFixed: Color(4280160328),
      tertiaryFixedDim: Color(4291608319),
      onTertiaryFixedVariant: Color(4283055734),
      surfaceDim: Color(4279440152),
      surfaceBright: Color(4281940287),
      surfaceContainerLowest: Color(4279111187),
      surfaceContainerLow: Color(4279966497),
      surfaceContainer: Color(4280229669),
      surfaceContainerHigh: Color(4280953135),
      surfaceContainerHighest: Color(4281611322),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary, 
    required this.surfaceTint, 
    required this.onPrimary, 
    required this.primaryContainer, 
    required this.onPrimaryContainer, 
    required this.secondary, 
    required this.onSecondary, 
    required this.secondaryContainer, 
    required this.onSecondaryContainer, 
    required this.tertiary, 
    required this.onTertiary, 
    required this.tertiaryContainer, 
    required this.onTertiaryContainer, 
    required this.error, 
    required this.onError, 
    required this.errorContainer, 
    required this.onErrorContainer, 
    required this.background, 
    required this.onBackground, 
    required this.surface, 
    required this.onSurface, 
    required this.surfaceVariant, 
    required this.onSurfaceVariant, 
    required this.outline, 
    required this.outlineVariant, 
    required this.shadow, 
    required this.scrim, 
    required this.inverseSurface, 
    required this.inverseOnSurface, 
    required this.inversePrimary, 
    required this.primaryFixed, 
    required this.onPrimaryFixed, 
    required this.primaryFixedDim, 
    required this.onPrimaryFixedVariant, 
    required this.secondaryFixed, 
    required this.onSecondaryFixed, 
    required this.secondaryFixedDim, 
    required this.onSecondaryFixedVariant, 
    required this.tertiaryFixed, 
    required this.onTertiaryFixed, 
    required this.tertiaryFixedDim, 
    required this.onTertiaryFixedVariant, 
    required this.surfaceDim, 
    required this.surfaceBright, 
    required this.surfaceContainerLowest, 
    required this.surfaceContainerLow, 
    required this.surfaceContainer, 
    required this.surfaceContainerHigh, 
    required this.surfaceContainerHighest, 
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
