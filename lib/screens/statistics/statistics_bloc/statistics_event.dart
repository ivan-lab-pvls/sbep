part of 'statistics_bloc.dart';

@immutable
abstract class StatisticsEvent {}

class GetDayStatisticsEvent extends StatisticsEvent {}

class GetWeekStatisticsEvent extends StatisticsEvent {}

class GetMonthStatisticsEvent extends StatisticsEvent {}

class GetYearStatisticsEvent extends StatisticsEvent {}