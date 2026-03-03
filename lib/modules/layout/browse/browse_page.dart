import 'package:flutter/material.dart';
import 'package:movie_app/core/extensions/context_extensions.dart';
import 'package:movie_app/core/theme/app_colors.dart';

class BrowsePage extends StatefulWidget {
  const BrowsePage({super.key});

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Browser",
          style: context.textTheme.bodyMedium!.copyWith(
            color: AppColors.white,
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}
