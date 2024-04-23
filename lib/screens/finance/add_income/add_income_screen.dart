import 'package:auto_route/auto_route.dart';
import 'package:fintrack_app/models/finance_model.dart';
import 'package:fintrack_app/models/history_bill_model.dart';
import 'package:fintrack_app/router/router.dart';
import 'package:fintrack_app/screens/finance/finance_bloc/finance_bloc.dart';
import 'package:fintrack_app/theme/colors.dart';
import 'package:fintrack_app/widgets/action_button_widget.dart';
import 'package:fintrack_app/widgets/icon_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AddIncomeScreen extends StatefulWidget {
  final FinanceModel finance;

  const AddIncomeScreen({super.key, required this.finance});

  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  final incomeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.black,
        centerTitle: true,
        title: Text(
          'Add Income',
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
                      icon: 'assets/images/finance/${widget.finance.category
                          .toLowerCase()}.svg'),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      style: TextStyle(color: AppColors.white),
                      controller: incomeController,
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
                  text: 'Add Income', width: double.infinity, onTap: () {
                if (incomeController.text.isNotEmpty &&
                    int.tryParse(incomeController.text) != null) {
                  final FinanceModel newFinance = widget.finance;
                  newFinance.value += int.parse(incomeController.text);

                  newFinance.history.insert(0, HistoryBillModel(
                      category: widget.finance.category,
                      amount: int.parse(incomeController.text),
                      date: DateTime.now(),
                      type: widget.finance.type));

                  context.read<FinanceBloc>().add(AddIncomeEvent(
                      oldFinance: widget.finance,
                      newFinance: newFinance));

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppColors.accentGreen,
                      content: Text(
                        'Income successfully added!',
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
