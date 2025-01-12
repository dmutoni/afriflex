import 'package:flutter/material.dart';
import 'package:afriflex/values/colors.dart';
import 'package:afriflex/values/dimens.dart';

class AfriflexDropdown extends StatefulWidget {
  final List<DropdownItem> items;
  final TextEditingController
      controller; // TextEditingController for the dropdown
  final ValueChanged<DropdownItem> onChanged;
  final double width;
  final double height;
  final String? label;
  final bool? isLanguagePicker;

  const AfriflexDropdown({
    super.key,
    required this.items,
    required this.controller, // Required controller
    required this.onChanged,
    this.width = Dimens.dropdownWidth,
    this.height = Dimens.dropdownHeight,
    this.label,
    this.isLanguagePicker = false,
  });

  @override
  State<AfriflexDropdown> createState() => _AfriflexDropdownState();
}

class _AfriflexDropdownState extends State<AfriflexDropdown> {
  OverlayEntry? _overlayEntry;
  bool _isDropdownOpen = false;

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
        left: position.dx,
        child: Material(
          color: Colors.transparent,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: widget.width,
              maxHeight: 300, // Max height for the dropdown
            ),
            child: SingleChildScrollView(
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
                          widget.controller.text =
                              item.value; // Set selected label
                          _closeDropdown();
                          widget.onChanged(item);
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.marginSmall,
                          vertical: Dimens.marginSmall,
                        ),
                        child: Row(
                          children: [
                            if (item.icon != null)
                              item.icon ?? const SizedBox.shrink(),
                            const SizedBox(width: Dimens.marginSmall),
                            Text(
                              item.label,
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
      child: Container(
        height: Dimens.inputHeight,
        decoration: (widget.isLanguagePicker ?? false)
            ? null
            : BoxDecoration(
                border: Border.all(
                  color: ThemeColors.grayLight,
                ),
                borderRadius: BorderRadius.circular(Dimens.radiusMedium),
              ),
        child: Stack(
          children: [
            if (widget.isLanguagePicker ?? false)
              const Positioned(
                right: 50,
                top: 10,
                child: Icon(
                  Icons.language,
                  color: ThemeColors.orangeColor,
                ),
              ),
            if (widget.isLanguagePicker ?? true)
              Positioned(
                right: 30,
                top: 14,
                child: Text(
                  widget.controller.text,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ThemeColors.blackColor,
                      ),
                ),
              ),
            if (widget.isLanguagePicker == false)
              TextField(
                controller: widget.controller,
                readOnly: true,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.isLanguagePicker ?? false
                      ? ''
                      : 'Select an option',
                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.grey, // Placeholder style
                      ),
                  contentPadding: const EdgeInsets.only(
                    left: 12,
                    right: 36, // Space for the dropdown icon
                  ),
                ),
              ),
            const Positioned(
              right: 8,
              top: 10,
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: ThemeColors.blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DropdownItem {
  final String label;
  final Widget? icon;
  final String value;

  const DropdownItem({
    required this.label,
    this.icon,
    required this.value,
  });
}
