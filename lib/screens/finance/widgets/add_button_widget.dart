import 'package:fintrack_app/theme/colors.dart';
import 'package:flutter/material.dart';

class AddButtonWidget extends StatelessWidget {
  final String text;
  final double width;
  final void Function()? onTap;

  const AddButtonWidget(
      {super.key,
      required this.text,
      required this.width,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        width: width,
        decoration: BoxDecoration(
            color: AppColors.white10,
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.add,
                color: AppColors.accentGreen,
              ),
              SizedBox(width: 5),
              Text(
                text,
                style: TextStyle(
                  color: AppColors.accentGreen,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
