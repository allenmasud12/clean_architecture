import 'package:clean_architecture/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/assets_manager.dart';
import '../resources/string_manager.dart';
import '../resources/values_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  late final List<SliderObject> _list;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _list = _getSliderData();
  }

  List<SliderObject> _getSliderData() => [
    SliderObject(
      title: AppString.onBoardingTitle1,
      subTitle: AppString.onBoardingSubTitle1,
      image: ImageAssets.onBoardingLogo1,
    ),
    SliderObject(
      title: AppString.onBoardingTitle2,
      subTitle: AppString.onBoardingSubTitle2,
      image: ImageAssets.onBoardingLogo2,
    ),
    SliderObject(
      title: AppString.onBoardingTitle3,
      subTitle: AppString.onBoardingSubTitle2,
      image: ImageAssets.onBoardingLogo3,
    ),
    SliderObject(
      title: AppString.onBoardingTitle4,
      subTitle: AppString.onBoardingSUbTitle4,
      image: ImageAssets.onBoardingLogo4,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: AppSize.s1_5,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: _list.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return OnBoardingPage(_list[index]);
        },
      ),
      bottomSheet: Container(
        color: ColorManager.white,
        height: AppSize.s100,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  _pageController.jumpToPage(_list.length - 1);
                },
                child: Text(
                  AppString.skip,
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            _getBottomSheetWidget()
          ],
        ),
      ),
    );
  }

  Widget _getBottomSheetWidget() {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _pageController.animateToPage(_getPreviousIndex(),
                      duration: const Duration(milliseconds: DurationConstant.d300),
                      curve: Curves.bounceInOut);
                });
              },
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.leftArrowIc),
              ),
            ),
          ),
          Row(
            children: List.generate(_list.length, (index) {
              return Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: _getProperCircle(index),
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _pageController.animateToPage(_getNextIndex(),
                      duration: const Duration(milliseconds: DurationConstant.d300),
                      curve: Curves.bounceInOut);
                });
              },
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.rightArrowIc),
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _getPreviousIndex() {
    if (_currentIndex > 0) {
      _currentIndex--;
    } else {
      _currentIndex = _list.length - 1;
    }
    return _currentIndex;
  }

  int _getNextIndex() {
    if (_currentIndex < _list.length - 1) {
      _currentIndex++;
    } else {
      _currentIndex = 0;
    }
    return _currentIndex;
  }

  Widget _getProperCircle(int index) {
    return SvgPicture.asset(
      index == _currentIndex ? ImageAssets.hollowCircleIc : ImageAssets.solidCircleIc,
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;

  const OnBoardingPage(this._sliderObject, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: AppSize.s40),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        const SizedBox(height: AppSize.s60),
        SvgPicture.asset(_sliderObject.image),
      ],
    );
  }
}

class SliderObject {
  final String title;
  final String subTitle;
  final String image;

  SliderObject({
    required this.title,
    required this.subTitle,
    required this.image,
  });
}
