import 'package:admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:admin/features/authentication/screens/forgot_password/responsive_screen/forgot_password_desktop_tablet.dart';
import 'package:admin/features/authentication/screens/forgot_password/responsive_screen/forgot_password_mobile.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const JSiteTemplate(useLayout: false,desktop: ForgotPasswordScreenDesktopTablet(),mobile: ForgotPasswordScreenMobile(),);
  }
}