import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import 'floating_bottom_navigation_curve.dart';
import 'floating_bottom_navigation_item.dart';
import 'floating_bottom_navigation_style.dart';

class FloatingBottomNavigationBar extends StatelessWidget {
  FloatingBottomNavigationBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.style = const FloatingBottomNavigationStyle(),
  }) : assert(items.length >= 3, 'Provide at least 3 items.'),
       assert(
         items
                 .where((FloatingBottomNavigationItem item) => item.isCenter)
                 .length ==
             1,
         'Exactly one center item is required.',
       );

  final List<FloatingBottomNavigationItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final FloatingBottomNavigationStyle style;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final bool compact = screenWidth < 380;
    final double barHeight = compact ? style.compactBarHeight : style.barHeight;
    final double centerGap = compact ? style.compactCenterGap : style.centerGap;
    final double barTop = compact ? style.compactBarTop : style.barTop;
    final double bottomInset = style.adaptBottomSafeArea
        ? mediaQuery.padding.bottom
        : 0;
    final double totalHeight =
        barHeight +
        bottomInset +
        style.outerPadding.top +
        style.outerPadding.bottom;
    final double regularLabelTop =
        style.outerPadding.top +
        barTop +
        style.itemTopPadding +
        style.itemIconSize +
        style.itemSpacing;
    final int centerIndex = items.indexWhere(
      (FloatingBottomNavigationItem item) => item.isCenter,
    );
    final FloatingBottomNavigationItem centerItem = items[centerIndex];
    final List<FloatingBottomNavigationItem> leadingItems = items
        .take(centerIndex)
        .toList();
    final List<FloatingBottomNavigationItem> trailingItems = items
        .skip(centerIndex + 1)
        .toList();

    return Padding(
      padding: style.outerPadding,
      child: SizedBox(
        height: totalHeight,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Positioned(
              left: 0,
              right: 0,
              top: style.outerPadding.top + barTop,
              bottom: 0,
              child: ClipPath(
                clipper: _BottomNavBackgroundClipper(style.curve),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: style.blurSigma,
                    sigmaY: style.blurSigma,
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: style.backgroundColor,
                      boxShadow: style.backgroundShadow == null
                          ? null
                          : <BoxShadow>[style.backgroundShadow!],
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: bottomInset),
                      child: Row(
                        children: <Widget>[
                          for (int i = 0; i < leadingItems.length; i++)
                            Expanded(
                              child: _TabButton(
                                item: leadingItems[i],
                                selected: currentIndex == i,
                                style: style,
                                onTap: () => onTap(i),
                              ),
                            ),
                          SizedBox(width: centerGap),
                          for (int i = 0; i < trailingItems.length; i++)
                            Expanded(
                              child: _TabButton(
                                item: trailingItems[i],
                                selected: currentIndex == centerIndex + i + 1,
                                style: style,
                                onTap: () => onTap(centerIndex + i + 1),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: style.outerPadding.top + style.centerTop,
              child: _CenterButton(
                item: centerItem,
                selected: currentIndex == centerIndex,
                style: style,
                regularLabelTop: regularLabelTop,
                onTap: () => onTap(centerIndex),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomNavBackgroundClipper extends CustomClipper<Path> {
  const _BottomNavBackgroundClipper(this.curve);

  final FloatingBottomNavigationCurve curve;

  @override
  Path getClip(Size size) {
    final double baselineY = curve.topY.clamp(0, size.height).toDouble();
    final Rect host = Rect.fromLTWH(
      0,
      baselineY,
      size.width,
      math.max(0, size.height - baselineY),
    );
    final double notchSize = curve.crestWidth.clamp(0, size.width);
    final Rect guest = Rect.fromLTWH(
      (size.width - notchSize) / 2,
      baselineY - curve.crestHeight,
      notchSize,
      notchSize,
    );

    if (!host.overlaps(guest)) {
      return Path()..addRect(host);
    }

    final double notchRadius = guest.width / 2;
    final double s1 = curve.shoulderWidth.clamp(8.0, notchRadius * 0.95);
    final double s2 = curve.slopeLift.clamp(0.5, 8.0);
    final double r = notchRadius;
    final double a = -r - s2;
    final double b = host.top - guest.center.dy;

    final double n2 = math.sqrt(b * b * r * r * (a * a + b * b - r * r));
    final double p2xA = ((a * r * r) - n2) / (a * a + b * b);
    final double p2xB = ((a * r * r) + n2) / (a * a + b * b);
    final double p2yA = -math.sqrt(r * r - p2xA * p2xA);
    final double p2yB = -math.sqrt(r * r - p2xB * p2xB);

    final List<Offset> p = List<Offset>.filled(6, Offset.zero, growable: false);
    p[0] = Offset(a - s1, b);
    p[1] = Offset(a, b);
    final double cmp = b < 0 ? -1.0 : 1.0;
    p[2] = cmp * p2yA > cmp * p2yB ? Offset(p2xA, p2yA) : Offset(p2xB, p2yB);
    p[3] = Offset(-p[2].dx, p[2].dy);
    p[4] = Offset(-p[1].dx, p[1].dy);
    p[5] = Offset(-p[0].dx, p[0].dy);

    for (int i = 0; i < p.length; i++) {
      p[i] = p[i] + guest.center;
    }

    final double topLeftRadius = curve.topCornerRadius.clamp(0, host.height);
    final double topRightRadius = curve.topCornerRadius.clamp(0, host.height);
    final double bottomLeftRadius = curve.bottomCornerRadius.clamp(
      0,
      host.height,
    );
    final double bottomRightRadius = curve.bottomCornerRadius.clamp(
      0,
      host.height,
    );

    final Path path = Path()..moveTo(host.left, host.top + topLeftRadius);
    if (topLeftRadius > 0) {
      path.arcToPoint(
        Offset(host.left + topLeftRadius, host.top),
        radius: Radius.circular(topLeftRadius),
      );
    } else {
      path.lineTo(host.left, host.top);
    }

    path
      ..lineTo(p[0].dx, p[0].dy)
      ..quadraticBezierTo(p[1].dx, p[1].dy, p[2].dx, p[2].dy)
      ..arcToPoint(p[3], radius: Radius.circular(notchRadius), clockwise: true)
      ..quadraticBezierTo(p[4].dx, p[4].dy, p[5].dx, p[5].dy)
      ..lineTo(host.right - topRightRadius, host.top);

    if (topRightRadius > 0) {
      path.arcToPoint(
        Offset(host.right, host.top + topRightRadius),
        radius: Radius.circular(topRightRadius),
      );
    } else {
      path.lineTo(host.right, host.top);
    }

    path.lineTo(host.right, host.bottom - bottomRightRadius);
    if (bottomRightRadius > 0) {
      path.arcToPoint(
        Offset(host.right - bottomRightRadius, host.bottom),
        radius: Radius.circular(bottomRightRadius),
      );
    } else {
      path.lineTo(host.right, host.bottom);
    }

    path.lineTo(host.left + bottomLeftRadius, host.bottom);
    if (bottomLeftRadius > 0) {
      path.arcToPoint(
        Offset(host.left, host.bottom - bottomLeftRadius),
        radius: Radius.circular(bottomLeftRadius),
      );
    } else {
      path.lineTo(host.left, host.bottom);
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _BottomNavBackgroundClipper oldClipper) {
    return oldClipper.curve != curve;
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.item,
    required this.selected,
    required this.style,
    required this.onTap,
  });

  final FloatingBottomNavigationItem item;
  final bool selected;
  final FloatingBottomNavigationStyle style;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color activeColor = item.activeColor ?? style.selectedItemColor;
    final Color inactiveColor = item.inactiveColor ?? style.unselectedItemColor;
    final Color resolvedColor = selected ? activeColor : inactiveColor;
    final bool filled = selected && item.filledSelection;
    final double iconSize = selected
        ? item.activeIconSize ?? item.iconSize ?? style.itemIconSize
        : item.iconSize ?? style.itemIconSize;
    final double containerSize = filled ? style.filledSelectionSize : iconSize;

    return InkWell(
      onTap: onTap,
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: style.itemTopPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                width: containerSize,
                height: containerSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: filled
                      ? item.selectionGradient ?? style.defaultSelectionGradient
                      : null,
                ),
                child: item.iconBuilder != null
                    ? item.iconBuilder!(
                        context,
                        selected,
                        filled ? Colors.white : resolvedColor,
                      )
                    : Icon(
                        selected ? item.activeIcon ?? item.icon : item.icon,
                        size: iconSize,
                        color: filled ? Colors.white : resolvedColor,
                      ),
              ),
              SizedBox(height: style.itemSpacing),
              Text(
                item.label,
                style:
                    (selected
                            ? item.activeLabelStyle ??
                                  style.selectedItemLabelStyle
                            : item.inactiveLabelStyle ?? style.itemLabelStyle)
                        .copyWith(color: resolvedColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CenterButton extends StatelessWidget {
  const _CenterButton({
    required this.item,
    required this.selected,
    required this.style,
    required this.regularLabelTop,
    required this.onTap,
  });

  final FloatingBottomNavigationItem item;
  final bool selected;
  final FloatingBottomNavigationStyle style;
  final double regularLabelTop;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final double size = selected
        ? item.activeCenterSize ?? item.centerSize ?? style.centerSelectedSize
        : item.centerSize ?? style.centerUnselectedSize;
    final Color activeColor = item.activeColor ?? style.selectedItemColor;
    final Color inactiveColor = item.inactiveColor ?? style.unselectedItemColor;
    final Color resolvedIconColor = selected ? activeColor : inactiveColor;
    final double iconSize = selected
        ? item.activeCenterIconSize ??
              item.centerIconSize ??
              item.activeCenterSize ??
              item.centerSize ??
              style.itemIconSize
        : item.centerIconSize ?? item.centerSize ?? style.itemIconSize;
    final double labelTopInsideCenter =
        regularLabelTop - (style.outerPadding.top + style.centerTop);
    final double labelOffset =
        labelTopInsideCenter - size + style.centerLabelSpacing;
    final TextStyle labelStyle = selected
        ? item.activeLabelStyle ?? style.selectedCenterLabelStyle
        : item.inactiveLabelStyle ?? style.centerLabelStyle;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            width: size,
            height: size,
            padding:
                item.centerVariant ==
                    FloatingCenterButtonVariant.circleBackground
                ? style.centerButtonPadding
                : EdgeInsets.zero,
            decoration:
                item.centerVariant ==
                    FloatingCenterButtonVariant.circleBackground
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    color: style.centerButtonColor,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: style.centerShadowColor,
                        blurRadius: style.centerShadowBlur,
                        offset: style.centerShadowOffset,
                      ),
                    ],
                  )
                : null,
            child: _CenterButtonContent(
              item: item,
              selected: selected,
              iconSize: iconSize,
              iconColor: resolvedIconColor,
              foregroundGradient: style.centerForegroundGradient,
            ),
          ),
          Transform.translate(
            offset: Offset(0, labelOffset),
            child: Text(
              item.label,
              style: labelStyle.copyWith(
                color: selected
                    ? item.activeColor ?? style.selectedCenterLabelColor
                    : item.inactiveColor ?? style.unselectedCenterLabelColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CenterButtonContent extends StatelessWidget {
  const _CenterButtonContent({
    required this.item,
    required this.selected,
    required this.iconSize,
    required this.iconColor,
    required this.foregroundGradient,
  });

  final FloatingBottomNavigationItem item;
  final bool selected;
  final double iconSize;
  final Color iconColor;
  final Gradient foregroundGradient;

  @override
  Widget build(BuildContext context) {
    if (item.centerIconBuilder != null) {
      return item.centerVariant == FloatingCenterButtonVariant.circleBackground
          ? ClipOval(
              child: Center(
                child: item.centerIconBuilder!(context, selected, iconColor),
              ),
            )
          : Center(
              child: item.centerIconBuilder!(context, selected, iconColor),
            );
    }

    if (item.centerIcon != null) {
      return Center(
        child: Icon(
          selected ? item.activeCenterIcon ?? item.centerIcon : item.centerIcon,
          size: iconSize,
          color: iconColor,
        ),
      );
    }

    return ClipOval(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          if (item.centerImage != null)
            Image(image: item.centerImage!, fit: BoxFit.cover)
          else
            item.centerChild!,
          DecoratedBox(decoration: BoxDecoration(gradient: foregroundGradient)),
        ],
      ),
    );
  }
}
