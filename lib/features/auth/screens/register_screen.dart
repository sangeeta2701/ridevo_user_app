
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ridevo_user_app/constants/app_color.dart';
import 'package:ridevo_user_app/constants/sized_box.dart';
import 'package:ridevo_user_app/features/auth/widgets/custom_text_form_field.dart';
import 'package:ridevo_user_app/features/auth/widgets/theme_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  String countryCode = "+91";

  @override
  Widget build(BuildContext context) {
    bool darkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    Color primaryColor = darkTheme ? darkThemeColor : lightThemeColor;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Curved Hero Header with Image & Title
              Stack(
                children: [
                  Container(
                    height: 220.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40.r),
                        bottomRight: Radius.circular(40.r),
                      ),
                      image: DecorationImage(
                        image: AssetImage(
                          darkTheme
                              ? "assets/images/city_dark.jpg"
                              : "assets/images/city_light.jpg",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Subtle dark gradient blend overlay
                  Container(
                    height: 220.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40.r),
                        bottomRight: Radius.circular(40.r),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.6),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  // Header Title
                  Positioned(
                    bottom: 24.h,
                    left: 24.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Create Account",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "Sign up to get started with Ridevo",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // 2. Form Body
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: nameController,
                        hintText: "Full Name",
                        prefixIcon: const Icon(Icons.person_outline),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(30),
                        ],
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Name can't be empty";
                          }
                          if (text.length < 2) {
                            return "Name should be at least 2 characters long";
                          }
                          return null;
                        },
                      ),
                      height16,

                      CustomTextFormField(
                        controller: emailController,
                        hintText: "Email Address",
                        prefixIcon: const Icon(Icons.email_outlined),
                        keyboardType: TextInputType.emailAddress,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Email can't be empty";
                          }
                          final emailRegex = RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          );
                          if (!emailRegex.hasMatch(text)) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                      ),
                      height16,

                      CustomTextFormField(
                        controller: phoneController,
                        hintText: "Mobile Number",
                        keyboardType: TextInputType.phone,
                        prefixIcon: CountryCodePicker(
                          initialSelection: 'IN',
                          showFlag: true,
                          showFlagMain: true,
                          showCountryOnly: false,
                          showOnlyCountryWhenClosed: false,
                          padding: EdgeInsets.zero,
                          flagWidth: 22.w,
                          textStyle: TextStyle(
                            color: darkTheme ? Colors.white : Colors.black87,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          onChanged: (CountryCode code) {
                            setState(() {
                              countryCode = code.dialCode ?? "+91";
                            });
                          },
                          onInit: (CountryCode? code) {
                            countryCode = code?.dialCode ?? "+91";
                          },
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(15),
                        ],
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Mobile number can't be empty";
                          }
                          if (text.length < 7 || text.length > 15) {
                            return "Please enter a valid mobile number";
                          }
                          return null;
                        },
                      ),
                      height16,

                      CustomTextFormField(
                        controller: addressController,
                        hintText: "Address",
                        prefixIcon: const Icon(Icons.location_on_outlined),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Address can't be empty";
                          }
                          if (text.length < 5) {
                            return "Please enter a valid address";
                          }
                          return null;
                        },
                      ),
                      height16,

                      CustomTextFormField(
                        controller: passwordController,
                        hintText: "Password",
                        prefixIcon: const Icon(Icons.lock_outline),
                        obscureText: !_passwordVisible,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Password can't be empty";
                          }
                          if (text.length < 8) {
                            return "Password must be at least 8 characters";
                          }
                          return null;
                        },
                      ),
                      height16,

                      CustomTextFormField(
                        controller: confirmPasswordController,
                        hintText: "Confirm Password",
                        prefixIcon: const Icon(Icons.lock_outline),
                        obscureText: !_confirmPasswordVisible,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _confirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _confirmPasswordVisible =
                                  !_confirmPasswordVisible;
                            });
                          },
                        ),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Password can't be empty";
                          }
                          if (text != passwordController.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                      ),
                      height24,

                      // 3. Full-width Modern CTA Button
                      ThemeButton(primaryColor: primaryColor,  buttonText:"Register",onpress: (){
                        if (_formKey.currentState!.validate()) {
            
          }
                      }),
                      height20,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

