import 'dart:async';

import 'package:clean_architecture/domain/model.dart';
import 'package:clean_architecture/presentation/base/base_view_model.dart';

import '../resources/assets_manager.dart';
import '../resources/string_manager.dart';

class OnBoardingViewModel
    implements
        BaseViewModel,
        OnBoardingViewModelInput,
        OnBoardingViewModelOutput {
  final StreamController<SliderViewObject> _streamController = StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int _currentIndex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  void goNext() {
    _currentIndex++;
    if (_currentIndex >= _list.length) {
      _currentIndex = 0;
    }
    _postDataToView();
  }

  @override
  void goPrevious() {
    _currentIndex--;
    if (_currentIndex < 0) {
      _currentIndex = _list.length - 1;
    }
    _postDataToView();
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSliderViewObject => _streamController.stream;

  List<SliderObject> _getSliderData() => [
    SliderObject(
      AppString.onBoardingTitle1,
      AppString.onBoardingSubTitle1,
      ImageAssets.onBoardingLogo1,
    ),
    SliderObject(
      AppString.onBoardingTitle2,
      AppString.onBoardingSubTitle2,
      ImageAssets.onBoardingLogo2,
    ),
    SliderObject(
      AppString.onBoardingTitle3,
      AppString.onBoardingSubTitle3,
      ImageAssets.onBoardingLogo3,
    ),
    SliderObject(
      AppString.onBoardingTitle4,
      AppString.onBoardingSUbTitle4,
      ImageAssets.onBoardingLogo4,
    ),
  ];

  void _postDataToView() {
    if (_list.isNotEmpty) {
      inputSliderViewObject.add(
        SliderViewObject(_list[_currentIndex], _list.length, _currentIndex),
      );
    }
  }
}

abstract class OnBoardingViewModelInput {
  void goNext();
  void goPrevious();
  void onPageChanged(int index);
  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutput {
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject {
  final SliderObject sliderObject;
  final int numOfSlide;
  final int currentIndex;

  SliderViewObject(this.sliderObject, this.numOfSlide, this.currentIndex);
}
