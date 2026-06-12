import 'package:admin/common/widgets/images/circular_images.dart';
import 'package:admin/common/widgets/layouts/sidebars/menu/menu_item.dart';
import 'package:admin/features/personalization/controllers/settings_controller.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/utils/constants/colors.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/constants/image_string.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class JSideBar extends StatelessWidget {
  const JSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const BeveledRectangleBorder(),
      child: Container(
        decoration: const BoxDecoration(
            color: JColors.white,
            border: Border(right: BorderSide(color: JColors.grey, width: 1))),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Obx(
                  ()=>  JCircularImage(
                      padding: 0,
                      width: 60,
                      height: 60,
                      backgroundColor: Colors.transparent,
                      imageType: SettingsController.instance.settings.value.appLogo.isNotEmpty ? ImageType.network : ImageType.asset,
                       image: SettingsController.instance.settings.value.appLogo.isNotEmpty
                       ?SettingsController.instance.settings.value.appLogo
                       : JImages.logo,

                    ),
                  ),
                  Expanded(
                    child: Obx(
                      ()=> Text(SettingsController.instance.settings.value.appName,
                      style: Theme.of(context).textTheme.headlineLarge,
                      overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: JSizes.spaceBtwSections,
              ),
              Padding(
                padding: const EdgeInsets.all(JSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'MENU',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .apply(letterSpacingDelta: 1.2),
                    ),
                    const JMenuItem(route: JRoutes.dashboard, icon: Iconsax.status,itemName: 'Dashboard'),
                    const JMenuItem(route: JRoutes.media, icon: Iconsax.image,itemName: 'Media'),
                    const JMenuItem(route: JRoutes.categories, icon: Iconsax.category_2,itemName: 'Categories'),
                    const JMenuItem(route: JRoutes.banners, icon: Iconsax.picture_frame,itemName: 'Banners'),
                    const JMenuItem(route: JRoutes.products, icon: Iconsax.bag,itemName: 'Products'),
                    const JMenuItem(route: JRoutes.customers, icon: Iconsax.profile_2user,itemName: 'Customers'),
                    const JMenuItem(route: JRoutes.orders, icon: Iconsax.box,itemName: 'Orders'),
                    const JMenuItem(route: JRoutes.returns, icon: Iconsax.car,itemName: 'Returns'),
                   Text(
                      'OTHERS',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .apply(letterSpacingDelta: 1.2),
                    ),
                    const JMenuItem(route: JRoutes.profile, icon: Iconsax.user,itemName: 'Profile'),
                    const JMenuItem(route: JRoutes.settings, icon: Iconsax.setting_2,itemName: 'Settings'),
                    const JMenuItem(route: JRoutes.logout, icon: Iconsax.logout,itemName: 'Logout'),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
