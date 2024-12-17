import 'package:afriflex/values/colors.dart';
import 'package:afriflex/values/dimens.dart';
import 'package:flutter/material.dart';

class AfriflexDropdown extends StatefulWidget {
  final List<DropdownItem> items;
  final DropdownItem? selectedItem; // Nullable for no initial selection
  final ValueChanged<DropdownItem> onChanged;
  final double width;
  final double height;

  const AfriflexDropdown({
    super.key,
    required this.items,
    this.selectedItem, // Optional
    required this.onChanged,
    this.width = Dimens.dropdownWidth,
    this.height = Dimens.dropdownHeight,
  });

  @override
  State<AfriflexDropdown> createState() => _AfriflexDropdownState();
}

class _AfriflexDropdownState extends State<AfriflexDropdown> {
  OverlayEntry? _overlayEntry;
  bool _isDropdownOpen = false;
  DropdownItem? _selectedItem; // Nullable to allow for placeholder

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedItem;
  }

  void _toggleDropdown(BuildContext context) {
    if (_isDropdownOpen) {
      _closeDropdown();
    } else {
      _openDropdown(context);
    }
  }

  void _openDropdown(BuildContext context) {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: position.dy + size.height + Dimens.marginFour,
        left: position.dx - 90,
        width: widget.width - 20,
        height: Dimens.dropdwonItemHeight,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ThemeColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: ThemeColors.blackColor.withOpacity(0.2),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: widget.items.map((item) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedItem = item; // Update selected item
                      _closeDropdown();
                      widget.onChanged(item); // Notify change
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.marginSmall,
                      vertical: Dimens.marginSmall,
                    ),
                    child: Row(
                      children: [
                        item.icon,
                        const SizedBox(width: Dimens.marginSmall),
                        Text(
                          '${item.label} ',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
    setState(() {
      _isDropdownOpen = true;
    });
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isDropdownOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _toggleDropdown(context),
      child: Row(
        children: [
          const Icon(
            Icons.language,
            color: ThemeColors.orangeColor,
          ),
          Text(
            _selectedItem?.value ?? '',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: ThemeColors.blackColor,
          ),
        ],
      ),
    );
  }
}

class DropdownItem {
  final String label;
  final Widget icon;
  final String value;

  const DropdownItem({
    required this.label,
    required this.icon,
    required this.value,
  });
}
