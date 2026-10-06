import 'package:flutter/material.dart';
import 'package:ridevo_user_app/constants/theme_provider.dart';
import 'package:ridevo_user_app/features/auth/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
     themeMode: ThemeMode.system,
     theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
     home: const MainScreen()
      
    );
  }
}

