import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/components/app_elevated_button.dart';
import 'package:movie_app/components/txt_field.dart';
import 'package:movie_app/core/extensions/context_extensions.dart';
import 'package:movie_app/core/gen/assets.gen.dart';
import 'package:movie_app/core/routes/app_routes_name.dart';
import 'package:movie_app/core/theme/app_colors.dart';

import 'validations.dart';
import 'widget/show_model_bottom_sheet_characters.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  String _selectedAvatar = Assets.images.person1.path;
  TextEditingController userController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Pick Avatar"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_outlined, color: AppColors.yellow),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.wd(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //user Avatar
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: context.hg(37)),
                      child: CircleAvatar(
                        radius: 75,
                        child: Bounceable(
                          onTap: () async {
                            final selected = await showModalBottomSheet<String>(
                              context: context,
                              builder: (context) =>
                                  const ShowModelBottomSheetCharacters(),
                            );
                            if (selected != null) {
                              setState(() {
                                _selectedAvatar = selected;
                              });
                            }
                          },
                          child: Image.asset(
                            _selectedAvatar,
                            height: context.hg(150),
                            width: context.wd(150),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    //User name and number
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          //TextFiled user name
                          TxtField(
                            controller: userController,
                            validator: Validations.userName,
                            hintText: "John Safwan",
                            textStyle: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(color: AppColors.white),
                            hintStyle: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(color: AppColors.white),
                            paddingHorizontal: 0,
                            paddingVertical: 0,
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(context.wd(15)),
                              child: SvgPicture.asset(
                                Assets.icons.person.path,
                                width: context.wd(30),
                                height: context.hg(30),
                              ),
                            ),
                          ),
                          SizedBox(height: context.hg(20)),
                          //TextFiled user number
                          TxtField(
                            textInputType: TextInputType.numberWithOptions(),
                            controller: phoneController,
                            validator: Validations.phoneNumbers,
                            hintText: "01200000000",
                            textStyle: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(color: AppColors.white),
                            hintStyle: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(color: AppColors.white),
                            paddingHorizontal: 0,
                            paddingVertical: 0,
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(context.wd(15)),
                              child: SvgPicture.asset(
                                Assets.icons.phone.path,
                                width: context.wd(30),
                                height: context.hg(30),
                              ),
                            ),
                          ),
                          SizedBox(height: context.hg(30)),
                          //Rest Password
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //Reset Password
                              Bounceable(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutesName.forgetPassword,
                                  );
                                },
                                child: Text(
                                  'Reset Password',
                                  style: Theme.of(context).textTheme.titleLarge
                                      ?.copyWith(color: AppColors.white),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: context.hg(20)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //Bottom Buttons
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //delete Account Button
                Padding(
                  padding: EdgeInsets.symmetric(vertical: context.hg(19)),
                  child: AppElevatedButton(
                    onPressed: () {},
                    textButton: 'Delete Account',
                    height: context.hg(55.72),
                    backgroundColor: AppColors.redColor,
                    fontSize: 20,
                    textColor: AppColors.white,
                  ),
                ),
                SizedBox(height: context.hg(10)),
                //Update Account Button
                AppElevatedButton(
                  onPressed: updateData,
                  textButton: 'Update Data',
                  height: context.hg(55.72),
                  fontSize: 20,
                ),
                SizedBox(height: context.hg(20)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void updateData() {
    if (formKey.currentState!.validate()) {
      print('update data');
    }
  }
}
