import 'package:flutter/material.dart';
import 'package:movie_app/modules/on%20boarding/view/end_page_on_boarding.dart';
import 'package:movie_app/modules/on%20boarding/view/first_page_on_boarding.dart';
import 'package:movie_app/modules/on%20boarding/view/fourth_page_on_boarding.dart';
import 'package:movie_app/modules/on%20boarding/view/second_page_on_boarding.dart';
import 'package:movie_app/modules/on%20boarding/view/third_page_on_boarding.dart';

import '../../../components/app_elevated_button.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/routes/app_routes_name.dart';
import '../../../core/theme/app_colors.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              onPageChanged: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              controller: _pageController,
              children: [
                FirstPageOnBoarding(index: _currentIndex),
                SecondPageOnBoarding(index: _currentIndex),
                ThirdPageOnBoarding(index: _currentIndex),
                FourthPageOnBoarding(index: _currentIndex),
                EndPageOnBoarding(index: _currentIndex),
              ],
            ),
          ),
          Container(
            color: AppColors.primaryColor,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: _currentIndex == 0
                        ? context.hg(22)
                        : context.hg(16),
                    left: context.wd(16),
                    right: context.wd(16),
                  ),
                  child: AppElevatedButton(
                    textButton: _currentIndex == 4 ? "Finish" : "Next",
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.fastOutSlowIn,
                      );
                      if (_currentIndex == 4) {
                        Navigator.pushNamed(
                          context,
                          AppRoutesName.login,
                        );
                      }
                    },
                    height: context.hg(55),
                    fontSize: context.fs(20),
                  ),
                ),
                if (_currentIndex != 0)
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: context.hg(18),
                      left: context.wd(16),
                      right: context.wd(16),
                    ),
                    child: AppElevatedButton(
                      backgroundColor: Colors.transparent,
                      borderColor: AppColors.yellow,
                      textButton: "Back",
                      textColor: AppColors.yellow,
                      fontWeight: FontWeight.w600,
                      onPressed: () {
                        _pageController.previousPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.fastOutSlowIn,
                        );
                      },
                      height: context.hg(55),
                      fontSize: context.fs(20),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
