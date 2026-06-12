import 'package:admin/common/widgets/loader/animation_loader.dart';
import 'package:admin/utils/constants/colors.dart';
import 'package:admin/utils/constants/image_string.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class JPaginatedDataTable extends StatelessWidget {
  const JPaginatedDataTable({
    super.key,
    required this.columns,
    required this.source,
    this.rowsPerPage = 10,
    this.tableHeight = 760,
    this.onPageChanged,
    this.sortColumnIndex,
    this.dataRowHeight = JSizes.xl * 2,
    this.sortAscending = true,
    this.minWidth = 1000,
  });

  /// Whether to sort the DataTable in asce

  final bool sortAscending;

  /// Index of the column to sort by.

  final int? sortColumnIndex;

  /// Number of rows to display per page.

  final int rowsPerPage;

  /// Data source for the DataTable.

  final DataTableSource source;

  final List<DataColumn> columns;

  /// Callback function to handle page changes.

  final Function(int)? onPageChanged;

  /// Height of each data row in the DataTable.

  final double dataRowHeight;

  /// Height of the entire DataTable.

  final double tableHeight;

  /// Minimum Width of the entire DataTable.

  final double? minWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Theme(
      // Use to set the Backend color
      
        data: Theme.of(context).copyWith(
            cardTheme: const CardTheme(color: Colors.white, elevation: 0)),
        child: PaginatedDataTable2(
          source: source,
          columns: columns,
          columnSpacing: 12,
          minWidth: minWidth,
          dividerThickness: 0,
          horizontalMargin: 12,
          rowsPerPage: rowsPerPage,
          showFirstLastButtons: true,
          showCheckboxColumn: true,
          sortAscending: sortAscending,
          onPageChanged: onPageChanged,
          dataRowHeight: dataRowHeight,
          renderEmptyRowsInTheEnd: false,
          onRowsPerPageChanged: (noOfRows) {},
          sortColumnIndex: sortColumnIndex,
          headingTextStyle: Theme.of(context).textTheme.titleMedium,
          headingRowColor: WidgetStateProperty.resolveWith(
              (states) => JColors.primaryBackground),
          empty: const JAnimationLoaderWidget(
              animation: JImages.processingdata,
              text: 'Nothing Found',
              height: 200,
              width: 200),
          headingRowDecoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(JSizes.borderRadiusMd),
              topRight: Radius.circular(JSizes.borderRadiusMd),
            ), // BorderRadius.only
          ), // BoxDecoration
      
          sortArrowBuilder: (bool ascending, bool sorted) {
            if (sorted) {
              return Icon(
                ascending ? Iconsax.arrow_up_3 : Iconsax.arrow_down,
                size: JSizes.iconSm,
              );
            } else {
              return const Icon(Iconsax.arrow_3, size: JSizes.iconSm);
            }
          },
        ),
      ),
    );
  }
}
