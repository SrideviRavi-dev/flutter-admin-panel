import 'package:admin/common/widgets/images/rounded_image.dart';
import 'package:admin/common/widgets/shimmer_effect/shimmer_effect.dart';
import 'package:admin/features/authentication/controller/user_controller.dart';
import 'package:admin/utils/constants/colors.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/constants/image_string.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:admin/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class JHeader extends StatelessWidget implements PreferredSizeWidget{
  const JHeader({super.key,  this.scaffoldkey});

  final GlobalKey<ScaffoldState>? scaffoldkey;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Container(
      decoration:const BoxDecoration(
        color: JColors.white,
        border: Border(bottom: BorderSide(color: JColors.grey,width: 1))
      ),
      padding: const EdgeInsets.symmetric(horizontal: JSizes.md,vertical: JSizes.sm),
      child: AppBar(
        leading:!JDeviceUtils.isDesktopScreen(context) ? IconButton(onPressed: () => scaffoldkey?.currentState?.openDrawer(), icon: const Icon(Iconsax.menu)) : null,
        title: JDeviceUtils.isDesktopScreen(context) ? SizedBox(
          width: 400,
          child: TextFormField(
            decoration:const InputDecoration(
              prefixIcon: Icon(Iconsax.search_normal),hintText: 'Search anything...'
            ),
          ),
        ): null ,

        /// Actions
        actions: [
         if(!JDeviceUtils.isDesktopScreen(context)) IconButton(onPressed: (){}, icon:const Icon(Iconsax.search_normal)),
         IconButton(onPressed: (){}, icon: const Icon(Iconsax.notification)),
         const SizedBox(width: JSizes.spaceBtwItems/2,),

         Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              ()=> JRoundedImage(
                width: 40,
                padding: 2,
                height: 40,
                imageType:controller.user.value.profilePicture.isNotEmpty ? ImageType.network : ImageType.asset, 
                image:controller.user.value.profilePicture.isNotEmpty ? controller.user.value.profilePicture : JImages.user,),
            ),
              const SizedBox(width: JSizes.sm),
              if(!JDeviceUtils.isMobileScreen(context))
              Obx(
                ()=> Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Text("Neshy😍",style: Theme.of(context).textTheme.titleLarge,),
                    controller.loading.value ? const JShimmerEffect(width: 50, height: 13) :  
                    Text(controller.user.value.email,style: Theme.of(context).textTheme.labelMedium,),
                  ],
                ),
              )
          ],
         )
        ],
      ),
    );
  }

  @override
  
  Size get preferredSize =>Size.fromHeight(JDeviceUtils.getAppBarHeight() + 15);

}