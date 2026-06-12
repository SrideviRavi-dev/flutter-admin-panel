import 'package:admin/common/widgets/loader/animation_loader.dart';
import 'package:admin/common/widgets/loader/circular_loader.dart';
import 'package:admin/utils/constants/colors.dart';
import 'package:admin/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JFullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: JHelperFunction.isDarkMode(Get.context!)
              ? JColors.dark
              : JColors.white,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
               children: [
                const SizedBox(
                  height: 250,
                ),
                JAnimationLoaderWidget(text: text, animation: animation),
              ],
            ),
          ),
        ),
      ),
    );
  }
   
   static void popUpCircular(){
    Get.defaultDialog(
      title: '',
      onWillPop: () async => false,
      content: const JCircularLoader(),
      backgroundColor: Colors.transparent,
    );
   }

   static stopLoading(){
    Navigator.of(Get.overlayContext!).pop();
  }

}
