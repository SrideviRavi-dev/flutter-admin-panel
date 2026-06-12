import 'package:admin/common/widgets/heading/section_heading.dart';
import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/common/widgets/icon/circular_icon.dart';
import 'package:admin/utils/constants/colors.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class JDashboardWidget extends StatelessWidget {
  const JDashboardWidget({
    super.key,
    required this.title,
    required this.subTitle,
    this.icon = Iconsax.arrow_up_3,
    this.color = JColors.success,
    required this.stats,
    required this.headingIcon,
    required this.headingIconColor,
    required this.headingIconBgColor,
    this.onTap,
  });

  final String title, subTitle;
  final IconData icon, headingIcon;
  final Color color, headingIconColor, headingIconBgColor;
  final int stats;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return JRoundedContainer(
      onTap: onTap,
      padding: const EdgeInsets.all(JSizes.lg),
      child: Column(
        children: [
          Row(
            children: [
              JCircularIcon(
                  icon: headingIcon,
                  backgroundColor: headingIconBgColor,
                  size: JSizes.md),
              const SizedBox(width: JSizes.spaceBtwItems),
              JSectionHeading(
                title: title,
                textColor: JColors.textSecondary,
              ),
            ],
          ),
          const SizedBox(height: JSizes.spaceBtwSections),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        Icon(
                          icon,
                          color: JColors.success,
                          size: JSizes.iconSm,
                        ),
                        Text(
                          '$stats%',
                          style: Theme.of(context).textTheme.titleLarge!.apply(
                              color: JColors.success,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 145,
                    child: Text(
                      'Compared to Dec 2025',
                      style: Theme.of(context).textTheme.labelMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
