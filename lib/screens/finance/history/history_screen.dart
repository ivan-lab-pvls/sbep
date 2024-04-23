import 'package:fintrack_app/models/finance_model.dart';
import 'package:fintrack_app/models/history_bill_model.dart';
import 'package:fintrack_app/screens/finance/history/widgets/alert_message.dart';
import 'package:fintrack_app/theme/colors.dart';
import 'package:fintrack_app/theme/textstyles.dart';
import 'package:fintrack_app/widgets/app_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<HistoryBillModel> filteredList = [];
  List<HistoryBillModel> allList = [];
  List<HistoryBillModel> incomeList = [];
  List<HistoryBillModel> expenseList = [];

  @override
  void initState() {
    getIncomeHistory();
    getExpenseHistory();
    getAllHistory();
    filteredList = allList.reversed.toList();
    super.initState();
  }

  void getIncomeHistory() {
    final List<FinanceModel> incomes = [];
    final incomesBox = Hive.box('incomes');

    if (incomesBox.isNotEmpty) {
      for (int i = 0; i < incomesBox.length; i++) {
        incomes.add(incomesBox.getAt(i));
      }

      for (FinanceModel income in incomes) {
        incomeList.addAll(income.history);
      }
      incomeList.sort((a, b) => a.date.compareTo(b.date));
    }
  }

  void getExpenseHistory() {
    final List<FinanceModel> expenses = [];
    final expensesBox = Hive.box('expenses');

    if (expensesBox.isNotEmpty) {
      for (int i = 0; i < expensesBox.length; i++) {
        expenses.add(expensesBox.getAt(i));
      }

      for (FinanceModel expense in expenses) {
        expenseList.addAll(expense.history);
      }
      expenseList.sort((a, b) => a.date.compareTo(b.date));
    }
  }

  void getAllHistory() {
    allList.addAll(incomeList);
    allList.addAll(expenseList);
    allList.sort((a, b) => a.date.compareTo(b.date));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('History',
                        style: AppHeaderStyles.SemiBold24(AppColors.white)),
                    allList.isEmpty
                        ? SizedBox(width: 5)
                        : GestureDetector(
                            onTap: () {
                              showCupertinoModalPopup<void>(
                                context: context,
                                builder: (BuildContext context) =>
                                    CupertinoActionSheet(
                                  actions: <CupertinoActionSheetAction>[
                                    CupertinoActionSheetAction(
                                      onPressed: () {
                                        setState(() {
                                          filteredList =
                                              allList.reversed.toList();
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: const Text('All'),
                                    ),
                                    CupertinoActionSheetAction(
                                      onPressed: () {
                                        setState(() {
                                          filteredList =
                                              incomeList.reversed.toList();
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Income'),
                                    ),
                                    CupertinoActionSheetAction(
                                      onPressed: () {
                                        setState(() {
                                          filteredList =
                                              expenseList.reversed.toList();
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Expenses'),
                                    ),
                                    CupertinoActionSheetAction(
                                      isDestructiveAction: true,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              decoration: BoxDecoration(
                                  color: AppColors.white10,
                                  border: Border.all(color: Colors.transparent),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              child: Center(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images/elements/filter.svg'),
                                    SizedBox(width: 5),
                                    Text(
                                      'History',
                                      style: AppTextStyles.Medium14(
                                          AppColors.accentGreen),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
                SizedBox(height: 20),
                allList.isEmpty
                    ? AlertMessage()
                    : ListView.separated(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: filteredList.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          height: 10,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          final HistoryBillModel _bill = filteredList[index];
                          return AppContainer(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images/finance/${_bill.category.toLowerCase()}.svg'),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _bill.category,
                                          style: AppTextStyles.Medium16(
                                              AppColors.white),
                                        ),
                                        Text(
                                          _bill.type == FinanceType.income
                                              ? 'Income'
                                              : 'Expense',
                                          style: AppTextStyles.Medium14(
                                              AppColors.white40),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  _bill.type == FinanceType.income
                                      ? '+${_bill.amount}\$'
                                      : '-${_bill.amount}\$',
                                  style:
                                      AppTextStyles.Medium16(AppColors.white),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
