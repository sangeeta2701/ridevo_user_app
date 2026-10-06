import 'package:flutter/material.dart';
import 'package:ridevo_user_app/constants/app_color.dart';

class MyThemes{
  static final darkTheme = ThemeData(
  scaffoldBackgroundColor: greyColor.shade900,
  colorScheme: ColorScheme.dark()
  );

  static final lightTheme = ThemeData(
  scaffoldBackgroundColor: whiteColor,
  colorScheme: ColorScheme.light()
  );
}