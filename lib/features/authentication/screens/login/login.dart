import 'package:admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:admin/features/authentication/screens/login/responsive_screens/login_desktop_tablet.dart';
import 'package:admin/features/authentication/screens/login/responsive_screens/login_mobile.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const JSiteTemplate(useLayout:  false,desktop:LoginScreenDesktopTablet() ,mobile:LoginScreenMobile() ,);
  }
}