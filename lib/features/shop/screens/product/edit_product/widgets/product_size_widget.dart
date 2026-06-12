import 'package:flutter/material.dart';

class SizeSelectorWidget extends StatefulWidget {
  final List<String> availableSizes;
  final List<String> selectedSizes;
  final void Function(List<String>) onSelectionChanged;

  const SizeSelectorWidget({
    super.key,
    required this.availableSizes,
    required this.selectedSizes,
    required this.onSelectionChanged,
  });

  @override
  State<SizeSelectorWidget> createState() => _SizeSelectorWidgetState();
}

class _SizeSelectorWidgetState extends State<SizeSelectorWidget> {
  late List<String> _selectedSizes;

  @override
  void initState() {
    _selectedSizes = [...widget.selectedSizes];
    super.initState();
  }

  void _onChipTapped(String size) {
    setState(() {
      if (_selectedSizes.contains(size)) {
        _selectedSizes.remove(size);
      } else {
        _selectedSizes.add(size);
      }
      widget.onSelectionChanged(_selectedSizes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Size',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          children: widget.availableSizes.map((size) {
            final isSelected = _selectedSizes.contains(size);
            return ChoiceChip(
              label: Text(size),
              selected: isSelected,
              onSelected: (_) => _onChipTapped(size),
            );
          }).toList(),
        ),
      ],
    );
  }
}
