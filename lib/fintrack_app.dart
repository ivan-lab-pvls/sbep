import 'package:fintrack_app/router/router.dart';
import 'package:flutter/material.dart';

class FinTrackApp extends StatelessWidget {
  FinTrackApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(fontFamily: 'SF Pro Display'),
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: false,
    );
  }
}
