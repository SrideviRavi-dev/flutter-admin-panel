import 'package:admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:admin/features/shop/models/banner_model.dart';
import 'package:admin/features/shop/screens/banner/edit_banner/widgets/edit_banner_form.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class EditBannerDesktopScreen extends StatelessWidget {
  const EditBannerDesktopScreen({super.key, required this.banner});

  final BannerModel banner;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const JBreadcrumbsWithHeading(
                  returnToPreviousScreen: true,
                  heading: 'Update Banner',
                  breadcrumbItems: [JRoutes.categories, 'Edit Banner']),
             
               const SizedBox(height: JSizes.spaceBtwSections),

               EditBannerForm(banner:banner)
           
            ],
          ),
        ),
      ),
    );
  }
}
