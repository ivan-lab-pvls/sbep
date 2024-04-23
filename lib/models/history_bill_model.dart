
import 'package:fintrack_app/models/finance_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'history_bill_model.g.dart';

@HiveType(typeId: 2)
class HistoryBillModel {
  @HiveField(0)
  final String category;
  @HiveField(1)
  final int amount;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final FinanceType type;

  HistoryBillModel({required this.category, required this.amount, required this.date, required this.type});
}