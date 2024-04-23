import 'package:auto_route/auto_route.dart';
import 'package:fintrack_app/models/finance_model.dart';
import 'package:fintrack_app/router/router.dart';
import 'package:fintrack_app/screens/finance/finance_bloc/finance_bloc.dart';
import 'package:fintrack_app/screens/finance/widgets/add_button_widget.dart';
import 'package:fintrack_app/theme/colors.dart';
import 'package:fintrack_app/theme/textstyles.dart';
import 'package:fintrack_app/widgets/app_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class FinanceListScreen extends StatefulWidget {
  const FinanceListScreen({super.key});

  @override
  State<FinanceListScreen> createState() => _FinanceListScreenState();
}

class _FinanceListScreenState extends State<FinanceListScreen> {

  final pageController = PageController();
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: BlocProvider(
        create: (context) => FinanceBloc()..add(GetFinanceEvent()),
        child: BlocConsumer<FinanceBloc, FinanceState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoadedFinanceListState) {
              return SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Balance', style: AppTextStyles.Medium14(AppColors.white40),),
                                  Text('${state.balance}\$', style: AppHeaderStyles.SemiBold24(AppColors.white),),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (_pageIndex == 1) {
                                        pageController.previousPage(duration: Duration(milliseconds: 500),
                                            curve: Curves.ease);
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                                      decoration: BoxDecoration(
                                          color: _pageIndex == 0 ? AppColors.white40 : AppColors.white10,
                                          border: Border.all(color: Colors.transparent),
                                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                                      child: Center(
                                        child: Text('Income', style: AppTextStyles.Medium14(_pageIndex == 0 ? AppColors.accentGreen : AppColors.white40),),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  GestureDetector(
                                    onTap: () {
                                      if (_pageIndex == 0) {
                                        pageController.nextPage(duration: Duration(milliseconds: 500),
                                            curve: Curves.ease);
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                                      decoration: BoxDecoration(
                                          color:  _pageIndex == 1 ? AppColors.white40 : AppColors.white10,
                                          border: Border.all(color: Colors.transparent),
                                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                                      child: Center(
                                        child: Text('Expense', style: AppTextStyles.Regular14(_pageIndex == 1 ? AppColors.accentGreen : AppColors.white40),),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Container(
                                  width:  MediaQuery.of(context).size.width * 0.4,
                                  padding: EdgeInsets.symmetric(vertical:4),
                                  decoration: BoxDecoration(
                                      color: AppColors.white10,
                                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text('Income', style: AppTextStyles.Medium14(AppColors.white40),),
                                      Text('${state.incomeValue}\$', style: AppTextStyles.Medium18(AppColors.white),),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 20,),
                              Expanded(
                                child: Container(
                                  width:  MediaQuery.of(context).size.width * 0.4,
                                  padding: EdgeInsets.symmetric(vertical:4),
                                  decoration: BoxDecoration(
                                      color: AppColors.white10,
                                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text('Expense', style: AppTextStyles.Medium14(AppColors.white40),),
                                      Text('${state.expenseValue}\$', style: AppTextStyles.Medium18(AppColors.white),),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(

                      child: PageView(
                        controller: pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _pageIndex = index;
                          });
                        },
                        children: [
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Income category', style: AppTextStyles.Medium18(AppColors.white40),),
                                  ListView.separated(
                                      padding: EdgeInsets.symmetric(vertical: 16),
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: state.incomes.length,
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final FinanceModel _income =
                                        state.incomes[index];
                                        return AppContainer(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  SvgPicture.asset('assets/images/finance/${_income.category.toLowerCase()}.svg'),
                                                  SizedBox(width: 10),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        _income.category,
                                                        style: AppTextStyles.Medium16(AppColors.white40),
                                                      ),
                                                      Text(
                                                        '${_income.value}\$',
                                                        style: AppTextStyles.Medium18(AppColors.white),

                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              AddButtonWidget(text: 'Add Income', width: 150, onTap: () {
                                                context.router.push(AddIncomeRoute(finance: _income));
                                              }),
                                            ],
                                          ),
                                        );
                                      }),
                                ],
                              ),
                            ),
                          ),

                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Expense category', style: AppTextStyles.Medium18(AppColors.white40),),
                                  ListView.separated(
                                      padding: EdgeInsets.symmetric(vertical: 16),
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: state.expenses.length,
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final FinanceModel _expense =
                                        state.expenses[index];
                                        return AppContainer(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  SvgPicture.asset('assets/images/finance/${_expense.category.toLowerCase()}.svg'),
                                                  SizedBox(width: 10),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        _expense.category,
                                                        style: AppTextStyles.Medium16(AppColors.white40),
                                                      ),
                                                      Text(
                                                        '${_expense.value}\$',
                                                        style: AppTextStyles.Medium18(AppColors.white),

                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              AddButtonWidget(text: 'Add Expense', width: 150, onTap: () {
                                                context.router.push(AddExpenseRoute(finance: _expense));
                                              }),
                                            ],
                                          ),
                                        );
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
