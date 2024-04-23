import 'package:auto_route/auto_route.dart';
import 'package:fintrack_app/screens/finance/finance_list/finance_list_screen.dart';
import 'package:fintrack_app/screens/finance/history/history_screen.dart';
import 'package:fintrack_app/screens/news/news_list/news_list_screen.dart';
import 'package:fintrack_app/screens/settings/settings_screen.dart';
import 'package:fintrack_app/screens/statistics/statistics_screen.dart';
import 'package:fintrack_app/theme/colors.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final _tabs = [FinanceListScreen(), HistoryScreen(), StatisticsScreen(), NewsListScreen(), SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: _tabs[_currentIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          iconTheme: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return IconThemeData(color: AppColors.white);
            } else {
              return IconThemeData(color: AppColors.white40);
            }
          }),
          labelTextStyle: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white);
            }
            return TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                color: AppColors.white40);
          }),
        ),
        child: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedIndex: _currentIndex,
          backgroundColor: AppColors.white10,
          indicatorColor: Colors.transparent,
          destinations: [
            NavigationDestination(
              selectedIcon: SvgPicture.asset('assets/images/tab-icons/finance.svg', color: AppColors.white),
              icon: SvgPicture.asset('assets/images/tab-icons/finance.svg', color: AppColors.white40),
              label: 'Finance',
            ),
            NavigationDestination(
              selectedIcon: SvgPicture.asset('assets/images/tab-icons/history.svg', color: AppColors.white),
              icon: SvgPicture.asset('assets/images/tab-icons/history.svg', color: AppColors.white40),
              label: 'History',
            ),
            NavigationDestination(
              selectedIcon: SvgPicture.asset('assets/images/tab-icons/statistics.svg', color: AppColors.white),
              icon: SvgPicture.asset('assets/images/tab-icons/statistics.svg', color: AppColors.white40),
              label: 'Statistics',
            ),
            NavigationDestination(
              selectedIcon: SvgPicture.asset('assets/images/tab-icons/news.svg', color: AppColors.white),
              icon: SvgPicture.asset('assets/images/tab-icons/news.svg', color: AppColors.white40),
              label: 'News',
            ),
            NavigationDestination(
              selectedIcon: SvgPicture.asset('assets/images/tab-icons/settings.svg', color: AppColors.white),
              icon: SvgPicture.asset('assets/images/tab-icons/settings.svg', color: AppColors.white40),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}