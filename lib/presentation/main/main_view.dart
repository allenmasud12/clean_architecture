import 'package:clean_architecture/presentation/common/state_render/state_render.dart';
import 'package:clean_architecture/presentation/main/home_page.dart';
import 'package:clean_architecture/presentation/main/notifactions_page.dart';
import 'package:clean_architecture/presentation/main/search_page.dart';
import 'package:clean_architecture/presentation/main/settings_page.dart';
import 'package:clean_architecture/presentation/resources/color_manager.dart';
import 'package:clean_architecture/presentation/resources/string_manager.dart';
import 'package:clean_architecture/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    const HomePage(),
    const SearchPage(),
    const NotificationsPage(),
    const SettingsPage()
  ];
  List<String> titles = [
    AppString.home.tr(),
    AppString.search.tr(),
    AppString.notifications.tr(),
    AppString.settings.tr()
  ];

  var _title = AppString.home.tr();
 var  _currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(_title, style: Theme.of(context).textTheme.bodyLarge,),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: ColorManager.black, spreadRadius: AppSize.s1_5)
          ]
        ),
        child: BottomNavigationBar(
            selectedItemColor: ColorManager.primary,
            unselectedItemColor: ColorManager.grey,
            currentIndex: _currentIndex,
            onTap: onTap,
            items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: AppString.home),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: AppString.search),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: AppString.notifications),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: AppString.settings),
        ]),
      ),
    );
  }

  onTap(int index) {
    setState(() {
      _currentIndex = index;
      _title = titles[index];
    });
  }
}
