import 'package:admin/common/widgets/layouts/headers/header.dart';
import 'package:admin/common/widgets/layouts/sidebars/sidebar.dart';
import 'package:flutter/material.dart';

class TabletLayout extends StatelessWidget {
   TabletLayout({super.key, this.body});

  final Widget? body;
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      drawer:const JSideBar(),
      appBar: JHeader(scaffoldkey: scaffoldkey),
      body: body ?? const SizedBox(),
    );
  }
}
