import 'package:admin/common/widgets/layouts/templates/login_tamplate.dart';
import 'package:admin/features/authentication/screens/reset_password/widgets/reset_password_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreenDesktopTablet extends StatelessWidget {
  const ResetPasswordScreenDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    
    return const JLoginTamplate(
      child: ResetPasswordWidget(),
    );
  }
}

