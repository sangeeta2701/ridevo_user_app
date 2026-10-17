import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ridevo_user_app/constants/app_color.dart';
import 'package:ridevo_user_app/constants/app_text_styles.dart';
import 'package:ridevo_user_app/constants/sized_box.dart';
import 'package:ridevo_user_app/features/auth/screens/main_screen.dart';
import 'package:ridevo_user_app/features/auth/screens/register_screen.dart';
import 'package:ridevo_user_app/features/auth/widgets/custom_text_form_field.dart';
import 'package:ridevo_user_app/features/auth/widgets/theme_button.dart';
import 'package:ridevo_user_app/global/global.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  
  final passwordController = TextEditingController();

  bool _passwordVisible = false;
 
  final _formKey = GlobalKey<FormState>();

  //login function
    void _userLogin()async{
    //validate
    if(_formKey.currentState!.validate()){
      await firebaseAuth.signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim()).then((auth)async{
        currentUser = auth.user;
        
        await Fluttertoast.showToast(msg: "Successfully Logged-in");
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));
      }).catchError((errorMessage){
        Fluttertoast.showToast(msg: "Error Occured: \n $errorMessage");
      });
    }
    else{
      Fluttertoast.showToast(msg: "Not all fields are valid");
    }
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
                          "Login Account",

                          style: AppTextStyles.mainHeading(
                            context,
                          ).copyWith(fontSize: 25.sp),
                        ),
                        height4,
                        Text(
                          "Sign-in to get started with Ridevo",
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
                     
                      
                      height24,

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
                    

                      
                      height60,

                      // 3. Full-width Modern CTA Button
                      ThemeButton(
                        primaryColor: primaryColor,
                        buttonText: "SignIn",
                        onpress: () {
                          _userLogin();
                        },
                      ),
                      height30,
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.all(1.w),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          "Forgot Password ?",
                          style: AppTextStyles.forgotPasswrodTextStyle(
                            context,
                          ).copyWith(fontSize: 12.sp),
                        ),
                      ),
                      height12,

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account ?",
                            style: AppTextStyles.forgotPasswrodTextStyle(
                              context,
                            ).copyWith(fontSize: 12.sp),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                            },
                            child: Text(
                              "Register",
                              style: AppTextStyles.textButtonTextStyle(
                                context,
                              ).copyWith(fontSize: 14.sp),
                            ),
                          ),
                        ],
                      ),
                      height60,
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