
import 'package:fintrack_app/screens/statistics/charts_widget/day_bar_widget.dart';
import 'package:fintrack_app/screens/statistics/statistics_bloc/statistics_bloc.dart';
import 'package:fintrack_app/theme/colors.dart';
import 'package:fintrack_app/theme/textstyles.dart';
import 'package:fintrack_app/widgets/app_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class DayTab extends StatefulWidget {
  const DayTab({super.key});

  @override
  State<DayTab> createState() => _DayTabState();
}

class _DayTabState extends State<DayTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: BlocProvider(
        create: (context) => StatisticsBloc()..add(GetDayStatisticsEvent()),
        child: BlocConsumer<StatisticsBloc, StatisticsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoadedDayStatisticsState) {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    DayChartWidget(dayData: state.dayStatistics, maxAmount: state.maxIncome),
                    SizedBox(height: 25),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                          color: AppColors.white10,
                          borderRadius: BorderRadius.all(Radius.circular(12.0))),
                      child: Column(
                        children: [
                          Text(
                            'Total amount',
                            style: AppTextStyles.Medium14(AppColors.white40),
                          ),
                          Text(
                            '${(state.totalIncome - state.totalSpend).toStringAsFixed(0)} \$',
                            style: AppHeaderStyles.SemiBold24(AppColors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical:4),
                            decoration: BoxDecoration(
                                color: AppColors.white10,
                                borderRadius: BorderRadius.all(Radius.circular(12.0))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Income', style: AppTextStyles.Medium14(AppColors.white40),),
                                Text('${state.totalIncome.toStringAsFixed(0)}\$', style: AppTextStyles.Medium18(AppColors.white),),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical:4),
                            decoration: BoxDecoration(
                                color: AppColors.white10,
                                borderRadius: BorderRadius.all(Radius.circular(12.0))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Expense', style: AppTextStyles.Medium14(AppColors.white40),),
                                Text('${state.totalSpend.toStringAsFixed(0)}\$', style: AppTextStyles.Medium18(AppColors.white),),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
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
