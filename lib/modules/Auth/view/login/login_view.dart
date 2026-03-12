import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movie_app/components/app_elevated_button.dart';
import 'package:movie_app/components/toastification_custom.dart';
import 'package:movie_app/components/txt_field.dart';
import 'package:movie_app/core/extensions/context_extensions.dart';
import 'package:movie_app/core/gen/assets.gen.dart';
import 'package:movie_app/core/local/cache_helper_.dart';
import 'package:movie_app/core/local/constants/cache_key.dart';
import 'package:movie_app/core/routes/app_routes_name.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:movie_app/modules/Auth/cubit/login%20cubit/login_state.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/local/cache_helper_.dart';
import '../../../../core/local/constants/cache_key.dart';
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

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: Builder(
        builder: (context) {
          return BlocListener<LoginCubit, LoginState>(
            listener: (context, state) async {
              if (state is LoginLoading) {
                EasyLoading.show();
              }
              else if (state is LoginSuccess) {
                EasyLoading.dismiss();

                if (state.user != null) {
                  await CacheHelper.saveData(
                    key: CacheKeys.isLoggedIn,
                    value: true,
                  );

                  ToastificationCustom.show(
                    context,
                    title: 'Logged in successfully',
                    type: ToastificationType.success,
                  );

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutesName.layout,
                    (route) => false,
                  );
                }
              }
              else if (state is LoginFailure) {
                EasyLoading.dismiss();

                ToastificationCustom.show(
                  context,
                  title: state.errorMessage,
                  type: ToastificationType.error,
                );
              }
            },
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(19.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        /// Logo
                        Assets.images.loginLogo.image(),

                        /// Email
                        TxtField(
                          hintText: "Email",
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Assets.icons.email.svg(
                              width: context.wd(31),
                              height: context.hg(25),
                            ),
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

                        /// Password
                        TxtField(
                          hintText: "Password",
                          textInputType: TextInputType.visiblePassword,
                          obscureText: true,
                          controller: passwordController,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Assets.icons.passwordIcon.svg(
                              width: context.wd(31),
                              height: context.hg(25),
                            ),
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

                        /// Forget Password
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

                        /// Login Button
                        AppElevatedButton(
                          textButton: "Login",
                          height: context.hg(50),
                          width: double.infinity,
                          fontSize: 18,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<LoginCubit>().userLogin(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );
                            }
                          },
                          backgroundColor: AppColors.yellow,
                          textColor: AppColors.primaryColor,
                          addIcon: false,
                        ),

                        SizedBox(height: context.hg(20)),

                        /// Create Account
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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

                        /// Divider
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.wd(50),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: AppColors.yellow,
                                  thickness: 1.12,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: context.wd(10),
                                ),
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

                        /// Login With Google
                        AppElevatedButton(
                          textButton: "Login With Google",
                          height: context.hg(50),
                          width: double.infinity,
                          fontSize: 18,
                          onPressed: () {
                            context.read<LoginCubit>().userLoginByGoogle();
                          },
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

                        /// Language Switch
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
            ),
          );
        },
      ),
    );
  }
}
