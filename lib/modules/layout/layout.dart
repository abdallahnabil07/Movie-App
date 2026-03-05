import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/extensions/context_extensions.dart';
import 'package:movie_app/core/gen/assets.gen.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:movie_app/modules/layout/home/home_page.dart';
import 'package:movie_app/modules/layout/profile/view/UpdateProfile/update_profile.dart';
import 'package:movie_app/modules/layout/profile/view/profile/profile_page.dart';
import 'package:movie_app/modules/layout/search/search_page.dart';
import 'package:movie_app/modules/layout/widget/icon_in_navigation_custom.dart';

import 'browse/browse_page.dart';
import 'cubit/layout_cubit.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  final List<Widget> _page = [
    HomePage(),
    SearchPage(),
    BrowsePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocBuilder<LayoutCubit, int>(
        builder: (context, state) {
          return Scaffold(
            body: _page[state],
            bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.wd(12),
                vertical: context.hg(16),
              ),
              child: Container(
                height: context.hg(55),
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColors.charcoalGray,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    //home
                    IconInNavigationCustom(
                      icon: Assets.icons.homeIcon,
                      iconIndex: 0,
                    ),
                    //search
                    IconInNavigationCustom(
                      icon: Assets.icons.searchIcon,
                      iconIndex: 1,
                    ),
                    //explore
                    IconInNavigationCustom(
                      icon: Assets.icons.exploreIcon,
                      iconIndex: 2,
                    ),
                    //profile
                    IconInNavigationCustom(
                      icon: Assets.icons.profielIcon,
                      iconIndex: 3,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
