import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/components/txt_field.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:movie_app/features/UpdateProfile/validations.dart';
import 'package:movie_app/features/UpdateProfile/widget/show_model_bottom_sheet_characters.dart';

import '../../components/app_elevated_button.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/gen/assets.gen.dart';


class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  String _selectedAvatar = Assets.images.person1.path;
  TextEditingController userController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(title: const Text("Pick Avatar")),
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

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: context.hg(37)),
                        child: CircleAvatar(
                          radius: 75,
                          child: GestureDetector(
                            onTap: () async {
                              final selected = await showModalBottomSheet<String>(
                                context: context,
                                builder: (context) => const ShowModelBottomSheetCharacters(),
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

                      Form(
                        key: formkey,
                        child: Column(
                          children: [

                            TxtField(
                              controller: userController,
                              validator: Validations.userName,
                              hintText: "John Safwan",
                              textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.white),
                              hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.white),
                              paddingHorizontal: 0,
                              paddingVertical: 0,
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(context.wd(15)),
                                child: SvgPicture.asset(Assets.icons.person.path, width: context.wd(30), height: context.hg(30)),
                              ),
                            ),

                            SizedBox(height: context.hg(20)),

                            TxtField(
                              controller: phoneController,
                              validator: Validations.phoneNumbers,
                              hintText: "01200000000",
                              textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.white),
                              hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.white),
                              paddingHorizontal: 0,
                              paddingVertical: 0,
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(context.wd(15)),
                                child: SvgPicture.asset(Assets.icons.phone.path, width: context.wd(30), height: context.hg(30)),
                              ),
                            ),

                            SizedBox(height: context.hg(30)),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Reset Password',
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.white),
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


              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppElevatedButton(
                    onPressed: () {},
                    textButton: 'Delete Account',
                    height: context.hg(55.72),
                    paddingHorizontalForButton: 0,
                    backgroundColor: AppColors.redColor,
                    paddingVerticalForButton: 19,
                    fontSize: 20,
                    textColor: AppColors.white,
                  ),
                  SizedBox(height: context.hg(10)),
                  AppElevatedButton(
                    onPressed: updateData,
                    textButton: 'Update Data',
                    height: context.hg(55.72),
                    paddingHorizontalForButton: 0,
                    paddingVerticalForButton: 0,
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
    if (formkey.currentState!.validate()) {
      print('update data');
    }
  }
}