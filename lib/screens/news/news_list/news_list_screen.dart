import 'package:auto_route/auto_route.dart';
import 'package:fintrack_app/models/news_model.dart';
import 'package:fintrack_app/repository/news_repository.dart';
import 'package:fintrack_app/router/router.dart';
import 'package:fintrack_app/theme/colors.dart';
import 'package:fintrack_app/theme/textstyles.dart';
import 'package:fintrack_app/widgets/app_container.dart';
import 'package:flutter/material.dart';

@RoutePage()
class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'News',
                    textAlign: TextAlign.center,
                    style: AppHeaderStyles.SemiBold24(AppColors.white),
                  ),
                ),
                ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: newsRepository.length,
                  separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                    height: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final NewsModel _news = newsRepository[index];
                    return AppContainer(
                      child: GestureDetector(
                        onTap: () {
                          context.router.push(NewsInfoRoute(news: _news));
                        },
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius:
                              BorderRadius.all(Radius.circular(12)),
                              child: Image.asset(
                                _news.image,
                                fit: BoxFit.cover,
                                height: 95,
                                width: double.infinity,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              _news.title,
                              style: AppTextStyles.Medium18(AppColors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
