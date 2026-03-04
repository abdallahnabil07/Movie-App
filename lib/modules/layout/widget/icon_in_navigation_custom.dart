import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:movie_app/core/gen/assets.gen.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:movie_app/modules/layout/cubit/layout_cubit.dart';

class IconInNavigationCustom extends StatelessWidget {
  final SvgGenImage icon;
  final int iconIndex;

  const IconInNavigationCustom({
    super.key,
    required this.icon,
    required this.iconIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Bounceable(
        onTap: () {
          context.read<LayoutCubit>().onTapChangeIndex(iconIndex);
        },
        child: BlocBuilder<LayoutCubit, int>(
          builder: (context, currentIndex) {
            return icon.svg(
              colorFilter: ColorFilter.mode(
                currentIndex == iconIndex ? AppColors.yellow : AppColors.white,
                BlendMode.srcIn,
              ),
            );
          },
        ),
      ),
    );
  }
}
