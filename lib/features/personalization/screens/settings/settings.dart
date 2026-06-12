import 'package:admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:admin/features/personalization/screens/settings/responsive_screens/settings_desktop_screen.dart';
import 'package:admin/features/personalization/screens/settings/responsive_screens/settings_mobile_screen.dart';
import 'package:admin/features/personalization/screens/settings/responsive_screens/settings_tablet_screen.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return JSiteTemplate(
      desktop: SettingsDesktopScreen(),
      tablet: SettingsTabletScreen(),
      mobile: SettingsMobileScreen(),
    );
  }
}
