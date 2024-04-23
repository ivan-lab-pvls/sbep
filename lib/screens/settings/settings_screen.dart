import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:device_info/device_info.dart';
import 'package:fintrack_app/screens/finance/add_expense/add_expense_screen.dart';
import 'package:fintrack_app/screens/settings/widgets/settings_tile.dart';
import 'package:fintrack_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Settings',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white),
                ),
              ),
              SizedBox(height: 15),
              SettingsTile(
                  title: 'Share with friends',
                  icon: 'assets/images/settings/share.svg',
                  onTap: () {
                    _onTapShare();
                  }),
              SizedBox(height: 15),
              SettingsTile(
                  title: 'Rate App',
                  icon: 'assets/images/settings/subs.svg',
                  onTap: () {
                    InAppReview.instance
                        .openStoreListing(appStoreId: '6499197177');
                  }),
              SizedBox(height: 15),
              SettingsTile(
                  title: 'Terms of use',
                  icon: 'assets/images/settings/terms.svg',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const ShowTermsAndPrivacy(
                          usage:
                              'https://docs.google.com/document/d/1kyxpXm_EDjlBshgShRXjDhD7aVna8ydYHEjJA5TbvfY/edit?usp=sharing',
                        ),
                      ),
                    );
                  }),
              SizedBox(height: 15),
              SettingsTile(
                  title: 'Privacy Policy',
                  icon: 'assets/images/settings/privacy.svg',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const ShowTermsAndPrivacy(
                          usage:
                              'https://docs.google.com/document/d/1XrsVS0qouD366LwbVT_4cB0RGjWr7Bl2fmXX_Cqp7fw/edit?usp=sharing',
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _onTapShare() async {
  final deviceData = DeviceInfoPlugin();
  if (Platform.isIOS) {
    final iosDeviceInfo = await deviceData.iosInfo;
    if (iosDeviceInfo.model.contains('iPad')) {
      _checkIpadAvailable();
    } else {
      Share.share(
          'Download The Cbep: My Pocket in AppStore! https://apps.apple.com/us/app/the-cbep-my-pocket/id6499197177');
    }
  } else {
    _checkIpadAvailable();
  }
}

Future<void> _checkIpadAvailable() async {
  const link = 'https://apps.apple.com/us/app/the-cbep-my-pocket/id6499197177';
  if (await canLaunch(link)) {
    await launch(link);
  } else {
    throw 'Could not launch $link';
  }
}
