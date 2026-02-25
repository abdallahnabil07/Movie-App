import 'package:flutter/material.dart';
import 'package:movie_app/core/extensions/context_extensions.dart';
import 'package:movie_app/core/gen/assets.gen.dart';

class AvatarSelectionBar extends StatefulWidget {
  const AvatarSelectionBar({super.key});

  @override
  State<AvatarSelectionBar> createState() => _AvatarSelectionBarState();
}

class _AvatarSelectionBarState extends State<AvatarSelectionBar> {
  final List<String> avatars = [
    Assets.images.avatar1.path,
    Assets.images.avatar2.path,
    Assets.images.avatar3.path,
  ];

  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.hg(140),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: avatars.length,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: context.wd(8)),
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              splashColor: Colors.transparent,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: isSelected
                      ? Border.all(color: Colors.blue, width: 3)
                      : null,
                ),
                width: isSelected ? context.wd(130) : context.wd(90),
                height: isSelected ? context.hg(130) : context.hg(90),
                child: CircleAvatar(
                  radius: isSelected ? 55 : 30,
                  backgroundImage: AssetImage(avatars[index]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
