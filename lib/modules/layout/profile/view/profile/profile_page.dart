import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movie_app/core/extensions/context_extensions.dart';
import 'package:movie_app/core/routes/app_routes_name.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:toastification/toastification.dart';

import '../../../../../components/app_elevated_button.dart';
import '../../../../../components/toastification_custom.dart';
import '../../../../../core/gen/assets.gen.dart';
import '../../utils/profile_firebase_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username='';
  String avatar='';
  String wishList='12';
  String history='10';
  bool _isDataLoaded = false;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserData();

}
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
        length: 2,
        child: Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: AppColors.darkGray,
              child: SafeArea(
                child: Column(
                  children: [
                    Row(
                      spacing:context.wd(30),

                      children: [
                        Padding(
                          padding:  EdgeInsets.only(top: context.hg(15),left: context.wd(15)),
                          child: Column(
                            children: [
                              Image.asset(
                                avatar.isEmpty?
                                Assets.images.person1.path:avatar,height: 120,width: 120,fit: BoxFit.fill,),
                             SizedBox(
                               height: context.hg(15),
                             ),
                              Text(username,style: Theme.of(context).textTheme.titleLarge,)
                            ],
                          ),
                        ),

                        Row(
                          spacing:context.wd(30),

                          children: [
                            Column(
                              spacing: context.hg(20),
                              children: [
                                Text(wishList,style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 36
                                )),
                                Text("Wish List",style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24
                                )),
                              ],
                            ),
                            Column(
                              spacing: context.hg(20),

                              children: [
                                Text(history,style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 36
                                )),
                                Text("History",style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24
                                )),
                              ],
                            ),

                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: context.hg(23),),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: context.wd(16)),
                      child: Row(
                        spacing: context.wd(10),
                        children: [


                          Expanded(
                            flex: 3,
                            child: AppElevatedButton(
                              onPressed: () async {
                                final result = await Navigator.pushNamed(
                                  context,
                                  AppRoutesName.updateProfile,
                                );

                                if (result == true) {
                                  _loadUserData();
                                }
                              },

                              textButton: 'Update Data',
                              height: context.hg(55.72),
                              fontSize: 20,
                            ),
                          ),

                          Expanded(
                            flex: 2,
                            child: AppElevatedButton(
                              onPressed: () async {
                                try {
                                  EasyLoading.show();

                                  await FirebaseAuth.instance.signOut();

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
                              textButton: 'Exit',
                              height: context.hg(55.72),
                              backgroundColor: AppColors.redColor,
                              fontSize: 20,
                              textColor: AppColors.white,
                            ),

                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: context.hg(20),),
                    TabBar(
                      dividerHeight: 0,
                        indicatorColor:AppColors.yellow,
                        // indicatorPadding: EdgeInsets.symmetric(horizontal: context.wd(-55)),
                        indicator:  UnderlineTabIndicator(
                          borderSide: BorderSide(
                            width: 4,
                            color: AppColors.yellow,
                          ),
                          insets: EdgeInsets.symmetric(horizontal: context.wd(-50)),
                        ),
                        tabs:[
                      Tab(
                        height: context.hg(70),

                        child:
                      Column(
                        spacing: 9,
                        children: [
                          Expanded(child: Assets.icons.list.svg()),
                          Expanded(
                            child: Text('Watch List',
                              style:Theme.of(context).textTheme.titleLarge ,),
                          )
                        ],
                      ),),
                      Tab(
                        height: context.hg(70),
                        child: Column(
                        children: [
                          Expanded(child: Assets.icons.folder.svg()),
                          Expanded(
                            child: Text('History',
                              style:Theme.of(context).textTheme.titleLarge ,),
                          )
                        ],
                      ),),
                        ])
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: AppColors.primaryColor,
child: Center(
child: Image.asset(Assets.images.emptyWatch.path),
),
            ),
          ),
        ],
      )
        )
    );
  }
  void _loadUserData() async {
    try {
      EasyLoading.show();
      final data = await ProfileFirebaseService.getUserData();
      if (!mounted) return;
      setState(() {
        username = data['name'] ?? '';
        avatar = data['avatar']?.isNotEmpty == true
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

}
