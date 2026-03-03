import 'package:flutter/material.dart';
import 'package:movie_app/core/extensions/context_extensions.dart';
import 'package:movie_app/core/theme/app_colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Search",
          style: context.textTheme.bodyMedium!.copyWith(
            color: AppColors.white,
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}
