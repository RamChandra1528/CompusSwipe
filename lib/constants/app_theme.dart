import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFFFF6B6B);
  static const Color secondaryColor = Color(0xFF4ECDC4);
  static const Color accentColor = Color(0xFF45B7D1);
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color surfaceColor = Colors.white;
  static const Color errorColor = Color(0xFFE74C3C);
  static const Color successColor = Color(0xFF27AE60);
  static const Color warningColor = Color(0xFFF39C12);
  
  // Dark theme colors
  static const Color darkBackgroundColor = Color(0xFF121212);
  static const Color darkSurfaceColor = Color(0xFF1E1E1E);
  static const Color darkPrimaryColor = Color(0xFFFF8A80);

  // Text styles
  static TextStyle get headingStyle => GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      );

  static TextStyle get subheadingStyle => GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      );

  static TextStyle get bodyStyle => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.black87,
      );

  static TextStyle get captionStyle => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Colors.black54,
      );

  // Light theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        error: errorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.black87,
        onError: Colors.white,
      ),
      textTheme: TextTheme(
        headlineLarge: headingStyle.copyWith(fontSize: 32),
        headlineMedium: headingStyle.copyWith(fontSize: 28),
        headlineSmall: headingStyle.copyWith(fontSize: 24),
        titleLarge: subheadingStyle.copyWith(fontSize: 22),
        titleMedium: subheadingStyle.copyWith(fontSize: 18),
        titleSmall: subheadingStyle.copyWith(fontSize: 16),
        bodyLarge: bodyStyle.copyWith(fontSize: 16),
        bodyMedium: bodyStyle.copyWith(fontSize: 14),
        bodySmall: bodyStyle.copyWith(fontSize: 12),
        labelLarge: captionStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
        labelMedium: captionStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w500),
        labelSmall: captionStyle.copyWith(fontSize: 10, fontWeight: FontWeight.w500),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: surfaceColor,
        foregroundColor: Colors.black87,
        titleTextStyle: subheadingStyle.copyWith(fontSize: 20),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      cardTheme: const CardThemeData(
        elevation: 2,
        color: surfaceColor,
        shadowColor: Colors.black12,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: const BorderSide(color: primaryColor),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorColor, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: captionStyle,
        labelStyle: bodyStyle,
      ),
    );
  }

  // Dark theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: darkPrimaryColor,
      scaffoldBackgroundColor: darkBackgroundColor,
      colorScheme: const ColorScheme.dark(
        primary: darkPrimaryColor,
        secondary: secondaryColor,
        surface: darkSurfaceColor,
        error: errorColor,
        onPrimary: Colors.black,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onError: Colors.white,
      ),
      textTheme: TextTheme(
        headlineLarge: headingStyle.copyWith(fontSize: 32, color: Colors.white),
        headlineMedium: headingStyle.copyWith(fontSize: 28, color: Colors.white),
        headlineSmall: headingStyle.copyWith(fontSize: 24, color: Colors.white),
        titleLarge: subheadingStyle.copyWith(fontSize: 22, color: Colors.white),
        titleMedium: subheadingStyle.copyWith(fontSize: 18, color: Colors.white),
        titleSmall: subheadingStyle.copyWith(fontSize: 16, color: Colors.white),
        bodyLarge: bodyStyle.copyWith(fontSize: 16, color: Colors.white70),
        bodyMedium: bodyStyle.copyWith(fontSize: 14, color: Colors.white70),
        bodySmall: bodyStyle.copyWith(fontSize: 12, color: Colors.white70),
        labelLarge: captionStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white60),
        labelMedium: captionStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white60),
        labelSmall: captionStyle.copyWith(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.white60),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: darkSurfaceColor,
        foregroundColor: Colors.white,
        titleTextStyle: subheadingStyle.copyWith(fontSize: 20, color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      cardTheme: const CardThemeData(
        elevation: 2,
        color: darkSurfaceColor,
        shadowColor: Colors.black26,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkPrimaryColor,
          foregroundColor: Colors.black,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkPrimaryColor, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey.shade800,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: captionStyle.copyWith(color: Colors.white60),
        labelStyle: bodyStyle.copyWith(color: Colors.white70),
      ),
    );
  }
}
