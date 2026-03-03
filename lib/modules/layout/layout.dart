import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:movie_app/core/extensions/context_extensions.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:movie_app/modules/layout/home/home_page.dart';
import 'package:movie_app/modules/layout/profile/view/profile/profile_page.dart';
import 'package:movie_app/modules/layout/search/search_page.dart';

import 'browse/browse_page.dart';

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
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[currentIndex],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.wd(12),
          vertical: context.hg(20),
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
              Expanded(
                child: Bounceable(
                  onTap: () {
                    setState(() => currentIndex = 0);
                  },
                  child: Icon(
                    Icons.home,
                    color: currentIndex == 0 ? Colors.amber : Colors.white,
                    size: 30,
                  ),
                ),
              ),
              Expanded(
                child: Bounceable(
                  onTap: () {
                    setState(() => currentIndex = 1);
                  },
                  child: Icon(
                    Icons.search,
                    color: currentIndex == 1 ? Colors.amber : Colors.white,
                    size: 30,
                  ),
                ),
              ),
              Expanded(
                child: Bounceable(
                  onTap: () {
                    setState(() => currentIndex = 2);
                  },
                  child: Icon(
                    Icons.explore,
                    color: currentIndex == 2 ? Colors.amber : Colors.white,
                    size: 30,
                  ),
                ),
              ),
              Expanded(
                child: Bounceable(
                  onTap: () {
                    setState(() => currentIndex = 3);
                  },
                  child: Icon(
                    Icons.perm_contact_cal,
                    color: currentIndex == 3 ? Colors.amber : Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
