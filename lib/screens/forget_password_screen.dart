import 'package:flutter/material.dart';
import 'package:movie_app/components/app_elevated_button.dart';
import 'package:movie_app/components/txt_field.dart';
import 'package:movie_app/core/extensions/context_extensions.dart';

import '../core/gen/assets.gen.dart';
import '../core/theme/app_colors.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, color: AppColors.yellow),
        title: Text(
          "Forget Password",
          style: context.textTheme.titleLarge?.copyWith(
            color: AppColors.yellow,
            fontWeight: FontWeight.w400,
            fontSize: context.fs(16),
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: Column(
          spacing: context.hg(24),
          children: [
            Assets.images.forgotPassword.image(),
            TxtField(
              hintText: "Email",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!emailRegex.hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.wd(8)),
                child: Assets.icons.emailIcon.svg(),
              ),
              height: context.hg(55),
              paddingHorizontal: context.wd(16),
              paddingVertical: context.hg(0),
              textInputType: TextInputType.emailAddress,
            ),
            AppElevatedButton(
              textButton: "Verify Email",
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  // Handle email verification logic here
                }
              },
              height: context.hg(55),
              paddingHorizontalForButton: context.wd(16),
              paddingVerticalForButton: context.hg(0),
              fontSize: context.fs(20),
            ),
          ],
        ),
      ),
    );
  }
}
