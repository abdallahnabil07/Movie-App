import 'package:flutter/material.dart';
import 'package:movie_app/components/app_elevated_button.dart';
import 'package:movie_app/components/txt_field.dart';
import 'package:movie_app/core/extensions/context_extensions.dart';
import 'package:movie_app/core/gen/assets.gen.dart';
import 'package:movie_app/core/routes/app_routes_name.dart';
import 'package:movie_app/core/theme/app_colors.dart';

import 'widgets/custom_text_button.dart';
import 'widgets/language_card_widget.dart';

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
                //Email
                TxtField(
                  hintText: "Email",
                  textInputType: TextInputType.emailAddress,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Assets.icons.email.svg(
                        width: context.wd(31), height: context.hg(25)),
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
                SizedBox(height: context.hg(20)),
                //Password
                TxtField(
                  hintText: "Password",
                  textInputType: TextInputType.visiblePassword,
                  obscureText: true,

                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Assets.icons.passwordIcon.svg(
                        width: context.wd(31), height: context.hg(25)),
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
                SizedBox(height: context.hg(12)),
                //Forget Password
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomTextButton(
                    text: "Forget Password ?",
                    fontWeight: FontWeight.w400,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutesName.forgetPassword,
                      );
                    },
                  ),
                ),
                SizedBox(height: context.hg(30)),
                //Login Button
                AppElevatedButton(
                  textButton: "Login",
                  height: context.hg(50),
                  width: double.infinity,
                  fontSize: 18,
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
                SizedBox(height: context.hg(20)),
                //Don"t have an account & create one
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
                SizedBox(height: context.hg(25)),

                //Divider & or
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.wd(50)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: AppColors.yellow,
                          thickness: 1.12,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: context.wd(
                            10)),
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
                SizedBox(height: context.hg(35)),
                //Login with google button
                AppElevatedButton(
                  textButton: "Login With Google",
                  height: context.hg(50),
                  width: double.infinity,
                  fontSize: 18,
                  onPressed: () {},
                  backgroundColor: AppColors.yellow,
                  textColor: AppColors.primaryColor,
                  addIcon: true,
                  icon: Assets.icons.iconGoogle,
                  widthIcon: context.wd(27),
                  heightIcon: context.hg(27),
                  paddingHorizontalForIcon: 8,
                  paddingVerticalForIcon: 0,
                ),
                SizedBox(height: context.hg(30)),
                // Switch language
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
