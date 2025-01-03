import 'package:clean_architecture/app/di.dart';
import 'package:clean_architecture/presentation/resources/language_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(EasyLocalization(
      supportedLocales: const [BANGLA_LOCAL, ENGLISH_LOCAL, ],
      path: ASSETS_PATH_LOCALISATIONS,
      fallbackLocale: BANGLA_LOCAL,
      child: Phoenix(child: MyApp(),)
  ));
}
