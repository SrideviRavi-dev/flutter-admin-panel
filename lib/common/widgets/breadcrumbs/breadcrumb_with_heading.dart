import 'package:admin/common/widgets/breadcrumbs/page_heading.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class JBreadcrumbsWithHeading extends StatelessWidget {
  const JBreadcrumbsWithHeading(
      {super.key,
      required this.heading,
      required this.breadcrumbItems,
       this.returnToPreviousScreen = false});

  final String heading;

  final List<String> breadcrumbItems;

  final bool returnToPreviousScreen;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () => Get.offAllNamed(JRoutes.dashboard),
              child: Padding(
                padding: const EdgeInsets.all(JSizes.xs),
                child: Text(
                  'Dashboard',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .apply(fontWeightDelta: -1),
                ),
              ),
            ),
            for (int i = 0; i < breadcrumbItems.length; i++)
              Row(
                children: [
                  const Text('/'),
                  InkWell(
                    onTap: i == breadcrumbItems.length - 1
                        ? null
                        : () => Get.toNamed(breadcrumbItems[i]),
                    child: Padding(
                      padding: const EdgeInsets.all(JSizes.xs),
                      child: Text(
                        i == breadcrumbItems.length - 1
                            ? breadcrumbItems[i].capitalize.toString()
                            : capitalize(breadcrumbItems[i].substring(1)),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .apply(fontWeightDelta: -1),
                      ),
                    ),
                  ),
                ],
              )
          ],
        ),
        const SizedBox(
          height: JSizes.sm,
        ),

        Row(
          children: [
            if(returnToPreviousScreen) IconButton(onPressed: ()=> Get.back(), icon: const Icon(Iconsax.arrow_left)),
            if(returnToPreviousScreen) const SizedBox(width: JSizes.spaceBtwItems,),
            JPageHeading(heading:heading ),
          ],
        )
      ],
    );
  }

  String capitalize(String s) {
    return s.isEmpty ? '' : s[0].toUpperCase() + s.substring(1);
  }
}
