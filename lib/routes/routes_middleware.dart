import 'package:admin/data/repositorries/authentication/authentication_repository.dart';
import 'package:admin/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JRouteMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return AuthenticationRepository.instance.isAuthenticated
        ? null
        : const RouteSettings(name: JRoutes.login);
  }
}
