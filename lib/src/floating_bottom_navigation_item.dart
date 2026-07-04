import 'package:flutter/material.dart';

@immutable
class FloatingBottomNavigationItem {
  const FloatingBottomNavigationItem({
    required this.label,
    this.icon,
    this.activeIcon,
    this.iconSize,
    this.activeIconSize,
    this.iconBuilder,
    this.isCenter = false,
    this.filledSelection = false,
    this.centerImage,
    this.centerChild,
    this.centerSize,
    this.activeCenterSize,
    this.activeColor,
    this.inactiveColor,
    this.activeLabelStyle,
    this.inactiveLabelStyle,
    this.selectionGradient,
  }) : assert(
          isCenter ? centerImage != null || centerChild != null : icon != null || iconBuilder != null,
          'Center item requires centerImage or centerChild; regular items require icon or iconBuilder.',
        );

  final String label;
  final IconData? icon;
  final IconData? activeIcon;
  final double? iconSize;
  final double? activeIconSize;
  final Widget Function(BuildContext context, bool selected, Color color)? iconBuilder;
  final bool isCenter;
  final bool filledSelection;
  final ImageProvider<Object>? centerImage;
  final Widget? centerChild;
  final double? centerSize;
  final double? activeCenterSize;
  final Color? activeColor;
  final Color? inactiveColor;
  final TextStyle? activeLabelStyle;
  final TextStyle? inactiveLabelStyle;
  final Gradient? selectionGradient;
}
