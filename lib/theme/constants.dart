import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FondueSwapConstants {
  FondueSwapConstants(this.color);
  factory FondueSwapConstants.fromColor(Color color) {
    return FondueSwapConstants(color);
  }
  final Color color;

  TextStyle get kRoboto22 => GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 22,
          color: color,
          fontWeight: FontWeight.w600,
          height: 26 / 22,
        ),
      );
  TextStyle get kRoboto16 => GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 16,
          color: color,
          fontWeight: FontWeight.w400,
          height: 20 / 16,
        ),
      );

  TextStyle get kRoboto18 => GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 18,
          color: color,
          fontWeight: FontWeight.w400,
          height: 20 / 16,
        ),
      );

  TextStyle get kRoboto14 => GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 14,
          color: color,
          fontWeight: FontWeight.w400,
          height: 20 / 14,
        ),
      );

  TextStyle get kRoboto12 => GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.w400,
          height: 20 / 14,
        ),
      );

  TextStyle get kRoboto10 => GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.w400,
          height: 14 / 10,
        ),
      );
}
