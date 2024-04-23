part of 'finance_bloc.dart';

@immutable
abstract class FinanceEvent {}

class GetFinanceEvent extends FinanceEvent {}

class AddIncomeEvent extends FinanceEvent {
  final FinanceModel oldFinance;
  final FinanceModel newFinance;

  AddIncomeEvent({required this.oldFinance, required this.newFinance});
}

class AddExpenseEvent extends FinanceEvent {
  final FinanceModel oldFinance;
  final FinanceModel newFinance;

  AddExpenseEvent({required this.oldFinance, required this.newFinance});
}