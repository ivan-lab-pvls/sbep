// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AddExpenseRoute.name: (routeData) {
      final args = routeData.argsAs<AddExpenseRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddExpenseScreen(
          key: args.key,
          finance: args.finance,
        ),
      );
    },
    AddIncomeRoute.name: (routeData) {
      final args = routeData.argsAs<AddIncomeRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddIncomeScreen(
          key: args.key,
          finance: args.finance,
        ),
      );
    },
    FinanceListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FinanceListScreen(),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainScreen(),
      );
    },
    NewsInfoRoute.name: (routeData) {
      final args = routeData.argsAs<NewsInfoRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: NewsInfoScreen(
          key: args.key,
          news: args.news,
        ),
      );
    },
    NewsListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NewsListScreen(),
      );
    },
    OnboardingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OnboardingScreen(),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsScreen(),
      );
    },
  };
}

/// generated route for
/// [AddExpenseScreen]
class AddExpenseRoute extends PageRouteInfo<AddExpenseRouteArgs> {
  AddExpenseRoute({
    Key? key,
    required FinanceModel finance,
    List<PageRouteInfo>? children,
  }) : super(
          AddExpenseRoute.name,
          args: AddExpenseRouteArgs(
            key: key,
            finance: finance,
          ),
          initialChildren: children,
        );

  static const String name = 'AddExpenseRoute';

  static const PageInfo<AddExpenseRouteArgs> page =
      PageInfo<AddExpenseRouteArgs>(name);
}

class AddExpenseRouteArgs {
  const AddExpenseRouteArgs({
    this.key,
    required this.finance,
  });

  final Key? key;

  final FinanceModel finance;

  @override
  String toString() {
    return 'AddExpenseRouteArgs{key: $key, finance: $finance}';
  }
}

/// generated route for
/// [AddIncomeScreen]
class AddIncomeRoute extends PageRouteInfo<AddIncomeRouteArgs> {
  AddIncomeRoute({
    Key? key,
    required FinanceModel finance,
    List<PageRouteInfo>? children,
  }) : super(
          AddIncomeRoute.name,
          args: AddIncomeRouteArgs(
            key: key,
            finance: finance,
          ),
          initialChildren: children,
        );

  static const String name = 'AddIncomeRoute';

  static const PageInfo<AddIncomeRouteArgs> page =
      PageInfo<AddIncomeRouteArgs>(name);
}

class AddIncomeRouteArgs {
  const AddIncomeRouteArgs({
    this.key,
    required this.finance,
  });

  final Key? key;

  final FinanceModel finance;

  @override
  String toString() {
    return 'AddIncomeRouteArgs{key: $key, finance: $finance}';
  }
}

/// generated route for
/// [FinanceListScreen]
class FinanceListRoute extends PageRouteInfo<void> {
  const FinanceListRoute({List<PageRouteInfo>? children})
      : super(
          FinanceListRoute.name,
          initialChildren: children,
        );

  static const String name = 'FinanceListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NewsInfoScreen]
class NewsInfoRoute extends PageRouteInfo<NewsInfoRouteArgs> {
  NewsInfoRoute({
    Key? key,
    required NewsModel news,
    List<PageRouteInfo>? children,
  }) : super(
          NewsInfoRoute.name,
          args: NewsInfoRouteArgs(
            key: key,
            news: news,
          ),
          initialChildren: children,
        );

  static const String name = 'NewsInfoRoute';

  static const PageInfo<NewsInfoRouteArgs> page =
      PageInfo<NewsInfoRouteArgs>(name);
}

class NewsInfoRouteArgs {
  const NewsInfoRouteArgs({
    this.key,
    required this.news,
  });

  final Key? key;

  final NewsModel news;

  @override
  String toString() {
    return 'NewsInfoRouteArgs{key: $key, news: $news}';
  }
}

/// generated route for
/// [NewsListScreen]
class NewsListRoute extends PageRouteInfo<void> {
  const NewsListRoute({List<PageRouteInfo>? children})
      : super(
          NewsListRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewsListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OnboardingScreen]
class OnboardingRoute extends PageRouteInfo<void> {
  const OnboardingRoute({List<PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
