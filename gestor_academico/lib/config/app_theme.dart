import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App theme configuration following the design spec.
class AppTheme {
  AppTheme._();

  // --- Brand Colors ---
  static const Color adminColor = Color(0xFF6366F1);       // Indigo
  static const Color teacherColor = Color(0xFF10B981);      // Emerald
  static const Color studentColor = Color(0xFF3B82F6);      // Sky Blue
  static const Color alertColor = Color(0xFFF59E0B);        // Amber
  static const Color urgentColor = Color(0xFFEF4444);       // Soft Red
  static const Color backgroundColor = Color(0xFFF9FAFB);   // Smoke White
  static const Color textColor = Color(0xFF1F2937);         // Blue Gray
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color surfaceColor = Colors.white;
  static const Color dividerColor = Color(0xFFE5E7EB);

  // --- Attendance Colors ---
  static const Color presentColor = Color(0xFF10B981);
  static const Color pendingColor = Color(0xFFF59E0B);
  static const Color absentColor = Color(0xFFEF4444);

  // --- Text Styles ---
  static TextStyle get headingLarge => GoogleFonts.roboto(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textColor,
      );

  static TextStyle get headingMedium => GoogleFonts.roboto(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textColor,
      );

  static TextStyle get bodyLarge => GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textColor,
      );

  static TextStyle get bodyMedium => GoogleFonts.roboto(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textColor,
      );

  static TextStyle get caption => GoogleFonts.roboto(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textSecondary,
      );

  static TextStyle get captionSmall => GoogleFonts.roboto(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: textSecondary,
      );

  /// Returns the primary color for a given role.
  static Color colorForRole(String role) {
    switch (role) {
      case 'admin':
        return adminColor;
      case 'teacher':
        return teacherColor;
      case 'student':
        return studentColor;
      default:
        return adminColor;
    }
  }

  /// Builds the main ThemeData for the application.
  static ThemeData buildTheme({String role = 'admin'}) {
    final primaryColor = colorForRole(role);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: primaryColor.withOpacity(0.8),
        surface: surfaceColor,
        error: urgentColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textColor,
        onError: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.roboto(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: surfaceColor,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          textStyle: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: BorderSide(color: primaryColor),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: dividerColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        labelStyle: GoogleFonts.roboto(fontSize: 14, color: textSecondary),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      dividerTheme: const DividerThemeData(
        color: dividerColor,
        thickness: 1,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surfaceColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      textTheme: TextTheme(
        headlineLarge: headingLarge,
        headlineMedium: headingMedium,
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
        bodySmall: caption,
      ),
    );
  }
}
