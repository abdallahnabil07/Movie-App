import 'package:flutter/material.dart';
import 'package:movie_app/components/app_elevated_button.dart';
import 'package:movie_app/components/txt_field.dart';
import 'package:movie_app/core/extensions/context_extensions.dart';
import 'package:movie_app/core/gen/assets.gen.dart';
import 'package:movie_app/core/routes/app_routes_name.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:movie_app/modules/Auth/view/login/widgets/custom_text_button.dart';
import 'package:movie_app/modules/Auth/view/login/widgets/language_card_widget.dart';

import 'avatar_selection_bar.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  bool isArabic = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register",
          style: TextStyle(
            color: AppColors.yellow,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        iconTheme: IconThemeData(color: AppColors.yellow),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 24,
              children: [
                //user Avatar
                AvatarSelectionBar(),
                //Name
                TxtField(
                  hintText: "Name",
                  textInputType: TextInputType.name,
                  paddingHorizontal: 0,
                  paddingVertical: 0,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Assets.icons.nameIcon.svg(
                        width: context.wd(30), height: context.hg(25)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                      return 'Name can only contain letters';
                    }
                    if (value.length < 3) {
                      return 'Name must be at least 3 characters';
                    }
                    return null;
                  },
                ),
                //Email
                TxtField(
                  hintText: "Email",
                  textInputType: TextInputType.emailAddress,
                  paddingHorizontal: 0,
                  paddingVertical: 0,
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
                ),

                ///Password
                TxtField(
                  hintText: "Password",
                  obscureText: true,
                  textInputType: TextInputType.visiblePassword,
                  paddingHorizontal: 0,
                  paddingVertical: 0,
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
                ),

                ///Confirm Password
                TxtField(
                  hintText: "Confirm Password",
                  obscureText: true,
                  textInputType: TextInputType.visiblePassword,
                  paddingHorizontal: 0,
                  paddingVertical: 0,
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
                ),
                //phone number
                TxtField(
                  hintText: "Phone Number",
                  textInputType: TextInputType.phone,
                  paddingHorizontal: 0,
                  paddingVertical: 0,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Assets.icons.phoneIcon.svg(
                        width: context.wd(31), height: context.hg(25)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (!RegExp(r'^\d{11}$').hasMatch(value)) {
                      return 'Please enter a valid 11-digit phone number';
                    }
                    return null;
                  },
                ),
                //create Account button
                AppElevatedButton(
                  textButton: "Create Account",
                  height: context.hg(55),
                  width: double.infinity,
                  fontSize: 18,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Account Created Successfully"),
                        ),
                      );
                      Navigator.pushNamed(context, AppRoutesName.updateProfile);
                    }

                  },
                  backgroundColor: AppColors.yellow,
                  textColor: AppColors.primaryColor,
                  addIcon: false,
                ),
                //Already have Account and Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Already Have Account ? ",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    CustomTextButton(
                      text: "Login",
                      fontWeight: FontWeight.w900,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                //Switch language
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
