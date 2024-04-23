

import 'package:fintrack_app/theme/colors.dart';
import 'package:flutter/material.dart';

class AppContainer extends StatelessWidget {
  final Widget child;
  const AppContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: AppColors.white10,
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      child: child,
    );
  }
}
