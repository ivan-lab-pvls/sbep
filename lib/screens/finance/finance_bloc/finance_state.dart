part of 'finance_bloc.dart';

@immutable
abstract class FinanceState {}

class FinanceInitial extends FinanceState {}

class LoadedFinanceListState extends FinanceState {
  final int incomeValue;
  final int expenseValue;
  final int balance;

  final List<FinanceModel> incomes;
  final List<FinanceModel> expenses;

  LoadedFinanceListState(
      {required this.incomeValue,
      required this.expenseValue,
      required this.balance,
      required this.incomes,
      required this.expenses});
}
