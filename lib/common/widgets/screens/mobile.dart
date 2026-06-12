// ignore_for_file: deprecated_member_use

import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:flutter/material.dart';

class Mobile extends StatelessWidget {
  const Mobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         Expanded(
           child: JRoundedContainer(
            height: 450,
            backgroundColor: Colors.blue.withOpacity(0.2),
            child: const Center(child: Text('Box 1'),),
           ),
         ),
         const SizedBox(width: 20),
         Expanded(
           child: JRoundedContainer(
            height: 450,
            backgroundColor: Colors.blue.withOpacity(0.2),
            child: const Center(child: Text('Box 1'),),
           ),
         ),
         const SizedBox(width: 20),
         Expanded(
           child: JRoundedContainer(
            height: 450,
            backgroundColor: Colors.blue.withOpacity(0.2),
            child: const Center(child: Text('Box 1'),),
           ),
         ),
      ],
    );
  }
}