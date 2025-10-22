import 'package:flutter/material.dart';
import 'package:flutter_developer_assessment/domain/model/category_filter.dart';

class CategoryFilterChip extends StatelessWidget {

  final CategoryFilter filter;
  final bool isSelected;
  final VoidCallback onSelected;

  const CategoryFilterChip({
    super.key,
    required this.filter,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: isSelected
            ? [
          BoxShadow(
            color: colorScheme.primary,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ] : null,
      ),
      child: FilterChip(
        label: Text(
          filter.name,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isSelected
                ? colorScheme.onPrimary
                : colorScheme.onSurface,
          ),
        ),
        selected: isSelected,
        selectedColor: colorScheme.primary,
        backgroundColor: colorScheme.surfaceContainerHighest,
        checkmarkColor: colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        labelPadding: const EdgeInsets.symmetric(horizontal: 4),
        elevation: isSelected ? 2 : 0,
        pressElevation: 3,
        side: BorderSide(
          color: isSelected
              ? colorScheme.primary
              : colorScheme.outline,
        ),
        onSelected: (_) => onSelected(),
        avatar: isSelected
            ? Icon(Icons.check_circle, color: colorScheme.onPrimary, size: 18)
            : null,
        showCheckmark: false, // we already show a custom icon
      ),
    );
  }
}
