import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ridevo_user_app/constants/app_color.dart';
import 'package:ridevo_user_app/constants/app_text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    final darkTheme = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = darkTheme ? darkThemeColor : lightThemeColor;

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: AppTextStyles.textfiledTextStyle(context).copyWith(fontSize: 13.sp),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.hintTextStyle(context).copyWith(
          fontSize: 13.sp,
          color: darkTheme ? Colors.white38 : Colors.grey.shade400,
        ),
        filled: true,
        fillColor: darkTheme
            ? Colors.grey.shade900
            : Colors.grey.shade50,
        contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
        
        // Unfocused Border
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(
            color: darkTheme ? Colors.grey.shade800 : Colors.grey.shade200,
            width: 1.2,
          ),
        ),

        // Focused Border
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(
            color: primaryColor,
            width: 1.5,
          ),
        ),

        // Error Border
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),

        prefixIcon: prefixIcon != null
            ? IconTheme(
                data: IconThemeData(
                  color: darkTheme ? Colors.grey.shade400 : Colors.grey.shade600,
                  size: 20.sp,
                ),
                child: prefixIcon!,
              )
            : null,

        suffixIcon: suffixIcon != null
            ? IconTheme(
                data: IconThemeData(
                  color: darkTheme ? Colors.grey.shade400 : Colors.grey.shade600,
                  size: 20.sp,
                ),
                child: suffixIcon!,
              )
            : null,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
    );
  }
}