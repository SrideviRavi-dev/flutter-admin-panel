import 'package:admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:admin/features/shop/screens/banner/edit_banner/responsive_screens/edit_banner_desktop_screen.dart';
import 'package:admin/features/shop/screens/banner/edit_banner/responsive_screens/edit_banner_mobile_screen.dart';
import 'package:admin/features/shop/screens/banner/edit_banner/responsive_screens/edit_banner_tablet_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditBannerScreen extends StatelessWidget {
  const EditBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final banner = Get.arguments;
    return JSiteTemplate(
      desktop: EditBannerDesktopScreen(banner: banner,),
      tablet: EditBannerTabletScreen(banner: banner,),
      mobile: EditBannerMobileScreen(banner: banner,), 
    );
  }
}