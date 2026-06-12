import 'package:admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:admin/features/personalization/screens/profile/widgets/image_and_meta.dart';
import 'package:admin/features/personalization/screens/profile/widgets/profile_form.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProfileMobileScreen extends StatelessWidget {
  const ProfileMobileScreen({super.key});

 @override
  Widget build(BuildContext context) {
   return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              JBreadcrumbsWithHeading(heading: 'Profile',
               breadcrumbItems: ['Profile']),
               SizedBox(height: JSizes.spaceBtwSections),

               Column(
               children: [
                ImageAndMeta(),
                SizedBox(width: JSizes.spaceBtwSections),
                ProfileForm(),
               ],
               ),
            ],
          ),
          ),
      ),
    );
  }
}