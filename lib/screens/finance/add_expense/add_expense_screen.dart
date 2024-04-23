import 'package:auto_route/auto_route.dart';
import 'package:fintrack_app/models/history_bill_model.dart';
import 'package:fintrack_app/router/router.dart';
import 'package:fintrack_app/screens/finance/finance_bloc/finance_bloc.dart';
import 'package:fintrack_app/theme/colors.dart';
import 'package:fintrack_app/widgets/action_button_widget.dart';
import 'package:fintrack_app/widgets/icon_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fintrack_app/models/finance_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ShowTermsAndPrivacy extends StatelessWidget {
  final String usage;

  const ShowTermsAndPrivacy({Key? key, required this.usage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.arrow_left, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(usage)),
        ),
      ),
    );
  }
}

@RoutePage()
class AddExpenseScreen extends StatefulWidget {
  final FinanceModel finance;

  const AddExpenseScreen({super.key, required this.finance});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final expenseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.black,
        centerTitle: true,
        title: Text(
          'Add Expense',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconContainer(
                      icon:
                          'assets/images/finance/${widget.finance.category.toLowerCase()}.svg'),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      style: TextStyle(color: AppColors.white),
                      controller: expenseController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '0,00\$',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: AppColors.white40,
                        ),
                        filled: true,
                        fillColor: AppColors.white10,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              ActionButtonWidget(
                  text: 'Add Expense',
                  width: double.infinity,
                  onTap: () {
                    if (expenseController.text.isNotEmpty &&
                        int.tryParse(expenseController.text) != null) {
                      final FinanceModel newFinance = widget.finance;
                      newFinance.value += int.parse(expenseController.text);

                      newFinance.history.insert(
                          0,
                          HistoryBillModel(
                              category: widget.finance.category,
                              amount: int.parse(expenseController.text),
                              date: DateTime.now(),
                              type: widget.finance.type));

                      context.read<FinanceBloc>().add(AddExpenseEvent(
                          oldFinance: widget.finance, newFinance: newFinance));

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: AppColors.accentGreen,
                          content: Text(
                            'Expense successfully added!',
                            style: TextStyle(color: AppColors.black),
                          ),
                        ),
                      );

                      context.router.push(MainRoute());
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: AppColors.accentGreen,
                          content: Text(
                            'Firstly, enter correct information',
                            style: TextStyle(color: AppColors.black),
                          ),
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
