import 'package:admin/common/widgets/images/rounded_image.dart';
import 'package:admin/features/shop/controller/customer/customer_controller.dart';
import 'package:admin/features/shop/screens/category/all_categories/widgets/table_action_icon_button.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/utils/constants/colors.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerRows extends DataTableSource {
  final controller = CustomerController.instance;
  @override
  DataRow? getRow(int index) {
    final customer = controller.filteredItems[index];
    return DataRow2(
        
      onTap: ()=> Get.toNamed(JRoutes.customerDetails,arguments: customer,parameters: {'customerId': customer.id ?? ''}),
      selected: controller.selectedRows[index],
      onSelectChanged: (value) => controller.selectedRows[index] =value ?? false,
      cells: [
        DataCell(
          Row(
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: JRoundedImage(
                  padding: JSizes.sm,
                  image: customer.profilePicture,
                  imageType: ImageType.network,
                  borderRadius: JSizes.borderRadiusMd,
                  backgroundColor: JColors.primaryBackground,
                ),
              ),
              const SizedBox(width: JSizes.spaceBtwItems),
              Expanded(
                  child: Text(
                customer.fullName,
                style: Theme.of(Get.context!)
                    .textTheme
                    .bodyLarge!
                    .apply(color: JColors.primary),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ))
            ],
          ),
        ),
        DataCell(Text(customer.email)),
        DataCell(Text(customer.phoneNumber)),
        DataCell(Text(customer.createdAt == null ? '' : customer.formattedDate)),
        DataCell(JTableActionButtons(
          view: true,
          edit: false,
          onViewPressed: () =>
              Get.toNamed(JRoutes.customerDetails, arguments: customer,parameters: {'customerId': customer.id ?? ''}),
          onDeletePressed: ()=> controller.confirmAndDeleteItem(customer),
        ))
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((seleced)=> seleced).length;
}
