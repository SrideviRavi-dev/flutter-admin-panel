import 'package:flutter/material.dart';

class JResponsiveWidget extends StatelessWidget {
  const JResponsiveWidget({super.key, required this.desktop, required this.tablet, required this.mobile});

  final Widget desktop;
  final Widget tablet;
  final Widget mobile;


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        if (constraints.maxWidth >= 1366){
          return desktop;
        }else if(constraints.maxWidth >= 1366 && constraints.maxWidth >= 768){
          return tablet;
        }else{
          return mobile;
        }
      },
    );
  }
}