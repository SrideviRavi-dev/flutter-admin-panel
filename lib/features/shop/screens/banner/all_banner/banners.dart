import 'package:admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:admin/features/shop/screens/banner/all_banner/responsive_screens/banners_desktop_screen.dart';
import 'package:admin/features/shop/screens/banner/all_banner/responsive_screens/banners_mobile_screen.dart';
import 'package:admin/features/shop/screens/banner/all_banner/responsive_screens/banners_tablet_screen.dart';
import 'package:flutter/material.dart';

class BannersScreen extends StatelessWidget {
  const BannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const JSiteTemplate(
      desktop: BannersDesktopScreen(),
      tablet: BannersTabletScreen(),
      mobile: BannersMobileScreen(),
    );
  }
}