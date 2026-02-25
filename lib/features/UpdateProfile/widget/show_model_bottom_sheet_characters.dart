import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/extensions/context_extensions.dart';
import '../../../core/gen/assets.gen.dart';
import '../../../core/theme/app_colors.dart';
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
                    image: Assets.images.person9.path,
                    isSelected: _selectedImage == Assets.images.person9.path,
                    onTap: () => _handleSelection(Assets.images.person9.path),
                  ),
                  SizedBox(width: context.wd(18)),
                  CharacterSelected(
                    image: Assets.images.person8.path,
                    isSelected: _selectedImage == Assets.images.person8.path,
                    onTap: () => _handleSelection(Assets.images.person8.path),
                  ),
                  SizedBox(width: context.wd(18)),
                  CharacterSelected(
                    image: Assets.images.person7.path,
                    isSelected: _selectedImage == Assets.images.person7.path,
                    onTap: () => _handleSelection(Assets.images.person7.path),
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
                    image: Assets.images.person6.path,
                    isSelected: _selectedImage == Assets.images.person6.path,
                    onTap: () => _handleSelection(Assets.images.person6.path),
                  ),
                  SizedBox(width: context.wd(18)),
                  CharacterSelected(
                    image: Assets.images.person5.path,
                    isSelected: _selectedImage == Assets.images.person5.path,
                    onTap: () => _handleSelection(Assets.images.person5.path),
                  ),
                  SizedBox(width: context.wd(18)),
                  CharacterSelected(
                    image: Assets.images.person4.path,
                    isSelected: _selectedImage == Assets.images.person4.path,
                    onTap: () => _handleSelection(Assets.images.person4.path),
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
                    image: Assets.images.person2.path,
                    isSelected: _selectedImage == Assets.images.person2.path,
                    onTap: () => _handleSelection(Assets.images.person2.path),
                  ),
                  SizedBox(width: context.wd(18)),
                  CharacterSelected(
                    image: Assets.images.person1.path,
                    isSelected: _selectedImage == Assets.images.person1.path,
                    onTap: () => _handleSelection(Assets.images.person1.path),
                  ),
                  SizedBox(width: context.wd(18)),
                  CharacterSelected(
                    image: Assets.images.person3.path,
                    isSelected: _selectedImage == Assets.images.person3.path,
                    onTap: () => _handleSelection(Assets.images.person3.path),
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
