import 'package:auto_route/auto_route.dart';
import 'package:fintrack_app/screens/statistics/tabs/day_tab.dart';
import 'package:fintrack_app/screens/statistics/tabs/month_tab.dart';
import 'package:fintrack_app/screens/statistics/tabs/week_tab.dart';
import 'package:fintrack_app/screens/statistics/tabs/year_tab.dart';
import 'package:fintrack_app/theme/colors.dart';
import 'package:flutter/material.dart';

@RoutePage()
class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppColors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
            bottom: TabBar(
              dividerColor: AppColors.white10,
              indicatorColor: AppColors.accentGreen,
              labelColor: AppColors.accentGreen,
              unselectedLabelColor: AppColors.white40,
              tabs: [
                Tab(child: Text('Today', style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 16),)),
                Tab(child: Text('Week', style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 16),)),
                Tab(child: Text('Month', style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 16),)),
                Tab(child: Text('Year', style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 16),)),
              ],
            ),
            elevation: 0,
            backgroundColor: AppColors.white10,
            centerTitle: true,
            title: Text('Statistics', style: TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),)
        ),
        body: TabBarView(
          children: [
            DayTab(),
            WeekTab(),
            MonthTab(),
            YearTab(),
          ],
        ),
      ),
    );
  }
}
