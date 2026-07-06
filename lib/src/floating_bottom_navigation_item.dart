import 'package:flutter/material.dart';

enum FloatingCenterButtonVariant { iconOnly, circleBackground }

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
    this.centerVariant = FloatingCenterButtonVariant.circleBackground,
    this.centerImage,
    this.centerChild,
    this.centerIcon,
    this.activeCenterIcon,
    this.centerIconSize,
    this.activeCenterIconSize,
    this.centerIconBuilder,
    this.centerSize,
    this.activeCenterSize,
    this.activeColor,
    this.inactiveColor,
    this.activeLabelStyle,
    this.inactiveLabelStyle,
    this.selectionGradient,
  }) : assert(
         isCenter
             ? centerImage != null ||
                   centerChild != null ||
                   centerIcon != null ||
                   centerIconBuilder != null
             : icon != null || iconBuilder != null,
         'Center item requires centerImage, centerChild, centerIcon, or centerIconBuilder; regular items require icon or iconBuilder.',
       );

  final String label;
  final IconData? icon;
  final IconData? activeIcon;
  final double? iconSize;
  final double? activeIconSize;
  final Widget Function(BuildContext context, bool selected, Color color)?
  iconBuilder;
  final bool isCenter;
  final bool filledSelection;
  final FloatingCenterButtonVariant centerVariant;
  final ImageProvider<Object>? centerImage;
  final Widget? centerChild;
  final IconData? centerIcon;
  final IconData? activeCenterIcon;
  final double? centerIconSize;
  final double? activeCenterIconSize;
  final Widget Function(BuildContext context, bool selected, Color color)?
  centerIconBuilder;
  final double? centerSize;
  final double? activeCenterSize;
  final Color? activeColor;
  final Color? inactiveColor;
  final TextStyle? activeLabelStyle;
  final TextStyle? inactiveLabelStyle;
  final Gradient? selectionGradient;
}
