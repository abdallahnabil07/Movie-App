import 'package:flutter/material.dart';
import 'package:movie_app/core/gen/assets.gen.dart';
import 'package:movie_app/login/widgets/custom_text_button.dart';
import 'package:movie_app/login/widgets/language_card_widget.dart';
import '../components/app_elevated_button.dart';
import '../components/txt_field.dart';
import '../core/routes/app_routes_name.dart';
import '../core/theme/app_colors.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isArabic = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(19.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Assets.images.loginLogo.image(),
                TxtField(
                  hintText: "Email",
                  textInputType: TextInputType.emailAddress,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Assets.icons.email.svg(width: 31, height: 25),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  paddingHorizontal: 0,
                  paddingVertical: 0,
                ),
                SizedBox(height: 20),
                TxtField(
                  hintText: "Password",
                  textInputType: TextInputType.visiblePassword,
                  obscureText: true,

                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Assets.icons.passwordIcon.svg(width: 31, height: 25),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                  paddingHorizontal: 0,
                  paddingVertical: 0,
                ),
                SizedBox(height: 12),

                Align(
                  alignment: Alignment.centerRight,
                  child: CustomTextButton(
                    text: "Forget Password ?",
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 30),
                AppElevatedButton(
                  textButton: "Login",
                  height: 50,
                  width: double.infinity,
                  fontSize: 18,
                  // حجم الخط
                  paddingHorizontalForButton: 0,
                  paddingVerticalForButton: 0,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Login Successful!")),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please fix the errors in red")),
                      );
                    }
                  },
                  backgroundColor: AppColors.yellow,
                  textColor: AppColors.primaryColor,
                  addIcon: false,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t Have Account ? ",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    CustomTextButton(
                      text: "Create One",
                      fontWeight: FontWeight.w900,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutesName.registration,
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: AppColors.yellow,
                          thickness: 1.12,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "OR",
                          style: TextStyle(
                            color: AppColors.yellow,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: AppColors.yellow,
                          thickness: 1.12,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 35),
                AppElevatedButton(
                  textButton: "Login With Google",
                  height: 50,
                  width: double.infinity,
                  fontSize: 18,
                  paddingHorizontalForButton: 0,
                  paddingVerticalForButton: 0,
                  onPressed: () {},
                  backgroundColor: AppColors.yellow,
                  textColor: AppColors.primaryColor,
                  addIcon: true,
                  icon: Assets.icons.iconGoogle,
                  widthIcon: 27,
                  heightIcon: 27,
                  paddingHorizontalForIcon: 8,
                  paddingVerticalForIcon: 0,
                ),
                SizedBox(height: 30),
                LanguageCardWidget(
                  isArabic: isArabic,
                  onTap: () {
                    setState(() {
                      isArabic = !isArabic;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
