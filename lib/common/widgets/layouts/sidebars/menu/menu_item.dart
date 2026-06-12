import 'package:admin/common/widgets/layouts/sidebars/sidebar_controller.dart';
import 'package:admin/utils/constants/colors.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JMenuItem extends StatelessWidget {
  const JMenuItem({
    super.key,
    required this.route,
    required this.icon,
    required this.itemName,
  });
  final String route;
  final IconData icon;
  final String itemName;
  @override
  Widget build(BuildContext context) {
    final menuController = Get.put(SidebarController());
    return InkWell(
      onTap:()=> menuController.menuOnTap(route),
      onHover:(hovering)=> hovering  ? menuController.changeHoverItem(route) : menuController.changeHoverItem('') ,
      child: Obx(
        ()=> Padding(
          padding: const EdgeInsets.symmetric(vertical: JSizes.xs),
          child: Container(
            decoration: BoxDecoration(
              color:menuController.isHovering(route) || menuController.isActive(route) ? JColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(JSizes.cardRadiusMd),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Padding(
                  padding:const EdgeInsets.only(
                      left: JSizes.lg,
                      top: JSizes.md,
                      bottom: JSizes.md,
                      right: JSizes.md),
                  child:menuController.isActive(route) ? Icon(icon,size: 22, color: JColors.white) :
                   Icon(icon, size: 22,color: menuController.isHovering(route) ? JColors.white : JColors.darkGrey),
                ),
                if(menuController.isHovering(route)|| menuController.isActive(route))
                Flexible(
                  child: Text(
                    itemName,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .apply(color: JColors.white),
                  ),
                )
                else
                 Flexible(
                  child: Text(
                    itemName,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .apply(color: JColors.darkerGrey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
