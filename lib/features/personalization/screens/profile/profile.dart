import 'package:admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:admin/features/personalization/screens/profile/responsive_screen/profile_desktop_screen.dart';
import 'package:admin/features/personalization/screens/profile/responsive_screen/profile_mobile_screen.dart';
import 'package:admin/features/personalization/screens/profile/responsive_screen/profile_tablet_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const JSiteTemplate(
      desktop: ProfileDesktopScreen(),
      tablet: ProfileTabletScreen(),
      mobile: ProfileMobileScreen(),
    );
  }
}