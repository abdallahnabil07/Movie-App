import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/extensions/context_extensions.dart';
import 'package:movie_app/modules/layout/browse/view/tab_bar_states.dart';

import '../../../../core/theme/app_colors.dart';
import 'tab_bar_cubit.dart';

class DefaultTabBar extends StatelessWidget {
  const DefaultTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBarCubit, TabBarState>(
      builder: (context, state) {
        if (state is TabBarLoading || state is TabBarInitial) {
          return const SizedBox(
            height: 48,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is TabBarError) {
          return SizedBox(
            height: 48,
            child: Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        if (state is TabBarLoaded) {
          if (state.genres.isEmpty) {
            return const SizedBox(
              height: 48,
              child: Center(child: Text('No genres available')),
            );
          }

          final controller = DefaultTabController.of(context);
          return AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              int index = controller.index;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: state.genres.asMap().entries.map((entry) {
                    int i = entry.key;
                    String genre = entry.value;
                    bool isSelected = i == index;
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.wd(6)),
                      child: isSelected
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.yellow,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    context.wd(16),
                                  ),
                                ),
                                minimumSize: Size(
                                  context.wd(80),
                                  context.hg(40),
                                ),
                              ),
                              onPressed: () => controller.animateTo(i),
                              child: Text(
                                genre,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            )
                          : OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.yellow,
                                side: const BorderSide(color: AppColors.yellow),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    context.wd(16),
                                  ),
                                ),
                                minimumSize: Size(
                                  context.wd(80),
                                  context.hg(40),
                                ),
                              ),
                              onPressed: () => controller.animateTo(i),
                              child: Text(
                                genre,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      color: AppColors.yellow,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                    );
                  }).toList(),
                ),
              );
            },
          );
        }

        return const SizedBox(
          height: 48,
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: AppColors.primaryColor,
              color: AppColors.yellow,
            ),
          ),
        );
      },
    );
  }
}
