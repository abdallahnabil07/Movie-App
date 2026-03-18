import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/components/txt_field.dart';
import 'package:movie_app/core/extensions/context_extensions.dart';
import 'package:movie_app/core/gen/assets.gen.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:movie_app/core/widget/retry_error_widget.dart';
import 'package:movie_app/modules/layout/home/model/home_movie_model.dart';
import 'package:movie_app/modules/layout/home/widget/movie_slider_card.dart';
import 'package:movie_app/modules/layout/search/cubit/search_state.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchCubit _searchCubit = SearchCubit();
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchCubit.close();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          TxtField(
            paddingHorizontal: context.wd(16),
            paddingVertical: context.hg(12),
            width: double.infinity,
            height: context.hg(60),
            controller: _searchController,
            onChanged: (String value) {
              _searchCubit.onQueryChanged(value.toLowerCase());
            },
            hintText: "Search",
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.wd(16),
                vertical: context.hg(12),
              ),
              child: Assets.icons.searchIcon.svg(
                width: context.wd(20),
                height: context.hg(20),
              ),
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: context.hg(56),
              maxWidth: context.wd(64),
              minHeight: context.hg(18),
              minWidth: context.wd(18),
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              bloc: _searchCubit,
              builder: (context, state) {
                switch (state) {
                  case InitialState():
                    return SizedBox.shrink();
                  case LoadingState():
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                        backgroundColor: AppColors.yellow,
                      ),
                    );
                  case SuccessState():
                    return GridView.builder(
                      padding: EdgeInsets.all(context.wd(4)),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: context.wd(4),
                        mainAxisSpacing: context.hg(8),
                        childAspectRatio: 2 / 3,
                      ),
                      itemCount: state.movieList.length,
                      itemBuilder: (context, index) {
                        final movie = MovieModel.fromJson(
                          state.movieList[index],
                        );
                        return MovieSliderCard(movie: movie);
                      },
                    );

                  case EmptyState():
                    return Center(
                      child: Text(
                        "No movie found",
                        style: context.textTheme.titleLarge!.copyWith(
                          color: AppColors.white,
                          fontSize: context.hg(20),
                        ),
                      ),
                    );
                  case ErrorState():
                    return RetryErrorWidget(
                      errorMessage: state.errorMessage,
                      onPressed: () {
                        _searchCubit.searchMovies(_searchController.text);
                      },
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
