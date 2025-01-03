import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'style_manager.dart';
import 'values_manager.dart';


ThemeData getApplicationTheme() {
  return ThemeData(
      //main colors of the app
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.primaryOpacity70,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.grey1,
      cardColor: ColorManager.grey,
      //ripple color
      splashColor: ColorManager.primaryOpacity70,

      //card view theme
      cardTheme: CardTheme(
        color: ColorManager.white,
        shadowColor: ColorManager.grey,
        elevation: AppSize.s4,
      ),

      //app bar theme
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: ColorManager.primary,
          elevation: AppSize.s4,
          shadowColor: ColorManager.primaryOpacity70,
          titleTextStyle: getRegularStyle(
              color: ColorManager.white, fontSize: FontSize.s16)),

      //button theme
      buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        disabledColor: ColorManager.grey1,
        buttonColor: ColorManager.primary,
        splashColor: ColorManager.primaryOpacity70,
      ),

      //elevation button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: getRegularStyle(color: ColorManager.white),
              backgroundColor: ColorManager.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12)))),

      //text theme
      textTheme: TextTheme(
          headlineLarge: getSemiBoldStyle(
              color: ColorManager.darkGrey, fontSize: FontSize.s16),
          headlineMedium: getMediumStyle(
              color: ColorManager.lightGrey, fontSize: FontSize.s14),
          headlineSmall: getRegularStyle(color: ColorManager.grey1),
          titleSmall: getRegularStyle(color: ColorManager.grey)),

      //input decoration theme (text form field)

      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        //hint style
        hintStyle: getRegularStyle(color: ColorManager.grey1),
        //label style
        labelStyle: getMediumStyle(color: ColorManager.darkGrey),
        //error style
        errorStyle: getRegularStyle(color: ColorManager.error),
        //enabled border
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.grey,
              width: AppSize.s1,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

        //focused border
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.primary,
              width: AppSize.s1_5,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
        //error border
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.error,
              width: AppSize.s1,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))
        ),
        //focus error border
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.primary,
              width: AppSize.s1_5,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))
        ),

      ));
}
