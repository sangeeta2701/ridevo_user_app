import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ridevo_user_app/constants/app_color.dart';
import 'package:ridevo_user_app/constants/sized_box.dart';
import 'package:ridevo_user_app/features/auth/widgets/custom_text_form_field.dart';

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
    return GestureDetector(
      onTap: () {
        FocusScope.of(
          context,
        ).unfocus(); // to close the keyboard if we click outside of teh textfield
      },
      child: SafeArea(
        child: Scaffold(
          body: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Column(
                children: [
                  Image.asset(
                    darkTheme
                        ? "assets/images/city_dark.jpg"
                        : "assets/images/city_light.jpg",
                  ),
                  height20,
                  Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 25,
                      color: darkTheme ? darkThemeColor : lightThemeColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  height20,
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomTextFormField(
                          controller: nameController,
                          hintText: "Name",
                          prefixIcon: Icon(Icons.person),
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

                            if (text.length > 30) {
                              return "Name should be less than 30 characters";
                            }

                            return null;
                          },
                        ),
                        height20,
                        CustomTextFormField(
                          controller: emailController,
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email),
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
                        height20,
                        CustomTextFormField(
                          controller: phoneController,
                          hintText: "Mobile Number",

                          keyboardType: TextInputType.phone,

                          prefixIcon: CountryCodePicker(
                            initialSelection: 'IN',

                            // Make sure flag is shown in the closed picker
                            showFlag: true,
                            showFlagMain: true,

                            // We want +91, not "India"
                            showCountryOnly: false,
                            showOnlyCountryWhenClosed: false,

                            // Remove the default padding
                            padding: EdgeInsets.zero,

                            // Make flag a little smaller
                            flagWidth: 25,

                            // Match your TextFormField text
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
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

                            if (text.length < 7) {
                              return "Please enter a valid mobile number";
                            }

                            if (text.length > 15) {
                              return "Please enter a valid mobile number";
                            }

                            return null;
                          },
                        ),

                        height20,
                        CustomTextFormField(
                          controller: addressController,
                          hintText: "Address",
                          prefixIcon: Icon(Icons.location_on),

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
                        height20,
                        CustomTextFormField(
                          controller: passwordController,
                          hintText: "Password",
                          prefixIcon: Icon(Icons.lock),

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
                        height20,
                        CustomTextFormField(
                          controller: confirmPasswordController,
                          hintText: "ConfirmPassword",
                          prefixIcon: Icon(Icons.lock),

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

                            if (text.length < 8) {
                              return "Password must be at least 8 characters";
                            }

                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
