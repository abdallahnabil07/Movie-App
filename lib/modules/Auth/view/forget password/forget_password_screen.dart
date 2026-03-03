import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movie_app/components/app_elevated_button.dart';
import 'package:movie_app/components/txt_field.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/gen/assets.gen.dart';
import '../../cubit/forget password cubit/forget_password_cubit.dart';
import '../../cubit/forget password cubit/forget_password_state.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: const ForgetPasswordView(),
    );
  }
}

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
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
      body: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          if (state is ForgetPasswordLoading) {
            toastification.show(
              context: context,
              type: ToastificationType.info,
              title: const Text("Loading"),
              autoCloseDuration: const Duration(seconds: 2),
            );
          }

          if (state is ForgetPasswordSuccess) {
            toastification.show(
              context: context,
              type: ToastificationType.success,
              style: ToastificationStyle.fillColored,
              title: const Text("Success"),
              description: const Text("Check your email to reset your password"),
              autoCloseDuration: const Duration(seconds: 3),
            );

            Navigator.pop(context);
          }

          if (state is ForgetPasswordError) {
            toastification.show(
              context: context,
              type: ToastificationType.error,
              style: ToastificationStyle.fillColored,
              title: const Text("Error"),
              description: Text(state.message),
              autoCloseDuration: const Duration(seconds: 3),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                spacing: context.hg(24),
                children: [
                  Assets.images.forgotPassword.image(),
                  //Email
                  TxtField(
                    controller: emailController,
                    hintText: "Email",
                    height: context.hg(60),
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
                  //Elevated button Verify Email
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.wd(16)),
                    child: AppElevatedButton(
                      textButton: state is ForgetPasswordLoading ? "Loading..." : "Verify Email",
                      onPressed: state is ForgetPasswordLoading ? null : () {
                        if (formKey.currentState?.validate() ?? false) {
                          context.read<ForgetPasswordCubit>().sendResetEmail(
                            emailController.text.trim(),
                          );
                        }
                      },
                      height: context.hg(55),
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
