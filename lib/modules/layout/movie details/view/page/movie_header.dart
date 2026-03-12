import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:movie_app/components/app_elevated_button.dart';
import 'package:movie_app/components/toastification_custom.dart';
import 'package:movie_app/core/extensions/context_extensions.dart';
import 'package:movie_app/core/gen/assets.gen.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:movie_app/core/utils/launcher_utils.dart';
import 'package:movie_app/modules/layout/home/model/movie_model.dart';
import 'package:movie_app/modules/layout/movie%20details/model/movie_details_model.dart';
import 'package:movie_app/modules/layout/movie%20details/view/widget/card_icon_and_text_details_movie.dart';
import 'package:movie_app/modules/on%20boarding/widget/gradient_custom.dart';
import 'package:toastification/toastification.dart';

class MovieHeader extends StatefulWidget {
  final MovieModel movieModel;
  final MovieDetailsModel movieDetailsModel;

  const MovieHeader({
    super.key,
    required this.movieModel,
    required this.movieDetailsModel,
  });

  @override
  State<MovieHeader> createState() => _MovieHeaderState();
}

class _MovieHeaderState extends State<MovieHeader> {
  bool isBookMarked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //Image & Gradient & Play Button & MovieName
        Stack(
          alignment: Alignment.center,
          children: [
            //MovieImage
            SizedBox(
              width: double.infinity,
              height: context.hg(600),
              child: CachedNetworkImage(
                imageUrl: widget.movieModel.image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: context.hg(600),
                imageBuilder: (context, imageProvider) =>
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            //Gradient
            GradientCustom(
              colors: [
                Color(0xff121312).withValues(alpha: 0.2),
                Color(0xff121312).withValues(alpha: 1),
              ],
            ),
            //PlayIcon
            Bounceable(
              onTap: () {
                LauncherUtils.openTrailer(
                  context,
                  widget.movieDetailsModel.trailerCode,
                );
              },
              child: Assets.icons.playIcon.svg(
                width: context.wd(80),
                height: context.hg(80),
              ),
            ),
            //MovieName
            Positioned(
              bottom: context.hg(16),
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.wd(10.0)),
                child: Text(
                  widget.movieModel.title,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontSize: context.hg(24),
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            //Arrow back % Bookmark
            Positioned(
              top: context.hg(40),
              left: context.wd(22),
              right: context.wd(22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //arrowBack
                  Bounceable(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColors.white,
                      size: context.wd(26),
                    ),
                  ),
                  //Bookmark
                  Bounceable(
                    onTap: () {
                      setState(() {
                        isBookMarked = !isBookMarked;
                        if (isBookMarked) {
                          ToastificationCustom.show(
                              context,
                              type: ToastificationType.success,
                              title: 'Added to bookmarks',
                              alignment: FractionalOffset.bottomCenter
                          );
                        } else {
                          ToastificationCustom.show(
                              context,
                              type: ToastificationType.info,
                              title: 'Removed from bookmarks',
                              alignment: FractionalOffset.bottomCenter
                          );
                        }
                      });
                    },
                    child: Assets.icons.boolmarkIcon.svg(
                      width: 24,
                      colorFilter: ColorFilter.mode(
                        isBookMarked
                            ? AppColors.yellow
                            : AppColors.white.withValues(alpha: 0.8),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        //Watch Button
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.wd(16),
            vertical: context.hg(16),
          ),
          child: AppElevatedButton(
            backgroundColor: AppColors.redColor,
            fontWeight: FontWeight.w700,
            textColor: AppColors.white,
            textButton: "Watch",
            onPressed: () {
              LauncherUtils.watchMovie(context, widget.movieDetailsModel.url);
            },
            height: context.hg(55),
            fontSize: context.hg(20),
          ),
        ),
        //Icons
        Padding(
          padding: EdgeInsets.only(
            left: context.wd(16),
            right: context.wd(16),
            bottom: context.hg(16),
          ),
          child: Row(
            children: [
              //Favorite
              Expanded(
                child: CardIconAndTextDetailsMovie(
                  icon: Assets.icons.heartIcon,
                  text: widget.movieDetailsModel.likeCount.toString(),
                ),
              ),
              SizedBox(width: context.wd(8)),
              //RunTime
              Expanded(
                child: CardIconAndTextDetailsMovie(
                  icon: Assets.icons.clockIcon,
                  text: widget.movieDetailsModel.runtime.toString(),
                ),
              ),
              SizedBox(width: context.wd(8)),
              //Rate
              Expanded(
                child: CardIconAndTextDetailsMovie(
                  icon: Assets.icons.star,
                  text: widget.movieModel.rating.toString(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
