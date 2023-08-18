import 'package:flutter/material.dart';
import 'package:fondue_swap/theme/colors.dart';

@immutable
class FondueSwapTheme extends ThemeExtension<FondueSwapTheme> {
  const FondueSwapTheme(
      {required this.midnightBlack,
      required this.graphite,
      required this.mistyLavender,
      required this.goldenSunset,
      required this.deepAuburn,
      required this.cherryRed,
      required this.stormyNight,
      required this.forestGreen});

  final Color midnightBlack;
  final Color graphite;
  final Color mistyLavender;
  final Color goldenSunset;
  final Color deepAuburn;
  final Color cherryRed;
  final Color stormyNight;
  final Color forestGreen;
  @override
  ThemeExtension<FondueSwapTheme> copyWith({
    Color? midnightBlack,
    Color? graphite,
    Color? mistyLavender,
    Color? goldenSunset,
    Color? deepAuburn,
    Color? cherryRed,
    Color? stormyNight,
    Color? forestGreen,
  }) {
    return FondueSwapTheme(
      midnightBlack: midnightBlack ?? this.midnightBlack,
      graphite: graphite ?? this.graphite,
      mistyLavender: mistyLavender ?? this.mistyLavender,
      goldenSunset: goldenSunset ?? this.goldenSunset,
      deepAuburn: deepAuburn ?? this.deepAuburn,
      cherryRed: cherryRed ?? this.cherryRed,
      stormyNight: stormyNight ?? this.stormyNight,
      forestGreen: forestGreen ?? this.forestGreen,
    );
  }

  static const dark = FondueSwapTheme(
    midnightBlack: FondueSwapColor.midnightBlack,
    graphite: FondueSwapColor.graphite,
    mistyLavender: FondueSwapColor.mistyLavender,
    goldenSunset: FondueSwapColor.goldenSunset,
    deepAuburn: FondueSwapColor.deepAuburn,
    cherryRed: FondueSwapColor.cherryRed,
    stormyNight: FondueSwapColor.stormyNight,
    forestGreen: FondueSwapColor.forestGreen,
  );

  @override
  ThemeExtension<FondueSwapTheme> lerp(
      covariant ThemeExtension<FondueSwapTheme>? other, double t) {
    // TODO: implement lerp
    throw UnimplementedError();
  }
}
