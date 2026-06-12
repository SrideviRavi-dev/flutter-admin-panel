import 'package:admin/common/widgets/layouts/templates/login_tamplate.dart';
import 'package:admin/features/authentication/screens/forgot_password/widgets/header_form.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreenDesktopTablet extends StatelessWidget {
  const ForgotPasswordScreenDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const JLoginTamplate(
      child: HeaderAndForm(),
    );
  }
}

