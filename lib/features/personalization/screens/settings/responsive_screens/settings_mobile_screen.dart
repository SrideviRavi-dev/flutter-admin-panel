import 'package:admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:admin/features/personalization/screens/settings/widgets/image_meta.dart';
import 'package:admin/features/personalization/screens/settings/widgets/settings_form.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SettingsMobileScreen extends StatelessWidget {
  const SettingsMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              JBreadcrumbsWithHeading(heading: 'Setttings',
               breadcrumbItems: ['Settings']),
               SizedBox(height: JSizes.spaceBtwSections),

               Row(crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                Expanded(child: ImageAndMeta()),
                SizedBox(width: JSizes.spaceBtwSections),
                Expanded(flex: 2,child: SettingsForm()),
               ],
               ),
            ],
          ),
          ),
      ),
    );
}
}