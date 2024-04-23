import 'package:auto_route/auto_route.dart';
import 'package:fintrack_app/models/news_model.dart';
import 'package:fintrack_app/theme/colors.dart';
import 'package:fintrack_app/theme/textstyles.dart';
import 'package:flutter/material.dart';

@RoutePage()
class NewsInfoScreen extends StatefulWidget {
  final NewsModel news;

  const NewsInfoScreen({super.key, required this.news});

  @override
  State<NewsInfoScreen> createState() => _NewsInfoScreenState();
}

class _NewsInfoScreenState extends State<NewsInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.black,
        centerTitle: true,
        title: Text(
          'News',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: Image.asset(
                    fit: BoxFit.cover,
                    widget.news.image,
                    height: 175,
                    width: double.infinity,

                  ),
                ),
                SizedBox(height: 15),
                Column(
                  children: [
                    Text(
                      widget.news.title,
                      style: AppHeaderStyles.Bold24(AppColors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.news.article,
                      style: AppTextStyles.Medium18(AppColors.white40),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}