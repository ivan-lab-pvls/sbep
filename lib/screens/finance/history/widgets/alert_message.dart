import 'package:fintrack_app/theme/colors.dart';
import 'package:fintrack_app/theme/textstyles.dart';
import 'package:fintrack_app/widgets/app_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AlertMessage extends StatelessWidget {
  const AlertMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset(
              'assets/images/elements/alert.svg'),
          SizedBox(
            width: 300,
            child: Text(
              'Income end expense history is empty, your added income and expenses will appear here. ',
              style: AppTextStyles.Medium16(AppColors.white40),
            ),
          ),
        ],
      ),
    );
  }
}
