import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ridevo_user_app/constants/app_text_styles.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({
    super.key,
    required this.primaryColor,
    required this.buttonText,
    required this.onpress
  });

  final Color primaryColor;
  final String  buttonText;
 final VoidCallback onpress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          elevation: 4,
          shadowColor: primaryColor.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        onPressed: onpress,
        child: Text(
          buttonText,
          style: AppTextStyles.whiteButtonTextStyle(context)
              .copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}