import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/components/app_elevated_button.dart';
import 'package:movie_app/components/txt_field.dart';
import 'package:movie_app/core/extensions/context_extensions.dart';
import 'package:movie_app/core/gen/assets.gen.dart';
import 'package:movie_app/core/routes/app_routes_name.dart';


import '../../../../../core/enum/auth_error.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../Auth/utils/auth_firebase_service.dart';
import '../../utils/profile_firebase_service.dart';
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
                    onPressed: () async {
try {
await ProfileFirebaseService.deleteAccount();

Navigator.pushReplacementNamed(context, '/login');

} catch (e) {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text(e.toString())),
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
try {
await ProfileFirebaseService.updateProfile(
name: userController.text,
phone: phoneController.text,
avatarPath: _selectedAvatar,
);

ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(content: Text("Updated successfully")),
);
} catch (e) {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text(e.toString())),
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
      ),
    );
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
