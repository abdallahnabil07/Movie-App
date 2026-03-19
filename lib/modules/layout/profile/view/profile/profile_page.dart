import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movie_app/core/extensions/context_extensions.dart';
import 'package:movie_app/core/routes/app_routes_name.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:movie_app/modules/layout/home/model/home_movie_model.dart';
import 'package:movie_app/modules/layout/profile/cubit/history_cubit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toastification/toastification.dart';

import '../../../../../components/app_elevated_button.dart';
import '../../../../../components/toastification_custom.dart';
import '../../../../../core/gen/assets.gen.dart';
import '../../../../../core/local/cache_helper_.dart';
import '../../../../../core/local/constants/cache_key.dart';
import '../../../home/widget/movie_slider_card.dart';
import '../../cubit/watch_list_state.dart';
import '../../utils/profile_firebase_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = '';
  String avatar = '';
  bool _isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return _buildProfileContent(context);
  }

  Widget _buildProfileContent(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: AppColors.darkGray,
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    Row(
                      spacing: context.wd(30),
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: context.hg(15),
                            left: context.wd(15),
                          ),
                          child: Column(
                            children: [
                              !_isDataLoaded
                                  ? Shimmer.fromColors(
                                      baseColor: AppColors.darkGreyColor,
                                      highlightColor: Colors.grey[600]!,
                                      child: Container(
                                        width: context.wd(120),
                                        height: context.hg(120),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.darkGreyColor,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: context.wd(120),
                                      height: context.hg(120),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image:
                                              avatar.isNotEmpty &&
                                                  avatar.startsWith('http')
                                              ? NetworkImage(avatar)
                                              : AssetImage(
                                                      avatar.isEmpty
                                                          ? Assets
                                                                .images
                                                                .person1
                                                                .path
                                                          : avatar,
                                                    )
                                                    as ImageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                              SizedBox(height: context.hg(15)),
                              !_isDataLoaded
                                  ? Shimmer.fromColors(
                                      baseColor: AppColors.darkGreyColor,
                                      highlightColor: Colors.grey[600]!,
                                      child: Container(
                                        width: context.wd(100),
                                        height: context.hg(30),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: context.wd(24),
                                          vertical: context.hg(24),
                                        ),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          color: AppColors.darkGreyColor,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      username,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleLarge,
                                    ),
                            ],
                          ),
                        ),
                        Row(
                          spacing: context.wd(30),
                          children: [
                            BlocBuilder<WatchListCubit, List<MovieModel>>(
                              builder: (context, watchList) {
                                return _buildCounterColumn(
                                  context,
                                  watchList.length.toString(),
                                  "Wish List",
                                );
                              },
                            ),
                            BlocBuilder<HistoryCubit, List<MovieModel>>(
                              builder: (context, historyList) {
                                return _buildCounterColumn(
                                  context,
                                  historyList.length.toString(),
                                  "History",
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: context.hg(23)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.wd(16)),
                      child: Row(
                        spacing: context.wd(10),
                        children: [
                          Expanded(
                            flex: 3,
                            child: AppElevatedButton(
                              onPressed: () async {
                                final result = await Navigator.pushNamed(
                                  context,
                                  AppRoutesName.updateProfile,
                                );
                                if (result == true) _loadUserData();
                              },
                              textButton: 'Update Data',
                              height: context.hg(55.72),
                              fontSize: context.hg(20),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: AppElevatedButton(
                              onPressed: () async {
                                try {
                                  EasyLoading.show();

                                  if (context.mounted) {
                                    context
                                        .read<WatchListCubit>()
                                        .clearWatchList();
                                    context.read<HistoryCubit>().clearHistory();
                                  }

                                  await FirebaseAuth.instance.signOut();
                                  await CacheHelper.removeData(
                                    CacheKeys.isSignUp,
                                  );
                                  await CacheHelper.removeData(
                                    CacheKeys.isLoggedIn,
                                  );

                                  EasyLoading.dismiss();
                                } catch (e) {
                                  EasyLoading.dismiss();
                                  if (context.mounted) {
                                    ToastificationCustom.show(
                                      context,
                                      type: ToastificationType.error,
                                      title: e.toString(),
                                    );
                                  }
                                }
                              },
                              textButton: 'Exit',
                              height: context.hg(55.72),
                              backgroundColor: AppColors.redColor,
                              fontSize: context.hg(20),
                              textColor: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: context.hg(20)),
                    TabBar(
                      dividerHeight: 0,
                      indicatorColor: AppColors.yellow,
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(
                          width: context.wd(4),
                          color: AppColors.yellow,
                        ),
                        insets: EdgeInsets.symmetric(
                          horizontal: (context.width - context.wd(260)),
                        ),
                      ),
                      tabs: [
                        Tab(
                          height: context.hg(80),
                          child: Column(
                            spacing: context.hg(9),
                            children: [
                              Expanded(
                                child: Assets.icons.list.svg(
                                  width: context.wd(30),
                                  height: context.hg(20),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Watch List',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Tab(
                          height: context.hg(80),
                          child: Column(
                            children: [
                              Expanded(
                                child: Assets.icons.folder.svg(
                                  width: context.wd(42),
                                  height: context.hg(42),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'History',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Tab 1: Watch List
                  _buildMoviesGrid<WatchListCubit>(),
                  // Tab 2: History
                  _buildMoviesGrid<HistoryCubit>(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterColumn(BuildContext context, String count, String label) {
    return Column(
      spacing: context.hg(20),
      children: [
        !_isDataLoaded
            ? Shimmer.fromColors(
                baseColor: AppColors.darkGreyColor,
                highlightColor: Colors.grey[600]!,
                child: Container(
                  width: context.wd(50),
                  height: context.hg(30),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.darkGreyColor,
                  ),
                ),
              )
            : Text(
                count,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: context.hg(36),
                ),
              ),
        Text(
          label,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: context.hg(24),
          ),
        ),
      ],
    );
  }

  Widget _buildMoviesGrid<T extends Cubit<List<MovieModel>>>() {
    return BlocBuilder<T, List<MovieModel>>(
      builder: (context, movies) {
        if (movies.isEmpty) {
          return Center(child: Image.asset(Assets.images.emptyWatch.path));
        }
        return GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 9,
            crossAxisSpacing: 2,
            childAspectRatio: 0.68,
          ),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return !_isDataLoaded
                ? Shimmer.fromColors(
                    baseColor: AppColors.darkGreyColor,

                    highlightColor: Colors.grey[600]!,
                    child: Container(
                      margin: EdgeInsets.all(context.wd(5)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.darkGreyColor,
                      ),
                    ),
                  )
                : MovieSliderCard(movie: movie);
          },
        );
      },
    );
  }

  void _loadUserData() async {
    try {
      // EasyLoading.show();
      final data = await ProfileFirebaseService.getUserData();
      if (!mounted) return;
      setState(() {
        username = data['name'] ?? '';
        avatar = data['avatar']?.isNotEmpty == true
            ? data['avatar']
            : Assets.images.person1.path;
        _isDataLoaded = true;
      });
    } catch (e) {
      if (mounted) {
        ToastificationCustom.show(
          context,
          type: ToastificationType.error,
          title: e.toString(),
        );
      }
    } finally {
      EasyLoading.dismiss();
    }
  }
}
