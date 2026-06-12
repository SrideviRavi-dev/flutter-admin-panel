import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/features/authentication/controller/user_controller.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:admin/utils/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileForm extends StatelessWidget {
  
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller  = UserController.instance;
    controller.firstNameController.text = controller.user.value.firstName;
    controller.lastNameController.text = controller.user.value.lastName;
    controller.phoneController.text = controller.user.value.phoneNumber;
    return Column(
      children: [
        JRoundedContainer(
          padding: const EdgeInsets.symmetric(
              vertical: JSizes.lg, horizontal: JSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Profile Details',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: JSizes.spaceBtwSections),
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller.firstNameController,
                            decoration: const InputDecoration(
                              hintText: 'First Name',
                              label: Text('First Name'),
                              prefixIcon: Icon(Iconsax.user),
                            ),
                            validator: (value) => JValidator.validateEmptyText(
                                'First Name', value),
                          ),
                        ),
                        const SizedBox(width: JSizes.spaceBtwInputFields),
                         Expanded(
                          child: TextFormField(
                            controller: controller.lastNameController,
                            decoration: const InputDecoration(
                              
                              hintText: 'Last Name',
                              label: Text('Last Name'),
                              prefixIcon: Icon(Iconsax.user),
                            ),
                            validator: (value) => JValidator.validateEmptyText(
                                'Last Name', value),
                          ),
                        ),
                        const SizedBox(width: JSizes.spaceBtwInputFields),
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              label: Text('Email'),
                              prefixIcon: Icon(Iconsax.forward),
                              enabled: false,
                            ),
                          ),
                        ),
                         Expanded(
                          child: TextFormField(
                            controller: controller.phoneController,
                            decoration: const InputDecoration(
                              hintText: 'Phone Number ',
                              label: Text('Phone Number'),
                              prefixIcon: Icon(Iconsax.user),
                            ),
                            validator: (value) => JValidator.validateEmptyText(
                                'Phone Number', value),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: JSizes.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: Obx(
                 ()=> ElevatedButton(
                  onPressed: ()=> controller.loading.value ? (){} : controller.updateUserInformation(),
                   child:controller.loading.value
                   ?const CircularProgressIndicator(color: Colors.white,strokeWidth: 2,)
                   : const Text('Update Profile')),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
