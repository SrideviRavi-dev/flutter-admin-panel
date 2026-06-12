import 'package:admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:admin/features/authentication/screens/reset_password/reponsive_screens/reset_password_desktop_tablet.dart';
import 'package:admin/features/authentication/screens/reset_password/reponsive_screens/reset_password_mobile.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const JSiteTemplate(useLayout: false,desktop: ResetPasswordScreenDesktopTablet(),mobile: ResetPasswordScreenMobile(),);
  }
}