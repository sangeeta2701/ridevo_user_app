import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridevo_user_app/constants/app_color.dart';



class AppTextStyles {
  static TextStyle mainHeading(BuildContext context) {
    final darkTheme =
        Theme.of(context).brightness == Brightness.dark;

    return GoogleFonts.poppins(
      
      fontWeight: FontWeight.bold,
      color: darkTheme
          ? darkThemeColor
          : lightThemeColor,
    );
  }

  static TextStyle hintTextStyle(BuildContext context) {
    final darkTheme =
        Theme.of(context).brightness == Brightness.dark;

    return GoogleFonts.poppins(
      
      fontWeight: FontWeight.w400,
      color: darkTheme
          ? greyColor.shade200
          : greyColor,
    );
  }
  static TextStyle textfiledTextStyle(BuildContext context) {
    final darkTheme =
        Theme.of(context).brightness == Brightness.dark;

    return GoogleFonts.poppins(
      
      fontWeight: FontWeight.w400,
      color: darkTheme
          ? blackColor
          : blackColor,
    );
  }
  static TextStyle whiteButtonTextStyle(BuildContext context) {
    final darkTheme =
        Theme.of(context).brightness == Brightness.dark;

    return GoogleFonts.poppins(
      
      fontWeight: FontWeight.w600,
      color: darkTheme
          ? whiteColor
          : blackColor,
    );
  }

 
}