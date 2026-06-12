import 'package:admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:admin/common/widgets/screens/desktop.dart';
import 'package:admin/common/widgets/screens/mobile.dart';
import 'package:admin/common/widgets/screens/tablet.dart';
import 'package:flutter/material.dart';

class ResponsiveDesignScreen extends StatelessWidget {
  const ResponsiveDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  const JSiteTemplate(desktop: Desktop(),tablet: Tablet(),mobile: Mobile(),);
  }
}
