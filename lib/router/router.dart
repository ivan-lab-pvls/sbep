import 'package:auto_route/auto_route.dart';
import 'package:fintrack_app/screens/finance/add_expense/add_expense_screen.dart';
import 'package:fintrack_app/screens/finance/add_income/add_income_screen.dart';
import 'package:fintrack_app/screens/finance/finance_list/finance_list_screen.dart';
import 'package:fintrack_app/screens/main/main_screen.dart';
import 'package:fintrack_app/screens/news/news_info/news_info_screen.dart';
import 'package:fintrack_app/screens/news/news_list/news_list_screen.dart';
import 'package:fintrack_app/screens/onboarding/onboarding_screen.dart';
import 'package:fintrack_app/screens/settings/settings_screen.dart';
import 'package:fintrack_app/models/news_model.dart';
import 'package:fintrack_app/models/finance_model.dart';

import 'package:flutter/material.dart';


part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: OnboardingRoute.page, initial: true),
    AutoRoute(page: MainRoute.page),
    AutoRoute(page: SettingsRoute.page),
    AutoRoute(page: NewsListRoute.page),
    AutoRoute(page: NewsInfoRoute.page),
    AutoRoute(page: FinanceListRoute.page),
    AutoRoute(page: AddIncomeRoute.page),
    AutoRoute(page: AddExpenseRoute.page),

  ];
}