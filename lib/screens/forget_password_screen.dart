import 'package:flutter/material.dart';
import 'package:movie_app/components/app_elevated_button.dart';
import 'package:movie_app/components/txt_field.dart';
import 'package:movie_app/core/extensions/context_extensions.dart';
import 'package:movie_app/core/theme/app_colors.dart';

import '../core/gen/assets.gen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_outlined, color: AppColors.yellow,),
        ),
        title: Text(
          "Forget Password",
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            spacing: context.hg(24),
            children: [
              Assets.images.forgotPassword.image(),
              TxtField(
                hintText: "Email",
                height: context.hg(55),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  final emailRegex = RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.wd(8)),
                  child: Assets.icons.emailIcon.svg(),
                ),

                paddingHorizontal: context.wd(16),
                paddingVertical: context.hg(0),
                textInputType: TextInputType.emailAddress,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.wd(16)),
                child: AppElevatedButton(
                  textButton: "Verify Email",
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      // Handle email verification logic here
                    }
                  },
                  height: context.hg(55),
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
