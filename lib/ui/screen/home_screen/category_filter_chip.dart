import 'package:flutter/material.dart';
import 'package:flutter_developer_assessment/ui/screen/home_screen/bloc/home_screen_state.dart';

class CategoryFilterChip extends StatelessWidget {

  final CategoryFilter filter;
  final bool isSelected;
  final Function() onSelected;
  const CategoryFilterChip({
    super.key,
    required this.filter,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(filter.name),
      selected: isSelected,
      onSelected: (selected) => onSelected(),
    );
  }
}
