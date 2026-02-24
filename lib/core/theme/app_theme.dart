import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract class AppTheme {
  static ThemeData appTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.primaryColor,
    useMaterial3: true,
    primaryColor: AppColors.primaryColor,
    textTheme: GoogleFonts.robotoTextTheme().copyWith(
      titleLarge: GoogleFonts.roboto(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      titleTextStyle: GoogleFonts.roboto(
        fontWeight: FontWeight.w400,
        color: AppColors.yellow,
        fontSize: 16,
      ),
    ),

  );
}
