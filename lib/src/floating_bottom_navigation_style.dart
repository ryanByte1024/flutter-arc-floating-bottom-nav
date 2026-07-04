import 'package:flutter/material.dart';

import 'floating_bottom_navigation_curve.dart';

@immutable
class FloatingBottomNavigationStyle {
  const FloatingBottomNavigationStyle({
    this.outerPadding = EdgeInsets.zero,
    this.barHeight = 126,
    this.compactBarHeight = 118,
    this.barTop = 22,
    this.compactBarTop = 20,
    this.centerGap = 112,
    this.compactCenterGap = 98,
    this.centerTop = 25,
    this.adaptBottomSafeArea = true,
    this.backgroundColor = Colors.white,
    this.blurSigma = 18,
    this.backgroundShadow,
    this.curve = const FloatingBottomNavigationCurve(),
    this.selectedItemColor = const Color(0xFF1E88FF),
    this.unselectedItemColor = const Color(0xFF314A81),
    this.selectedCenterLabelColor = const Color(0xFF1E88FF),
    this.unselectedCenterLabelColor = const Color(0xFF223D72),
    this.itemTopPadding = 43,
    this.itemSpacing = 5,
    this.itemLabelStyle = const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
    ),
    this.selectedItemLabelStyle = const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w700,
    ),
    this.itemIconSize = 24,
    this.filledSelectionSize = 34,
    this.defaultSelectionGradient = const LinearGradient(
      colors: <Color>[Color(0xFF2E96FF), Color(0xFF37C7FF)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    this.centerSelectedSize = 70,
    this.centerUnselectedSize = 66,
    this.centerButtonPadding = EdgeInsets.zero,
    this.centerButtonColor = Colors.transparent,
    this.centerShadowColor = const Color(0x3D8BA7D3),
    this.centerShadowBlur = 18,
    this.centerShadowOffset = const Offset(0, 8),
    this.centerLabelSpacing = 5,
    this.centerLabelStyle = const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      height: 1,
    ),
    this.selectedCenterLabelStyle = const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w700,
      height: 1,
    ),
    this.centerForegroundGradient = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[Colors.transparent, Color(0x240C2B63)],
    ),
  });

  final EdgeInsets outerPadding;
  final double barHeight;
  final double compactBarHeight;
  final double barTop;
  final double compactBarTop;
  final double centerGap;
  final double compactCenterGap;
  final double centerTop;
  final bool adaptBottomSafeArea;
  final Color backgroundColor;
  final double blurSigma;
  final BoxShadow? backgroundShadow;
  final FloatingBottomNavigationCurve curve;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final Color selectedCenterLabelColor;
  final Color unselectedCenterLabelColor;
  final double itemTopPadding;
  final double itemSpacing;
  final TextStyle itemLabelStyle;
  final TextStyle selectedItemLabelStyle;
  final double itemIconSize;
  final double filledSelectionSize;
  final Gradient defaultSelectionGradient;
  final double centerSelectedSize;
  final double centerUnselectedSize;
  final EdgeInsets centerButtonPadding;
  final Color centerButtonColor;
  final Color centerShadowColor;
  final double centerShadowBlur;
  final Offset centerShadowOffset;
  final double centerLabelSpacing;
  final TextStyle centerLabelStyle;
  final TextStyle selectedCenterLabelStyle;
  final Gradient centerForegroundGradient;

  FloatingBottomNavigationStyle copyWith({
    EdgeInsets? outerPadding,
    double? barHeight,
    double? compactBarHeight,
    double? barTop,
    double? compactBarTop,
    double? centerGap,
    double? compactCenterGap,
    double? centerTop,
    bool? adaptBottomSafeArea,
    Color? backgroundColor,
    double? blurSigma,
    BoxShadow? backgroundShadow,
    FloatingBottomNavigationCurve? curve,
    Color? selectedItemColor,
    Color? unselectedItemColor,
    Color? selectedCenterLabelColor,
    Color? unselectedCenterLabelColor,
    double? itemTopPadding,
    double? itemSpacing,
    TextStyle? itemLabelStyle,
    TextStyle? selectedItemLabelStyle,
    double? itemIconSize,
    double? filledSelectionSize,
    Gradient? defaultSelectionGradient,
    double? centerSelectedSize,
    double? centerUnselectedSize,
    EdgeInsets? centerButtonPadding,
    Color? centerButtonColor,
    Color? centerShadowColor,
    double? centerShadowBlur,
    Offset? centerShadowOffset,
    double? centerLabelSpacing,
    TextStyle? centerLabelStyle,
    TextStyle? selectedCenterLabelStyle,
    Gradient? centerForegroundGradient,
  }) {
    return FloatingBottomNavigationStyle(
      outerPadding: outerPadding ?? this.outerPadding,
      barHeight: barHeight ?? this.barHeight,
      compactBarHeight: compactBarHeight ?? this.compactBarHeight,
      barTop: barTop ?? this.barTop,
      compactBarTop: compactBarTop ?? this.compactBarTop,
      centerGap: centerGap ?? this.centerGap,
      compactCenterGap: compactCenterGap ?? this.compactCenterGap,
      centerTop: centerTop ?? this.centerTop,
      adaptBottomSafeArea: adaptBottomSafeArea ?? this.adaptBottomSafeArea,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      blurSigma: blurSigma ?? this.blurSigma,
      backgroundShadow: backgroundShadow ?? this.backgroundShadow,
      curve: curve ?? this.curve,
      selectedItemColor: selectedItemColor ?? this.selectedItemColor,
      unselectedItemColor: unselectedItemColor ?? this.unselectedItemColor,
      selectedCenterLabelColor:
          selectedCenterLabelColor ?? this.selectedCenterLabelColor,
      unselectedCenterLabelColor:
          unselectedCenterLabelColor ?? this.unselectedCenterLabelColor,
      itemTopPadding: itemTopPadding ?? this.itemTopPadding,
      itemSpacing: itemSpacing ?? this.itemSpacing,
      itemLabelStyle: itemLabelStyle ?? this.itemLabelStyle,
      selectedItemLabelStyle:
          selectedItemLabelStyle ?? this.selectedItemLabelStyle,
      itemIconSize: itemIconSize ?? this.itemIconSize,
      filledSelectionSize: filledSelectionSize ?? this.filledSelectionSize,
      defaultSelectionGradient:
          defaultSelectionGradient ?? this.defaultSelectionGradient,
      centerSelectedSize: centerSelectedSize ?? this.centerSelectedSize,
      centerUnselectedSize: centerUnselectedSize ?? this.centerUnselectedSize,
      centerButtonPadding: centerButtonPadding ?? this.centerButtonPadding,
      centerButtonColor: centerButtonColor ?? this.centerButtonColor,
      centerShadowColor: centerShadowColor ?? this.centerShadowColor,
      centerShadowBlur: centerShadowBlur ?? this.centerShadowBlur,
      centerShadowOffset: centerShadowOffset ?? this.centerShadowOffset,
      centerLabelSpacing: centerLabelSpacing ?? this.centerLabelSpacing,
      centerLabelStyle: centerLabelStyle ?? this.centerLabelStyle,
      selectedCenterLabelStyle:
          selectedCenterLabelStyle ?? this.selectedCenterLabelStyle,
      centerForegroundGradient:
          centerForegroundGradient ?? this.centerForegroundGradient,
    );
  }
}
