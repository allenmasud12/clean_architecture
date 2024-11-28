import 'dart:ui';

import 'package:clean_architecture/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String PREFS_KEY_ONBOARDING_SCREEN = "PREFS_KEY_ONBOARDING_SCREEN";
const String PREFS_KEY_IS_USER_LOGGED_IN = "PREFS_KEY_IS_USER_LOGGED_IN";
const String PREFS_KEY_TOKEN = "PREFS_KEY_TOKEN";

class AppPreferences {
  SharedPreferences _preferences;

  AppPreferences(this._preferences);

  Future<String> getAppLanguage() async {
    String? language = _preferences.getString(PREFS_KEY_LANG);

    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.ENGLISH.getValue();
    }
  }

  Future<void> setLanguageChanged() async {
    String currentLanguage = await getAppLanguage();
    if (currentLanguage == LanguageType.BANGLA.getValue()) {
      // save prefs with english lang
      _preferences.setString(
          PREFS_KEY_LANG, LanguageType.ENGLISH.getValue());
    } else {
      // save prefs with arabic lang
      _preferences.setString(
          PREFS_KEY_LANG, LanguageType.BANGLA.getValue());
    }
  }

  Future<Locale> getLocal() async {
    String currentLanguage = await getAppLanguage();
    if (currentLanguage == LanguageType.BANGLA.getValue()) {
      // return arabic local
      return BANGLA_LOCAL;
    } else {
      // return english local
      return ENGLISH_LOCAL;
    }
  }



  Future<void> setOnBoardingScreenViewed() async {
    _preferences.setBool(PREFS_KEY_ONBOARDING_SCREEN, true);
  }

  Future<bool> isOnBoardingScreenViewed() async {
    return _preferences.getBool(PREFS_KEY_ONBOARDING_SCREEN) ?? false;
  }

  Future<void> setUserToken(String token) async {
    _preferences.setString(PREFS_KEY_TOKEN, token);
  }

  Future<String> getUserToken() async {
    return _preferences.getString(PREFS_KEY_TOKEN) ?? "";
  }

  Future<void> setIsUserLoggedIn() async {

    _preferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _preferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN) ?? false;
  }

  Future<void> logout() async {
    _preferences.remove(PREFS_KEY_IS_USER_LOGGED_IN);
  }
}
