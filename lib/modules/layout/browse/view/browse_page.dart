import 'package:flutter/material.dart';
import 'package:movie_app/modules/layout/browse/view/default_tab_bar.dart';
import 'package:movie_app/modules/layout/browse/view/movie_grid.dart';

class BrowsePage extends StatefulWidget {
  const BrowsePage({super.key});

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //================ Mohammed Eid =================
          // Default Tab Bar
          DefaultTabBar(),
          //=================================================

          //================ Mohammed Gaber ===================
          // Movie Grid
          MovieGrid(),
          //=================================================
        ],
      ),
    );
  }
}
