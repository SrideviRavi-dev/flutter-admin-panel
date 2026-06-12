import 'package:admin/common/widgets/container/circular_container.dart';
import 'package:admin/utils/constants/colors.dart';
import 'package:admin/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';

class JChoiceChip extends StatelessWidget {
  const JChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });
  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final isColor = JHelperFunction.getColor(text) != null;
    return ChoiceChip(
      label: isColor ? const SizedBox() : Text(text),
      selected: selected,
      onSelected: onSelected,
      labelStyle: TextStyle(color: selected ? JColors.white : null),
      avatar: isColor
          ? JCircularContainer(
              width: 50,
              height: 50,
              backgroundColor: JHelperFunction.getColor(text)!)
          : null,
      labelPadding: isColor ? const EdgeInsets.all(0) : null,
      padding: isColor ? const EdgeInsets.all(0) : null,
      shape: isColor ? const CircleBorder() : null,
      backgroundColor: isColor ? JHelperFunction.getColor(text)! : null,
    );
  }
}
