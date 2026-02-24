import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/extensions/context_extensions.dart';
import '../../../core/theme/app_colors.dart';
import '../../../utils/app_assets.dart';
import 'character_selected.dart';

class ShowModelBottomSheetCharacters extends StatefulWidget {
  const ShowModelBottomSheetCharacters({super.key});

  @override
  State<ShowModelBottomSheetCharacters> createState() => _ShowModelBottomSheetCharactersState();
}

class _ShowModelBottomSheetCharactersState extends State<ShowModelBottomSheetCharacters> {
  String? _selectedImage;

  void _handleSelection(String imagePath) {
    setState(() {
      _selectedImage = imagePath;
      Navigator.pop(context, imagePath);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
    decoration: BoxDecoration(
      color: AppColors.charcoalGray,
      borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
    ),
    child: Padding(
      padding:  EdgeInsets.symmetric(horizontal:context.wd(19),vertical: context.hg(18)),
      child: Column(
        children: [



          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: context.hg(19)),
              child: Row(
                children: [
                  CharacterSelected(
                    image: AppAssets.person9,
                    isSelected: _selectedImage == AppAssets.person9,
                    onTap: () => _handleSelection(AppAssets.person9),
                  ),
                  SizedBox(width: context.wd(18)),
                  CharacterSelected(
                    image: AppAssets.person8,
                    isSelected: _selectedImage == AppAssets.person8,
                    onTap: () => _handleSelection(AppAssets.person8),
                  ),
                  SizedBox(width: context.wd(18)),
                  CharacterSelected(
                    image: AppAssets.person7,
                    isSelected: _selectedImage == AppAssets.person7,
                    onTap: () => _handleSelection(AppAssets.person7),
                  ),
                ],
              ),
            ),

          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: context.hg(19)),
              child: Row(
                children: [
                  CharacterSelected(
                    image: AppAssets.person6,
                    isSelected: _selectedImage == AppAssets.person6,
                    onTap: () => _handleSelection(AppAssets.person6),
                  ),
                  SizedBox(width: context.wd(18)),
                  CharacterSelected(
                    image: AppAssets.person5,
                    isSelected: _selectedImage == AppAssets.person5,
                    onTap: () => _handleSelection(AppAssets.person5),
                  ),
                  SizedBox(width: context.wd(18)),
                  CharacterSelected(
                    image: AppAssets.person4,
                    isSelected: _selectedImage == AppAssets.person4,
                    onTap: () => _handleSelection(AppAssets.person4),
                  ),
                ],
              ),
            ),

          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: context.hg(19)),
              child: Row(
                children: [
                  CharacterSelected(
                    image: AppAssets.person2,
                    isSelected: _selectedImage == AppAssets.person2,
                    onTap: () => _handleSelection(AppAssets.person2),
                  ),
                  SizedBox(width: context.wd(18)),
                  CharacterSelected(
                    image: AppAssets.person1,
                    isSelected: _selectedImage == AppAssets.person1,
                    onTap: () => _handleSelection(AppAssets.person1),
                  ),
                  SizedBox(width: context.wd(18)),
                  CharacterSelected(
                    image: AppAssets.person3,
                    isSelected: _selectedImage == AppAssets.person3,
                    onTap: () => _handleSelection(AppAssets.person3),
                  ),
                ],
              ),
            ),

          ),
        ],
      ),
    ),
    );
  }
}
