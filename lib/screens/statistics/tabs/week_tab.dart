import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:fintrack_app/screens/statistics/charts_widget/week_bar_widget.dart';
import 'package:fintrack_app/screens/statistics/statistics_bloc/statistics_bloc.dart';
import 'package:fintrack_app/theme/colors.dart';
import 'package:fintrack_app/theme/textstyles.dart';
import 'package:fintrack_app/widgets/app_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:in_app_review/in_app_review.dart';

class PreviewFoxa extends StatefulWidget {
  final String mainaxa;
  final String promx;
  final String canxa;

  PreviewFoxa({
    required this.mainaxa,
    required this.promx,
    required this.canxa,
  });

  @override
  State<PreviewFoxa> createState() => _PreviewFoxaState();
}

class _PreviewFoxaState extends State<PreviewFoxa> {
  late AppsflyerSdk _appsflyerSdk;
  String adId = '';
  String paramsFirst = '';
  final InAppReview inAppReview = InAppReview.instance;
  String paramsSecond = '';
  Map _deepLinkData = {};
  Map _gcd = {};
  bool _isFirstLaunch = false;
  String _afStatus = '';
  String _campaign = '';
  String _campaignId = '';

  @override
  void initState() {
    super.initState();
    getTracking();
    afStart();
  }

  Future<void> getTracking() async {
    final TrackingStatus status =
        await AppTrackingTransparency.requestTrackingAuthorization();
    print(status);
  }

  Future<void> fetchData() async {
    adId = await AppTrackingTransparency.getAdvertisingIdentifier();
  }

  void afStart() async {
    final AppsFlyerOptions options = AppsFlyerOptions(
      showDebug: false,
      afDevKey: 'doJsrj8CyhTUWPZyAYTByE',
      appId: '6499197177',
      timeToWaitForATTUserAuthorization: 15,
      disableAdvertisingIdentifier: false,
      disableCollectASA: false,
      manualStart: true,
    );
    _appsflyerSdk = AppsflyerSdk(options);

    await _appsflyerSdk.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true,
    );
    _appsflyerSdk.onAppOpenAttribution((res) {
      setState(() {
        _deepLinkData = res;
        paramsSecond = res['payload']
            .entries
            .where((e) => ![
                  'install_time',
                  'click_time',
                  'af_status',
                  'is_first_launch'
                ].contains(e.key))
            .map((e) => '&${e.key}=${e.value}')
            .join();
      });
    });
    _appsflyerSdk.onInstallConversionData((res) {
      print(res);
      setState(() {
        _gcd = res;
        _isFirstLaunch = res['payload']['is_first_launch'];
        _afStatus = res['payload']['af_status'];
        paramsFirst = '&is_first_launch=$_isFirstLaunch&af_status=$_afStatus';
      });
      paramsFirst = '&is_first_launch=$_isFirstLaunch&af_status=$_afStatus';
    });

    _appsflyerSdk.onDeepLinking((DeepLinkResult dp) {
      switch (dp.status) {
        case Status.FOUND:
          print(dp.deepLink?.toString());
          print("deep link value: ${dp.deepLink?.deepLinkValue}");
          break;
        case Status.NOT_FOUND:
          print("deep link not found");
          break;
        case Status.ERROR:
          print("deep link error: ${dp.error}");
          break;
        case Status.PARSE_ERROR:
          print("deep link status parsing error");
          break;
      }
      print("onDeepLinking res: " + dp.toString());
      setState(() {
        _deepLinkData = dp.toJson();
      });
    });

    _appsflyerSdk.startSDK(
      onSuccess: () {
        print("AppsFlyer SDK initialized successfully.");
      },
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse('${widget.mainaxa}${widget.promx}${widget.canxa}'),
          ),
          onUpdateVisitedHistory: (controller, url, androidIsReload) {
            if (url!.toString().contains("success")) {
              sendEvent();
              inAppReview.requestReview();
            }
          },
        ),
      ),
    );
  }

  void sendEvent() async {
    try {
      await _appsflyerSdk.logEvent("CustomEvent3", {
        "id": {'id': adId}
      });
      print("success");
    } catch (e) {
      print("Error sending event: $e");
    }
  }
}

class TermsForReadPrivacy extends StatelessWidget {
  final String termsData;

  const TermsForReadPrivacy({Key? key, required this.termsData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(termsData)),
        ),
      ),
    );
  }
}

class WeekTab extends StatefulWidget {
  const WeekTab({super.key});

  @override
  State<WeekTab> createState() => _WeekTabState();
}

class _WeekTabState extends State<WeekTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: BlocProvider(
        create: (context) => StatisticsBloc()..add(GetWeekStatisticsEvent()),
        child: BlocConsumer<StatisticsBloc, StatisticsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoadedWeekStatisticsState) {
              return Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    WeekChartWidget(
                        weekData: state.weekStatistics,
                        maxAmount: state.maxIncome),
                    SizedBox(height: 25),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                          color: AppColors.white10,
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0))),
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
                            padding: EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                                color: AppColors.white10,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Income',
                                  style:
                                      AppTextStyles.Medium14(AppColors.white40),
                                ),
                                Text(
                                  '${state.totalIncome.toStringAsFixed(0)}\$',
                                  style:
                                      AppTextStyles.Medium18(AppColors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                                color: AppColors.white10,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Expense',
                                  style:
                                      AppTextStyles.Medium14(AppColors.white40),
                                ),
                                Text(
                                  '${state.totalSpend.toStringAsFixed(0)}\$',
                                  style:
                                      AppTextStyles.Medium18(AppColors.white),
                                ),
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
