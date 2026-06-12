import 'package:admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:admin/features/media/screens/media/responsive_screens/media_desktop.dart';
import 'package:flutter/material.dart';

class MediaScreen extends StatelessWidget {
  const MediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const JSiteTemplate(desktop: MediaDesktopScreen());
  }
}