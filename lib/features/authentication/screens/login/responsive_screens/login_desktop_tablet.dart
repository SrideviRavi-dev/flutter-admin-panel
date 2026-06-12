import 'package:admin/common/widgets/layouts/templates/login_tamplate.dart';
import 'package:admin/features/authentication/screens/login/widgets/login_form.dart';
import 'package:admin/features/authentication/screens/login/widgets/login_header.dart';
import 'package:flutter/material.dart';

class LoginScreenDesktopTablet extends StatelessWidget {
  const LoginScreenDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const JLoginTamplate(child: Column(
      children: [
        JLoginHeader(),
        LoginForm(),
      ],
     ),
    );
  }
}

