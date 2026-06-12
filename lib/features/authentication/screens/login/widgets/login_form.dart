import 'package:admin/features/authentication/controller/login_controller.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:admin/utils/constants/text_strings.dart';
import 'package:admin/utils/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
        key: controller.loginFormKey,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: JSizes.spaceBtwSections),
          child: Column(
            children: [
              /// E-mail
              TextFormField(
                controller: controller.email,
                validator: JValidator.validateEmail,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: JTexts.email,
                ),
              ),
              const SizedBox(height: JSizes.spaceBtwInputFields),

              /// Password
              Obx(
                () => TextFormField(
                  controller: controller.password,
                  validator: (value) =>
                      JValidator.validateEmptyText('Password', value),
                  obscureText: controller.hidePassword.value,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.password_check),
                    suffixIcon: IconButton(
                        onPressed: () => controller.hidePassword.value =
                            !controller.hidePassword.value,
                        icon: Icon(controller.hidePassword.value
                            ? Iconsax.eye_slash
                            : Iconsax.eye)),
                    labelText: JTexts.password,
                  ),
                ),
              ),
              const SizedBox(height: JSizes.spaceBtwInputFields / 2),

              /// Remember me & forget Password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(() => Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: (value) =>
                              controller.rememberMe.value = value!)),
                      const Text(JTexts.rememberMe),
                    ],
                  ),
                  TextButton(
                      onPressed: () => Get.toNamed(JRoutes.forgotPassword),
                      child: const Text(JTexts.forgotPassword))
                ],
              ),
              const SizedBox(height: JSizes.spaceBtwSections),

              SizedBox(
                width: double.infinity,
                // child: ElevatedButton( onPressed: () => controller.registerAdmin(), child: const Text(JTexts.signIn)),
                 child: ElevatedButton( onPressed: () => controller.emailAndPasswordSignIn(), child: const Text(JTexts.signIn)),
              
              )
            ],
          ),
        ));
  }
}
