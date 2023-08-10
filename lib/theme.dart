import 'package:flutter/material.dart';

class AppTheme {
  static FontSizes fontSizes = FontSizes();
  static Headers headers = Headers();
}

class FontSizes {
  final double xs = 12;
  final double sm = 14;
  final double base = 16;
  final double lg = 18;
  final double xl = 20;
  final double xxl = 24;
  final double xxxl = 30;
  final double xxxxl = 36;

  TextStyle get xsStyle => TextStyle(fontSize: xs);
  TextStyle get smStyle => TextStyle(fontSize: sm);
  TextStyle get baseStyle => TextStyle(fontSize: base);
  TextStyle get lgStyle => TextStyle(fontSize: lg);
  TextStyle get xlStyle => TextStyle(fontSize: xl);
  TextStyle get xxlStyle => TextStyle(fontSize: xxl);
  TextStyle get xxxlStyle => TextStyle(fontSize: xxxl);
  TextStyle get xxxxlStyle => TextStyle(fontSize: xxxxl);
}

class Headers {
  final fontSizes = FontSizes();

  TextStyle get headerSm =>
      fontSizes.smStyle.copyWith(fontWeight: FontWeight.w600);
  TextStyle get headerBase =>
      fontSizes.baseStyle.copyWith(fontWeight: FontWeight.w700);
  TextStyle get headerLg =>
      fontSizes.lgStyle.copyWith(fontWeight: FontWeight.w700);
  TextStyle get headerXl =>
      fontSizes.xlStyle.copyWith(fontWeight: FontWeight.w700);
}
