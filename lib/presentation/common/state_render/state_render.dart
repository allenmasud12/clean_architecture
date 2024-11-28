import 'package:clean_architecture/data/network/failure.dart';
import 'package:clean_architecture/presentation/forget_password/forget_password_view.dart';
import 'package:clean_architecture/presentation/resources/color_manager.dart';
import 'package:clean_architecture/presentation/resources/font_manager.dart';
import 'package:clean_architecture/presentation/resources/string_manager.dart';
import 'package:clean_architecture/presentation/resources/style_manager.dart';
import 'package:clean_architecture/presentation/resources/values_manager.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../data/mapper/mapper.dart';
import '../../resources/assets_manager.dart';

enum StateRenderType {
  POPUP_LOADING_STATE,
  POPUP_ERROR_STATE,
  POPUP_SUCCESS,
  FULL_SCREEN_LOADING_STATE,
  FULL_SCREEN_ERROR_STATE,
  CONTENT_ERROR_STATE,
  EMPTY_SCREEN_STATE,
}

class StateRender extends StatelessWidget {
  StateRenderType stateRenderType;
  Failure failure;
  String message;
  String title;
  Function retryActionFuncation;

  StateRender({
    super.key,
    required this.stateRenderType,
    Failure? failure,
    String? message,
    String? title,
    required this.retryActionFuncation,
  })
      :
        message = message ?? AppString.loading,
        title = title = EMPTY,
        failure =failure ?? DefaultFailure();


  @override
  Widget build(BuildContext context) {
    return Center(child: _getStateWidget(context));
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRenderType) {
      case StateRenderType.POPUP_LOADING_STATE:
        return _getPopupDialog(context, [_getAnimatedImage(JsonAssets.loading)]);
      case StateRenderType.POPUP_ERROR_STATE:
          return _getPopupDialog(context, [
            _getAnimatedImage(JsonAssets.error),
            _getMessage(message),
            _getRetryButton(AppString.ok.tr(), context)
          ]);
      case StateRenderType.POPUP_SUCCESS:
        return _getPopupDialog(context, [
          _getAnimatedImage(JsonAssets.success),
          _getMessage(title),
          _getMessage(message),
          _getRetryButton(AppString.ok.tr(), context)
        ]);
      case StateRenderType.FULL_SCREEN_LOADING_STATE:
        return _getItemsInColumn([_getAnimatedImage(JsonAssets.loading), _getMessage(message)]);
      case StateRenderType.FULL_SCREEN_ERROR_STATE:
        return _getItemsInColumn([
          _getAnimatedImage(JsonAssets.error),
          _getMessage(failure.message),
          _getRetryButton(AppString.retry_again.tr(), context)
        ]);
      case StateRenderType.CONTENT_ERROR_STATE:
      return Container();
      case StateRenderType.EMPTY_SCREEN_STATE:
      return _getItemsInColumn(
        [_getAnimatedImage(JsonAssets.empty),_getMessage(message)]
      );
      default:
       return Container();
    }
  }

  Widget _getAnimatedImage(String animationName) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child:Lottie.asset(animationName),
    );
  }

  Widget _getPopupDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14),
      ),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: ColorManager.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(AppSize.s14),
            boxShadow: const [
              BoxShadow(color: Colors.black,
                  blurRadius: AppSize.s12,
                  offset: Offset(AppSize.s0, AppSize.s12))
            ]
        ),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children){
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getMessage(String message) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p18),
      child: Text(message, style: getMediumStyle(
          color: ColorManager.black, fontSize: FontSize.s16),),
    );
  }

  Widget _getRetryButton(String buttonTitle, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p18),
      child: SizedBox(
        width: AppSize.s180,
        child: ElevatedButton(onPressed: () {
          if (stateRenderType == StateRenderType.FULL_SCREEN_ERROR_STATE) {
            retryActionFuncation.call();
          } else {
            Navigator.of(context).pop();
          }
        }, child: Text(buttonTitle)),
      ),
    );
  }

  Widget _getItemsInColumn(List<Widget> children) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}
