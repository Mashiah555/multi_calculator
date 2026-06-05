import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuSheet extends ConsumerStatefulWidget {
  final ColorScheme theme;
  final List<MenuItem> items;
  final bool multipleSelection;
  final IconData? defaultIcon;

  const MenuSheet({
    super.key,
    required this.theme,
    required this.items,
    this.multipleSelection = false,
    this.defaultIcon,
  });

  @override
  ConsumerState<MenuSheet> createState() => _MenuSheetState();
}

class _MenuSheetState extends ConsumerState<MenuSheet> {
  // Track the full state of items internally
  late List<MenuItem> _currentItems;

  @override
  void initState() {
    super.initState();
    // Initialize our local state with the items passed in
    _currentItems = List.from(widget.items);
  }

  void _onItemTapped(int index) {
    if (!widget.multipleSelection) {
      // Single selection: pop and return the selected item's ID
      Navigator.pop(context, _currentItems[index].id);
      return;
    }

    // Multiple selection: toggle the item's state and rebuild the UI
    setState(() {
      final item = _currentItems[index];
      _currentItems[index] = item.copyWith(isSelected: !item.isSelected);
    });
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height * 0.65;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight, minHeight: 100),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.horizontal_rule_rounded, size: 40),

          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _currentItems.length,
              itemBuilder: (context, index) {
                final item = _currentItems[index];
                final isSelected = item.isSelected;

                return Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    vertical: 3,
                    horizontal: 12,
                  ),
                  child: ListTile(
                    leading: _getLeadingIcon(
                      itemIcon: item.icon,
                      isSelected: isSelected,
                    ),
                    title: Text(
                      item.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: item.subtitle != null
                        ? Text(item.subtitle!)
                        : null,
                    onTap: () => _onItemTapped(index),
                    selected: isSelected,
                    selectedTileColor: widget.theme.primary.withAlpha(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              },
            ),
          ),

          // Conditionally show the 'Done' button for multiple selection mode
          if (widget.multipleSelection) ...[
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // Return ONLY the IDs of the items that are currently selected
                    final selectedIds = _currentItems
                        .where((item) => item.isSelected)
                        .map((item) => item.id)
                        .toList();
                    Navigator.pop(context, selectedIds);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.theme.primaryContainer,
                  ),
                  child: const Text('Done'),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _getLeadingIcon({
    required IconData? itemIcon,
    required bool isSelected,
  }) {
    // 1. Prioritize the item's specific icon if it has one
    // 2. Fallback to the widget's default icon
    final iconToUse = itemIcon ?? widget.defaultIcon;

    if (iconToUse != null) {
      return Icon(
        iconToUse,
        color: (widget.multipleSelection && !isSelected)
            ? widget.theme.onSurface
            : widget.theme.primary,
      );
    } else {
      // 3. Fallback to generic checkbox/radio if no icons are provided
      if (widget.multipleSelection) {
        return Icon(
          isSelected
              ? Icons.check_box_rounded
              : Icons.check_box_outline_blank_rounded,
          color: widget.theme.primary,
        );
      } else {
        return Icon(Icons.radio_button_unchecked, color: widget.theme.primary);
      }
    }
  }
}

class MenuItem {
  final String id; // The internal value (e.g., 'A', 'B', 'mandatory')
  final String title;
  final String? subtitle;
  final IconData? icon;
  final bool isSelected; // Represents the initial state when passed in

  MenuItem({
    required this.id,
    required this.title,
    this.subtitle,
    this.icon,
    this.isSelected = false,
  });

  // A helper to safely toggle selection state inside the BottomSheet
  MenuItem copyWith({bool? isSelected}) {
    return MenuItem(
      id: id,
      title: title,
      subtitle: subtitle,
      icon: icon,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
