import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:movie_app/features/UpdateProfile/widget/show_model_bottom_sheet_characters.dart';
import 'package:movie_app/utils/app_assets.dart';

import '../../components/app_elevated_button.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/gen/assets.gen.dart';
import '../../utils/app_style.dart';


class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  String _selectedAvatar = AppAssets.person1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      appBar: AppBar(title: const Text("Pick Avatar")),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.wd(16)),
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
                child: Column(
                  children: [
                    TextFormField(
                      cursorColor: AppColors.yellow,
                      style: AppStyle.robotoBold20White,
                      decoration: inputDecoration(context, Assets.icons.person.path, "John Safwat"),
                    ),
                    SizedBox(height: context.hg(20)),
                    TextFormField(
                      cursorColor: AppColors.yellow,
                      style: AppStyle.robotoBold20White,
                      decoration: inputDecoration(context, Assets.icons.phone.path, "01200000000"),
                    ),
                  ],
                ),
              ),
              SizedBox(height: context.hg(30)),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text('Reset Password', style: AppStyle.robotoBold20White),
                  ),
                ],
              ),
              SizedBox(height: context.hg(170)),

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
              AppElevatedButton(
                onPressed: () {},
                textButton: 'Update Data',
                height: context.hg(55.72),
                paddingHorizontalForButton: 0,
                paddingVerticalForButton: 0,
                fontSize: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(BuildContext context, String iconName, String hintText) {
    return InputDecoration(
      fillColor: AppColors.charcoalGray,
      filled: true,
      hintText: hintText,
      hintStyle: AppStyle.robotoBold20White,
      prefixIcon: Padding(
        padding: EdgeInsets.all(context.wd(15)),
        child: SvgPicture.asset(iconName, width: context.wd(30), height: context.hg(30)),
      ),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
    );
  }
}
