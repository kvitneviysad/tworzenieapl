
import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String> onFilterChanged;

  const FilterBar({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  static const List<String> _filters = ['all', 'todo', 'done'];
  static const Map<String, String> _labels = {
    'all': 'Wszystkie',
    'todo': 'Do zrobienia',
    'done': 'Wykonane',
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _filters.map((filter) {
        final bool isActive = selectedFilter == filter;
        return TextButton(
          onPressed: () => onFilterChanged(filter),
          style: TextButton.styleFrom(
            foregroundColor: isActive
                ? Theme.of(context).colorScheme.primary
                : Colors.grey,
          ),
          child: Text(
            _labels[filter]!,
            style: TextStyle(
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        );
      }).toList(),
    );
  }
}