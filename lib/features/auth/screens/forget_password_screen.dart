import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ridevo_user_app/constants/app_color.dart';
import 'package:ridevo_user_app/constants/app_text_styles.dart';
import 'package:ridevo_user_app/constants/sized_box.dart';
import 'package:ridevo_user_app/features/auth/screens/login_screen.dart';
import 'package:ridevo_user_app/features/auth/widgets/custom_text_form_field.dart';
import 'package:ridevo_user_app/features/auth/widgets/theme_button.dart';
import 'package:ridevo_user_app/global/global.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
    final emailController = TextEditingController();
  
 
 
  final _formKey = GlobalKey<FormState>();

  void _submit(){
    firebaseAuth.sendPasswordResetEmail(email: emailController.text.trim()
    ).then((value){
        Fluttertoast.showToast(msg: "We have sent you an email to recover password. Please check the email");
    }).onError((error, stackTrace){
        Fluttertoast.showToast(msg: "Error Occurred: \n ${error.toString()}");
    });
  }
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
                    height: 230.h,
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
                    height: 230.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40.r),
                        bottomRight: Radius.circular(40.r),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          blackColor.withOpacity(0.3),
                          blackColor.withOpacity(0.6),
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
                          "Forget Password",

                          style: AppTextStyles.mainHeading(
                            context,
                          ).copyWith(fontSize: 25.sp),
                        ),
                        height4,
                        Text(
                          "Recover the password to continue with Ridevo",
                          style: AppTextStyles.whiteContentStyle(
                            context,
                          ).copyWith(fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // 2. Form Body
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      height30,
                     

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

                      height60,

                    
                      ThemeButton(
                        primaryColor: primaryColor,
                        buttonText: "Send Reset Password Link",
                        onpress: () {
                            _submit();
                         
                        },
                      ),
                      height30,
                       Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account ?",
                            style: AppTextStyles.forgotPasswrodTextStyle(
                              context,
                            ).copyWith(fontSize: 12.sp),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                            },
                            child: Text(
                              "SignIn",
                              style: AppTextStyles.textButtonTextStyle(
                                context,
                              ).copyWith(fontSize: 14.sp),
                            ),
                          ),
                        ],
                      ),
                      
                     
                     
                     
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