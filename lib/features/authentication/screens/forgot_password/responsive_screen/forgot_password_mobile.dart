import 'package:admin/features/authentication/screens/forgot_password/widgets/header_form.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreenMobile extends StatelessWidget {
  const ForgotPasswordScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(JSizes.defaultSpace),
        child: HeaderAndForm(),
      )),
    );
  }
}
