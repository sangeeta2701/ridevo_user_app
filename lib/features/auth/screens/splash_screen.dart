import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ridevo_user_app/constants/app_color.dart';
import 'package:ridevo_user_app/constants/app_text_styles.dart';
import 'package:ridevo_user_app/constants/sized_box.dart';
import 'package:ridevo_user_app/features/auth/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _controller.forward();

    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final darkTheme = Theme.of(context).brightness == Brightness.dark;
    final primaryThemeColor = darkTheme ? darkThemeColor : lightThemeColor;

    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient Glow Accent
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.1,
                  colors: darkTheme
                      ? [
                          darkThemeColor.withOpacity(0.15),
                          greyColor.shade900,
                        ]
                      : [
                          lightThemeColor.withOpacity(0.08),
                          whiteColor,
                        ],
                ),
              ),
            ),
          ),

          // Main Center Brand Content
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: primaryThemeColor,
                        borderRadius: BorderRadius.circular(28.r),
                        boxShadow: [
                          BoxShadow(
                            color: primaryThemeColor.withOpacity(0.4),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.local_taxi_rounded,
                          size: 54.sp,
                          color: whiteColor,
                        ),
                      ),
                    ),
                    height24,

                    // App Title
                    Text(
                      "Ridevo",
                      style: AppTextStyles.mainHeading(context).copyWith(
                        fontSize: 32.sp,
                        letterSpacing: 1.2,
                        color: darkTheme ? whiteColor : blackColor,
                      ),
                    ),
                    height8,

                    // Tagline
                    Text(
                      "Your Ride, Your Way",
                      style: AppTextStyles.hintTextStyle(context).copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Loading Indicator & Version Text
          Positioned(
            bottom: 40.h,
            left: 0,
            right: 0,
            child: Column(
              children: [
                SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: primaryThemeColor,
                  ),
                ),
                height16,
                Text(
                  "Version 1.0.0",
                  style: AppTextStyles.hintTextStyle(context).copyWith(
                    fontSize: 11.sp,
                    color: darkTheme
                        ? greyColor.shade500
                        : greyColor.shade400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}