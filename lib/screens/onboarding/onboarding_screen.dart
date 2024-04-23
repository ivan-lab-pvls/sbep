import 'package:auto_route/auto_route.dart';
import 'package:fintrack_app/router/router.dart';
import 'package:fintrack_app/theme/colors.dart';
import 'package:fintrack_app/widgets/action_button_widget.dart';
import 'package:flutter/material.dart';

import '../../theme/textstyles.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              SizedBox(
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/onboarding/image.png'),
                    Text(
                      'Manage your finances with ease.',
                      style: AppHeaderStyles.SemiBold32(AppColors.white),
                    ),
                    Text(
                      'Manage your money easily and efficiently with our budgeting and investing app',
                      style: AppTextStyles.Medium16(AppColors.white40),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  ActionButtonWidget(
                      text: 'Get Started', width: double.infinity, onTap: () {
                        context.router.push(MainRoute());
                  }),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Terms of Use',
                          style: AppTextStyles.Regular14(AppColors.white40),
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        '/',
                        style: AppTextStyles.Regular14(AppColors.white40),
                      ),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Privacy Policy',
                          style: AppTextStyles.Regular14(AppColors.white40),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
