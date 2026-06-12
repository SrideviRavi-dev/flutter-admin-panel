// ignore_for_file: avoid_renaming_method_parameters

import 'package:admin/common/widgets/layouts/sidebars/sidebar_controller.dart';
import 'package:admin/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteObserver extends GetObserver {
  @override
  void didPop(Route<dynamic>? route, Route<dynamic>? previosRoute) {
    final sidebarController = Get.put(SidebarController());
    if(previosRoute != null){
      for(var routeName in JRoutes.sidebarMenuItems){
        if(previosRoute.settings.name == routeName){
          sidebarController.activeItem.value = routeName;
        }
      }
    }
  }
}
