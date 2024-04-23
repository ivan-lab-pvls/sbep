import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fintrack_app/models/finance_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';

part 'finance_event.dart';

part 'finance_state.dart';

class FinanceBloc extends Bloc<FinanceEvent, FinanceState> {
  FinanceBloc() : super(FinanceInitial()) {
    on<GetFinanceEvent>(_getFinanceHandler);
    on<AddIncomeEvent>(_addIncomeHandler);
    on<AddExpenseEvent>(_addExpenseHandler);
  }

  void _getFinanceHandler(
      GetFinanceEvent event, Emitter<FinanceState> emit) async {
    List<FinanceModel> incomes = [];
    List<FinanceModel> expenses = [];

    int incomeValue = 0;
    int expenseValue = 0;

    int balance = 0;

    final incomesBox = Hive.box('incomes');
    final expensesBox = Hive.box('expenses');

    if (incomesBox.isNotEmpty && expensesBox.isNotEmpty) {
      for (int i = 0; i < incomesBox.length; i++) {
        incomes.add(incomesBox.getAt(i));
      }

      for (int i = 0; i < expensesBox.length; i++) {
        expenses.add(expensesBox.getAt(i));
      }

      for (FinanceModel income in incomes) {
        incomeValue += income.value;
      }

      for (FinanceModel expense in expenses) {
        expenseValue += expense.value;
      }

      balance = incomeValue - expenseValue;

      emit(LoadedFinanceListState(
          incomeValue: incomeValue,
          expenseValue: expenseValue,
          balance: balance,
          incomes: incomes,
          expenses: expenses));
    } else {
      for (FinanceModel income in startedIncomes) {
        incomesBox.add(income);
      }

      for (FinanceModel expense in startedExpenses) {
        expensesBox.add(expense);
      }

      emit(LoadedFinanceListState(
          incomeValue: 0,
          expenseValue: 0,
          balance: 0,
          incomes: startedIncomes,
          expenses: startedExpenses));
    }
  }

  void _addIncomeHandler(
      AddIncomeEvent event, Emitter<FinanceState> emit) async {
    List<FinanceModel> incomes = [];

    final incomesBox = Hive.box('incomes');

    if (incomesBox.isNotEmpty) {
      for (int i = 0; i < incomesBox.length; i++) {
        incomes.add(incomesBox.getAt(i));
      }

      final int _foundIndex = incomes.indexOf(event.oldFinance);
      incomesBox.putAt(_foundIndex, event.newFinance);
    }
  }

  void _addExpenseHandler(
      AddExpenseEvent event, Emitter<FinanceState> emit) async {
    List<FinanceModel> expenses = [];

    final expensesBox = Hive.box('expenses');

    if (expensesBox.isNotEmpty) {
      for (int i = 0; i < expensesBox.length; i++) {
        expenses.add(expensesBox.getAt(i));
      }

      final int _foundIndex = expenses.indexOf(event.oldFinance);
      expensesBox.putAt(_foundIndex, event.newFinance);
    }
  }
}

final List<FinanceModel> startedIncomes = [
  FinanceModel(
    value: 0,
    category: 'Business',
    type: FinanceType.income,
    history: [],
  ),
  FinanceModel(
    value: 0,
    category: 'Salary',
    type: FinanceType.income,
    history: [],
  ),
  FinanceModel(
    value: 0,
    category: 'Dividends',
    type: FinanceType.income,
    history: [],
  ),
  FinanceModel(
    value: 0,
    category: 'Investment',
    type: FinanceType.income,
    history: [],
  ),
  FinanceModel(
    value: 0,
    category: 'Rent',
    type: FinanceType.income,
    history: [],
  ),
  FinanceModel(
    value: 0,
    category: 'Freelance',
    type: FinanceType.income,
    history: [],
  ),
  FinanceModel(
    value: 0,
    category: 'Royalty',
    type: FinanceType.income,
    history: [],
  ),
  FinanceModel(
    value: 0,
    category: 'Passive income',
    type: FinanceType.income,
    history: [],
  ),
];

final List<FinanceModel> startedExpenses = [
  FinanceModel(
    value: 0,
    category: 'Procurement',
    type: FinanceType.expense,
    history: [],
  ),
  FinanceModel(
    value: 0,
    category: 'Food',
    type: FinanceType.expense,
    history: [],
  ),
  FinanceModel(
    value: 0,
    category: 'Transport',
    type: FinanceType.expense,
    history: [],
  ),
  FinanceModel(
    value: 0,
    category: 'Rest',
    type: FinanceType.expense,
    history: [],
  ),
  FinanceModel(
    value: 0,
    category: 'Investment',
    type: FinanceType.expense,
    history: [],
  ),
];
