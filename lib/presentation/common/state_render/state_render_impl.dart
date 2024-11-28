import 'package:clean_architecture/data/mapper/mapper.dart';
import 'package:clean_architecture/presentation/common/state_render/state_render.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../resources/string_manager.dart';

abstract class FlowState {
  StateRenderType getStateRenderType();

  String getMessage();
}

// Loading State (POPUP, FULL SCREEN)
class LoadingState extends FlowState {
  StateRenderType stateRenderType;
  String message;

  LoadingState({required this.stateRenderType, String? message}): message = message ?? AppString.loading;

  @override
  String getMessage() => message;

  @override
  StateRenderType getStateRenderType() => stateRenderType;
}

// error State (POPUP, FULL LOADING)
class ErrorState extends FlowState {
  StateRenderType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRenderType getStateRenderType() => stateRendererType;
}

//Content state
class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => EMPTY;

  @override
  StateRenderType getStateRenderType() => StateRenderType.CONTENT_ERROR_STATE;
}

//empty state
class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRenderType getStateRenderType() => StateRenderType.CONTENT_ERROR_STATE;
}

// success state
class SuccessState extends FlowState {
  String message;

  SuccessState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRenderType getStateRenderType() => StateRenderType.POPUP_SUCCESS;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFuncation) {
    switch(runtimeType){
      case LoadingState:{
          if(getStateRenderType() == StateRenderType.POPUP_LOADING_STATE){
            // showing popup dialog
            showPopUp(context, getStateRenderType(), getMessage());
            // return the content ui of the screen
            return contentScreenWidget;
          }else{
            return StateRender(
                stateRenderType: getStateRenderType(),
                message: getMessage(),
                retryActionFuncation: retryActionFuncation);
          }
      }
      case ErrorState :{
        dismissDialog(context);
        if (getStateRenderType() == StateRenderType.POPUP_ERROR_STATE) {
          // showing popup dialog
          showPopUp(context, getStateRenderType(), getMessage());
          // return the content ui of the screen
          return contentScreenWidget;
        } else // StateRendererType.FULL_SCREEN_ERROR_STATE
            {
          return StateRender(
              stateRenderType: getStateRenderType(),
              message: getMessage(),
              retryActionFuncation: retryActionFuncation);
        }
      }
      case ContentState :{
        dismissDialog(context);
        return contentScreenWidget;
      }
      case EmptyState :{
        return StateRender(
            stateRenderType: getStateRenderType(),
            message: getMessage(),
            retryActionFuncation: retryActionFuncation);
      }
      case SuccessState :
        {
          // i should check if we are showing loading popup to remove it before showing success popup
          dismissDialog(context);

          // show popup
          showPopUp(context, StateRenderType.POPUP_SUCCESS, getMessage(),
              title: AppString.success.tr());
          // return content ui of the screen
          return contentScreenWidget;
        }
      default:
        return Container();
    }
  }
}

dismissDialog(BuildContext context) {
  if (_isThereCurrentDialogShowing(context)) {
    // Navigator.of(context).pop();
    Navigator.of(context, rootNavigator: true).pop(true);
  }
}

_isThereCurrentDialogShowing(BuildContext context) =>
    ModalRoute.of(context)?.isCurrent != true;

showPopUp(BuildContext context, StateRenderType stateRendererType,
    String message,{String title = EMPTY}) {
  WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
      context: context,
      builder: (BuildContext context) => StateRender(
        stateRenderType: stateRendererType,
        message: message,
        title: title,
        retryActionFuncation: () {},
      )));
}