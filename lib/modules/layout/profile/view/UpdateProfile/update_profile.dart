import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/components/app_elevated_button.dart';
import 'package:movie_app/components/toastification_custom.dart';
import 'package:movie_app/components/txt_field.dart';
import 'package:movie_app/core/extensions/context_extensions.dart';
import 'package:movie_app/core/gen/assets.gen.dart';
import 'package:movie_app/core/routes/app_routes_name.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:movie_app/modules/layout/profile/utils/profile_firebase_service.dart';
import 'package:toastification/toastification.dart';

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
  bool _isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Pick Avatar"),
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: Icon(Icons.arrow_back_outlined, color: AppColors.yellow),
        // ),
      ),
      body: _isDataLoaded
          ? Padding(
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
                            padding: EdgeInsets.symmetric(
                              vertical: context.hg(37),
                            ),
                            child: Bounceable(
                              onTap: () async {
                                final selected =
                                    await showModalBottomSheet<String>(
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
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  width: context.wd(150),
                                  height: context.hg(150),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: _selectedAvatar.startsWith('http')
                                          ? NetworkImage(_selectedAvatar)
                                          : AssetImage(_selectedAvatar)
                                                as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
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
                                  hintText: _isDataLoaded ? null : "User Name",
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(color: AppColors.white),
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleLarge
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
                                  textInputType:
                                      TextInputType.numberWithOptions(),
                                  controller: phoneController,
                                  validator: Validations.phoneNumbers,
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(color: AppColors.white),
                                  hintText: _isDataLoaded
                                      ? null
                                      : "01200000000",
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleLarge
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
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
                          onPressed: () async {
                            EasyLoading.dismiss();
                            if (!mounted) return;
                            try {
                              EasyLoading.show();
                              await ProfileFirebaseService.deleteAccount();
                              EasyLoading.dismiss();
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutesName.login,
                              );
                            } catch (e) {
                              EasyLoading.dismiss();
                              ToastificationCustom.show(
                                context,
                                type: ToastificationType.error,
                                title: e.toString(),
                              );
                            }
                          },
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
                        onPressed: () async {
                          if (!mounted) return;
                          try {
                            EasyLoading.show();
                            await ProfileFirebaseService.updateProfile(
                              name: userController.text,
                              phone: phoneController.text,
                              avatarPath: _selectedAvatar,
                            );
                            EasyLoading.dismiss();
                            Navigator.pop(context, true);

                            ToastificationCustom.show(
                              context,
                              type: ToastificationType.success,
                              title: "Updated successfully",
                            );
                          } catch (e) {
                            EasyLoading.dismiss();
                            ToastificationCustom.show(
                              context,
                              type: ToastificationType.error,
                              title: e.toString(),
                            );
                          }
                        },
                        textButton: 'Update Data',
                        height: context.hg(55.72),
                        fontSize: 20,
                      ),
                      SizedBox(height: context.hg(20)),
                    ],
                  ),
                ],
              ),
            )
          : SizedBox.shrink(),
    );
  }

  void _loadUserData() async {
    try {
      EasyLoading.show();
      final data = await ProfileFirebaseService.getUserData();
      if (!mounted) return;
      setState(() {
        userController.text = data['name'] ?? '';
        phoneController.text = data['phone'] ?? '';
        _selectedAvatar = data['avatar']?.isNotEmpty == true
            ? data['avatar']
            : Assets.images.person1.path;

        _isDataLoaded = true;
      });
    } catch (e) {
      ToastificationCustom.show(
        context,
        type: ToastificationType.error,
        title: e.toString(),
      );
    } finally {
      EasyLoading.dismiss();
    }
  }

  // void deleteById(String id) async {
  //   try {
  //     final querySnapshot = await FirebaseFirestore.instance
  //         .collection('users')
  //         .where('id', isEqualTo: id)
  //         .get();
  //
  //     if (querySnapshot.docs.isNotEmpty) {
  //       final docId = querySnapshot.docs.first.id;
  //
  //       await FirebaseFirestore.instance.collection('users').doc(docId).delete();
  //
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('User deleted successfully')),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('User not found')),
  //       );
  //     }
  //   } catch (e, st) {
  //     print("Error deleting user: $e");
  //     print("Stack trace: $st");
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to delete: $e')),
  //     );
  //   }
  // }
  // void updateData()async {
  //   if (formKey.currentState!.validate()) {
  //     try {
  //       String id = "1";
  //       String name = userController.text;
  //       String phone = phoneController.text;
  //       String image = _selectedAvatar;
  //
  //       final querySnapshot = await FirebaseFirestore.instance
  //           .collection('users')
  //           .where('id', isEqualTo: id)
  //           .get();
  //
  //       if (querySnapshot.docs.isNotEmpty) {
  //         final docId = querySnapshot.docs.first.id;
  //
  //         await FirebaseFirestore.instance
  //             .collection('users')
  //             .doc(docId)
  //             .update({
  //           'name': name,
  //           'phone': phone,
  //           'image': image,
  //         });
  //
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('User updated successfully')),
  //         );
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('User not found')),
  //         );
  //       }
  //     } catch (e) {
  //       print("Error updating user: $e");
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Failed to update')),
  //       );
  //     }    }
  // }
}
