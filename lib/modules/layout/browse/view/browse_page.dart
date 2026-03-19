import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/modules/layout/browse/view/tab_bar_states.dart';
import '../../../../core/extensions/context_extensions.dart';
import 'default_tab_bar.dart';
import 'movie_grid.dart';
import 'tab_bar_cubit.dart';

class BrowsePage extends StatelessWidget {
  final String? initialGenre;

  const BrowsePage({super.key, this.initialGenre});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => TabBarCubit()..fetchGenres(),
        child: _BrowsePageContent(initialGenre: initialGenre),
      ),
    );
  }
}

class _BrowsePageContent extends StatefulWidget {
  final String? initialGenre;

  const _BrowsePageContent({this.initialGenre});

  @override
  State<_BrowsePageContent> createState() => _BrowsePageContentState();
}

class _BrowsePageContentState extends State<_BrowsePageContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialGenre != null) {
        context.read<TabBarCubit>().setInitialGenre(widget.initialGenre!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBarCubit, TabBarState>(
      builder: (context, state) {
        if (state is TabBarLoaded && state.genres.isNotEmpty) {
          return DefaultTabController(
            length: state.genres.length,
            initialIndex: state.initialIndex ?? 0,
            child: SafeArea(
              child: Column(
                spacing: context.hg(16),
                children: [
                  const DefaultTabBar(),
                  Expanded(child: MovieGrid()),
                ],
              ),
            ),
          );
        }

        if (state is TabBarError) {
          return Center(child: Text(state.message));
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
