import 'package:admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:admin/features/shop/screens/banner/create_banner/reponsive_screens/create_banner_desktop_screen.dart';
import 'package:admin/features/shop/screens/banner/create_banner/reponsive_screens/create_banner_mobile_screen.dart';
import 'package:admin/features/shop/screens/banner/create_banner/reponsive_screens/create_banner_tablet_screen.dart';
import 'package:flutter/material.dart';

class CreateBannerScreen extends StatelessWidget {
  const CreateBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const JSiteTemplate(
      desktop:CreateBannerDesktopScreen(),
      tablet: CreateBannerTabletScreen(),
      mobile:CreateBannerMobileScreen() ,
    );
  }
}