import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fintrack_app/models/finance_model.dart';
import 'package:fintrack_app/models/history_bill_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';

part 'statistics_event.dart';
part 'statistics_state.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  StatisticsBloc() : super(StatisticsInitial()) {
    on<GetDayStatisticsEvent>(_getDayStatisticsHandler);
    on<GetWeekStatisticsEvent>(_getWeekStatisticsHandler);
    on<GetMonthStatisticsEvent>(_getMonthStatisticsHandler);
    on<GetYearStatisticsEvent>(_getYearStatisticsHandler);
  }

  void _getDayStatisticsHandler(
      GetDayStatisticsEvent event, Emitter<StatisticsState> emit) async {
    final List<FinanceModel> incomes = [];
    final incomesBox = Hive.box('incomes');

    List<HistoryBillModel> _incomeBills = [];

    if (incomesBox.isNotEmpty) {
      for (int i = 0; i < incomesBox.length; i++) {
        incomes.add(incomesBox.getAt(i));
      }

      for (FinanceModel income in incomes) {
        _incomeBills.addAll(income.history);
      }
      _incomeBills.sort((a, b) => a.date.compareTo(b.date));
    }

    final List<FinanceModel> expenses = [];
    final expensesBox = Hive.box('expenses');

    List<HistoryBillModel> _spendBills = [];

    if (expensesBox.isNotEmpty) {
      for (int i = 0; i < expensesBox.length; i++) {
        expenses.add(expensesBox.getAt(i));
      }

      for (FinanceModel expense in expenses) {
        _spendBills.addAll(expense.history);
      }
      _spendBills.sort((a, b) => a.date.compareTo(b.date));
    }

    final List<double> _dayData = calculateDailyDifference(_incomeBills, _spendBills);

    final double _maxIncome = _dayData[0];
    final double _totalIncome = _dayData[1];
    final double _totalSpend = _dayData[2];
    final List<double> _dayStatistics = _dayData.sublist(3);

    emit(LoadedDayStatisticsState(
        dayStatistics: _dayStatistics,
        maxIncome: _maxIncome,
        totalIncome: _totalIncome,
        totalSpend: _totalSpend));
  }

  void _getWeekStatisticsHandler(
      GetWeekStatisticsEvent event, Emitter<StatisticsState> emit) async {
    final List<FinanceModel> incomes = [];
    final incomesBox = Hive.box('incomes');

    List<HistoryBillModel> _incomeBills = [];

    if (incomesBox.isNotEmpty) {
      for (int i = 0; i < incomesBox.length; i++) {
        incomes.add(incomesBox.getAt(i));
      }

      for (FinanceModel income in incomes) {
        _incomeBills.addAll(income.history);
      }
      _incomeBills.sort((a, b) => a.date.compareTo(b.date));
    }

    final List<FinanceModel> expenses = [];
    final expensesBox = Hive.box('expenses');

    List<HistoryBillModel> _spendBills = [];

    if (expensesBox.isNotEmpty) {
      for (int i = 0; i < expensesBox.length; i++) {
        expenses.add(expensesBox.getAt(i));
      }

      for (FinanceModel expense in expenses) {
        _spendBills.addAll(expense.history);
      }
      _spendBills.sort((a, b) => a.date.compareTo(b.date));
    }

    final List<double> _weekData = calculateWeeklyDifference(_incomeBills, _spendBills);

    final double _maxIncome = _weekData[0];
    final double _totalIncome = _weekData[1];
    final double _totalSpend = _weekData[2];
    final List<double> _weekStatistics = _weekData.sublist(3);

    emit(LoadedWeekStatisticsState(
        weekStatistics: _weekStatistics,
        maxIncome: _maxIncome,
        totalIncome: _totalIncome,
        totalSpend: _totalSpend));
  }

  void _getMonthStatisticsHandler(
      GetMonthStatisticsEvent event, Emitter<StatisticsState> emit) async {
    final List<FinanceModel> incomes = [];
    final incomesBox = Hive.box('incomes');

    List<HistoryBillModel> _incomeBills = [];

    if (incomesBox.isNotEmpty) {
      for (int i = 0; i < incomesBox.length; i++) {
        incomes.add(incomesBox.getAt(i));
      }

      for (FinanceModel income in incomes) {
        _incomeBills.addAll(income.history);
      }
      _incomeBills.sort((a, b) => a.date.compareTo(b.date));
    }

    final List<FinanceModel> expenses = [];
    final expensesBox = Hive.box('expenses');

    List<HistoryBillModel> _spendBills = [];

    if (expensesBox.isNotEmpty) {
      for (int i = 0; i < expensesBox.length; i++) {
        expenses.add(expensesBox.getAt(i));
      }

      for (FinanceModel expense in expenses) {
        _spendBills.addAll(expense.history);
      }
      _spendBills.sort((a, b) => a.date.compareTo(b.date));
    }

    final List<double> _monthData = calculateMonthlyDifference(_incomeBills, _spendBills);

    final double _maxIncome = _monthData[0];
    final double _totalIncome = _monthData[1];
    final double _totalSpend = _monthData[2];
    final List<double> _monthStatistics = _monthData.sublist(3);

    emit(LoadedMonthStatisticsState(
        monthStatistics: _monthStatistics,
        maxIncome: _maxIncome,
        totalIncome: _totalIncome,
        totalSpend: _totalSpend));
  }

  void _getYearStatisticsHandler(
      GetYearStatisticsEvent event, Emitter<StatisticsState> emit) async {
    final List<FinanceModel> incomes = [];
    final incomesBox = Hive.box('incomes');

    List<HistoryBillModel> _incomeBills = [];

    if (incomesBox.isNotEmpty) {
      for (int i = 0; i < incomesBox.length; i++) {
        incomes.add(incomesBox.getAt(i));
      }

      for (FinanceModel income in incomes) {
        _incomeBills.addAll(income.history);
      }
      _incomeBills.sort((a, b) => a.date.compareTo(b.date));
    }

    final List<FinanceModel> expenses = [];
    final expensesBox = Hive.box('expenses');

    List<HistoryBillModel> _spendBills = [];

    if (expensesBox.isNotEmpty) {
      for (int i = 0; i < expensesBox.length; i++) {
        expenses.add(expensesBox.getAt(i));
      }

      for (FinanceModel expense in expenses) {
        _spendBills.addAll(expense.history);
      }
      _spendBills.sort((a, b) => a.date.compareTo(b.date));
    }

    final List<double> _yearData = calculateYearlyDifference(_incomeBills, _spendBills);

    final double _maxIncome = _yearData[0];
    final double _totalIncome = _yearData[1];
    final double _totalSpend = _yearData[2];
    final List<double> _yearStatistics = _yearData.sublist(3);

    emit(LoadedYearStatisticsState(
        yearStatistics: _yearStatistics,
        maxIncome: _maxIncome,
        totalIncome: _totalIncome,
        totalSpend: _totalSpend));
  }


  List<double> calculateDailyDifference(List<HistoryBillModel> incomeBills, List<HistoryBillModel> spendBills) {
    List<double> dailyDifferences = [];
    DateTime now = DateTime.now();
    double maxDifference = 0;
    double totalIncome = 0;
    double totalSpend = 0;

    for (int i = 0; i < 12; i++) {
      DateTime dayStart = now.subtract(Duration(hours: 24 - i*2));
      DateTime dayEnd = now.subtract(Duration(hours: 24 - i*2 - 2));

      double incomeTotal = 0;
      double spendTotal = 0;

      for (var bill in incomeBills) {
        if (bill.date.isAfter(dayStart) && bill.date.isBefore(dayEnd)) {
          incomeTotal += bill.amount;
        }
      }

      for (var bill in spendBills) {
        if (bill.date.isAfter(dayStart) && bill.date.isBefore(dayEnd)) {
          spendTotal += bill.amount;
        }
      }

      double difference = incomeTotal - spendTotal;
      dailyDifferences.add(difference);

      if (difference > maxDifference) {
        maxDifference = difference;
      }

      totalIncome += incomeTotal;
      totalSpend += spendTotal;
    }

    dailyDifferences.insert(0, maxDifference);
    dailyDifferences.insert(1, totalIncome);
    dailyDifferences.insert(2, totalSpend);

    return dailyDifferences;
  }

  List<double> calculateWeeklyDifference(List<HistoryBillModel> incomeBills, List<HistoryBillModel> spendBills) {
    List<double> weeklyDifferences = [];
    DateTime now = DateTime.now();
    double maxDifference = 0;
    double totalIncome = 0;
    double totalSpend = 0;

    for (int i = 0; i < 7; i++) {
      DateTime weekStart = now.subtract(Duration(days: 7 - i));
      DateTime weekEnd = now.subtract(Duration(days: 7 - i - 1));

      double incomeTotal = 0;
      double spendTotal = 0;

      for (var bill in incomeBills) {
        if (bill.date.isAfter(weekStart) && bill.date.isBefore(weekEnd)) {
          incomeTotal += bill.amount;
        }
      }

      for (var bill in spendBills) {
        if (bill.date.isAfter(weekStart) && bill.date.isBefore(weekEnd)) {
          spendTotal += bill.amount;
        }
      }

      double difference = incomeTotal - spendTotal;
      weeklyDifferences.add(difference);

      if (difference > maxDifference) {
        maxDifference = difference;
      }

      totalIncome += incomeTotal;
      totalSpend += spendTotal;
    }

    weeklyDifferences.insert(0, maxDifference);
    weeklyDifferences.insert(1, totalIncome);
    weeklyDifferences.insert(2, totalSpend);

    return weeklyDifferences;
  }

  List<double> calculateMonthlyDifference(List<HistoryBillModel> incomeBills, List<HistoryBillModel> spendBills) {
    List<double> monthlyDifferences = [];
    DateTime now = DateTime.now();
    double maxDifference = 0;
    double totalIncome = 0;
    double totalSpend = 0;

    for (int i = 0; i < 31; i++) {
      DateTime monthStart = now.subtract(Duration(days: 30 - i));
      DateTime monthEnd = now.subtract(Duration(days: 30 - i - 1));

      double incomeTotal = 0;
      double spendTotal = 0;

      for (var bill in incomeBills) {
        if (bill.date.isAfter(monthStart) && bill.date.isBefore(monthEnd)) {
          incomeTotal += bill.amount;
        }
      }

      for (var bill in spendBills) {
        if (bill.date.isAfter(monthStart) && bill.date.isBefore(monthEnd)) {
          spendTotal += bill.amount;
        }
      }

      double difference = incomeTotal - spendTotal;
      monthlyDifferences.add(difference);

      if (difference > maxDifference) {
        maxDifference = difference;
      }

      totalIncome += incomeTotal;
      totalSpend += spendTotal;
    }

    monthlyDifferences.insert(0, maxDifference);
    monthlyDifferences.insert(1, totalIncome);
    monthlyDifferences.insert(2, totalSpend);

    return monthlyDifferences;
  }

  List<double> calculateYearlyDifference(List<HistoryBillModel> incomeBills, List<HistoryBillModel> spendBills) {
    List<double> yearlyDifferences = [];
    DateTime now = DateTime.now();
    double maxDifference = 0;
    double totalIncome = 0;
    double totalSpend = 0;

    for (int i = 0; i < 12; i++) {
      DateTime yearStart = now.subtract(Duration(days: 365 - i * 31));
      DateTime yearEnd = now.subtract(Duration(days: 365 - i * 31 - 31));

      double incomeTotal = 0;
      double spendTotal = 0;

      for (var bill in incomeBills) {
        if (bill.date.isAfter(yearStart) && bill.date.isBefore(yearEnd)) {
          incomeTotal += bill.amount;
        }
      }

      for (var bill in spendBills) {
        if (bill.date.isAfter(yearStart) && bill.date.isBefore(yearEnd)) {
          spendTotal += bill.amount;
        }
      }

      double difference = incomeTotal - spendTotal;
      yearlyDifferences.add(difference);

      if (difference > maxDifference) {
        maxDifference = difference;
      }

      totalIncome += incomeTotal;
      totalSpend += spendTotal;
    }

    yearlyDifferences.insert(0, maxDifference);
    yearlyDifferences.insert(1, totalIncome);
    yearlyDifferences.insert(2, totalSpend);

    return yearlyDifferences;
  }
}
