# arc_floating_bottom_nav

English | [简体中文](./README.zh-CN.md)

A customizable Flutter package for a floating bottom navigation bar with a raised center item.

## Features

- Controlled active/inactive state with `currentIndex`
- One dedicated center item with image or custom widget support
- Tunable top curve for a soft raised center shape
- Configurable colors, spacing, blur, shadows, labels, and icon behavior
- Safe-area aware bottom layout
- Example app included

## Installation

```yaml
dependencies:
  arc_floating_bottom_nav: ^0.1.0
```

## Usage

```dart
import 'package:arc_floating_bottom_nav/arc_floating_bottom_nav.dart';
import 'package:flutter/material.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  int currentIndex = 0;

  late final List<FloatingBottomNavigationItem> items =
      <FloatingBottomNavigationItem>[
        const FloatingBottomNavigationItem(
          label: 'Home',
          icon: Icons.home_outlined,
          activeIcon: Icons.home,
        ),
        const FloatingBottomNavigationItem(
          label: 'Trips',
          icon: Icons.directions_car_outlined,
          activeIcon: Icons.directions_car_outlined,
        ),
        const FloatingBottomNavigationItem(
          label: 'AI Travel',
          isCenter: true,
          centerImage: NetworkImage('https://picsum.photos/200'),
        ),
        const FloatingBottomNavigationItem(
          label: 'Explore',
          icon: Icons.explore_outlined,
          activeIcon: Icons.explore_outlined,
        ),
        const FloatingBottomNavigationItem(
          label: 'Profile',
          icon: Icons.person_outline_rounded,
          activeIcon: Icons.person_outline_rounded,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: items.map((item) => Center(child: Text(item.label))).toList(),
      ),
      bottomNavigationBar: FloatingBottomNavigationBar(
        items: items,
        currentIndex: currentIndex,
        onTap: (int index) => setState(() => currentIndex = index),
      ),
    );
  }
}
```

## Main API

- `FloatingBottomNavigationBar`
- `FloatingBottomNavigationItem`
- `FloatingBottomNavigationStyle`
- `FloatingBottomNavigationCurve`

## Parameter Reference

### FloatingBottomNavigationBar

| Parameter | Type | Meaning |
| --- | --- | --- |
| `items` | `List<FloatingBottomNavigationItem>` | All tabs. At least 3 items are required, and exactly 1 item must have `isCenter: true`. |
| `currentIndex` | `int` | Currently selected tab index. |
| `onTap` | `ValueChanged<int>` | Callback fired when a tab is tapped. |
| `style` | `FloatingBottomNavigationStyle` | Global layout and visual configuration for the bar. |

### FloatingBottomNavigationItem

| Parameter | Type | Meaning |
| --- | --- | --- |
| `label` | `String` | Text displayed below the icon or center avatar. |
| `icon` | `IconData?` | Default icon for a regular item. |
| `activeIcon` | `IconData?` | Icon shown when a regular item is selected. |
| `iconSize` | `double?` | Icon size for the regular state. |
| `activeIconSize` | `double?` | Icon size for the selected state. |
| `iconBuilder` | `Widget Function(BuildContext, bool, Color)?` | Custom icon builder for a regular item. Receives `context`, `selected`, and resolved icon color. |
| `isCenter` | `bool` | Marks the item as the single raised center item. |
| `filledSelection` | `bool` | When `true`, the selected regular item gets a filled circular background. |
| `centerImage` | `ImageProvider<Object>?` | Image source for the center item. |
| `centerChild` | `Widget?` | Custom center content when you do not use `centerImage`. |
| `centerSize` | `double?` | Center item size in the unselected state. |
| `activeCenterSize` | `double?` | Center item size in the selected state. |
| `activeColor` | `Color?` | Active icon or label color override for this item. |
| `inactiveColor` | `Color?` | Inactive icon or label color override for this item. |
| `activeLabelStyle` | `TextStyle?` | Active label style override for this item. |
| `inactiveLabelStyle` | `TextStyle?` | Inactive label style override for this item. |
| `selectionGradient` | `Gradient?` | Gradient used by the filled selected circle for a regular item. |

### FloatingBottomNavigationStyle

| Parameter | Type | Meaning |
| --- | --- | --- |
| `outerPadding` | `EdgeInsets` | Outer spacing around the whole navigation bar widget. |
| `barHeight` | `double` | Bar height on regular-width screens. |
| `compactBarHeight` | `double` | Bar height on narrow screens. |
| `barTop` | `double` | Top offset of the clipped bar background on regular-width screens. |
| `compactBarTop` | `double` | Top offset of the clipped bar background on narrow screens. |
| `centerGap` | `double` | Empty horizontal gap reserved for the center item on regular-width screens. |
| `compactCenterGap` | `double` | Empty horizontal gap reserved for the center item on narrow screens. |
| `centerTop` | `double` | Top offset of the raised center item. Smaller values move it upward. |
| `adaptBottomSafeArea` | `bool` | Adds bottom safe-area padding when enabled. |
| `backgroundColor` | `Color` | Fill color of the navigation bar background. |
| `blurSigma` | `double` | Blur strength applied by the background `BackdropFilter`. |
| `backgroundShadow` | `BoxShadow?` | Optional shadow for the clipped bar background. |
| `curve` | `FloatingBottomNavigationCurve` | Shape configuration for the raised top contour. |
| `selectedItemColor` | `Color` | Default selected color for regular items. |
| `unselectedItemColor` | `Color` | Default unselected color for regular items. |
| `selectedCenterLabelColor` | `Color` | Default selected label color for the center item. |
| `unselectedCenterLabelColor` | `Color` | Default unselected label color for the center item. |
| `itemTopPadding` | `double` | Top padding before regular item content starts. |
| `itemSpacing` | `double` | Vertical spacing between a regular item icon and label. |
| `itemLabelStyle` | `TextStyle` | Default label style for unselected regular items. |
| `selectedItemLabelStyle` | `TextStyle` | Default label style for selected regular items. |
| `itemIconSize` | `double` | Fallback icon size for regular items. |
| `filledSelectionSize` | `double` | Diameter of the filled selected background for regular items. |
| `defaultSelectionGradient` | `Gradient` | Default gradient used by filled regular items. |
| `centerSelectedSize` | `double` | Fallback center item size when selected. |
| `centerUnselectedSize` | `double` | Fallback center item size when unselected. |
| `centerButtonPadding` | `EdgeInsets` | Inner padding inside the circular center button. |
| `centerButtonColor` | `Color` | Background color behind the center image or child. |
| `centerShadowColor` | `Color` | Shadow color of the center button. |
| `centerShadowBlur` | `double` | Blur radius of the center button shadow. |
| `centerShadowOffset` | `Offset` | Offset of the center button shadow. |
| `centerLabelSpacing` | `double` | Fine-tunes the vertical distance between the center avatar and its label. |
| `centerLabelStyle` | `TextStyle` | Default label style for the unselected center item. |
| `selectedCenterLabelStyle` | `TextStyle` | Default label style for the selected center item. |
| `centerForegroundGradient` | `Gradient` | Foreground overlay gradient applied on top of the center image or child. |

### FloatingBottomNavigationCurve

| Parameter | Type | Meaning |
| --- | --- | --- |
| `topY` | `double` | Baseline Y position of the top edge on the left and right flat sections. |
| `shoulderWidth` | `double` | Width of the left and right transition zones leading into the center crest. |
| `crestWidth` | `double` | Diameter of the virtual circular guest used to build the convex top contour. |
| `crestHeight` | `double` | Vertical offset that lifts the circular guest above the bar top line. |
| `topCornerRadius` | `double` | Top-left and top-right corner radius of the bar background. |
| `bottomCornerRadius` | `double` | Bottom-left and bottom-right corner radius of the bar background. |
| `slopeLift` | `double` | Extra spacing between the bar top line and the circular guest. This slightly changes how open or tight the shoulder transition feels. |
| `shoulderRoundness` | `double` | Reserved parameter from an earlier curve model. It is currently kept for API compatibility and does not affect rendering. |
| `crestRoundness` | `double` | Reserved parameter from an earlier curve model. It is currently kept for API compatibility and does not affect rendering. |

## Tuning Tips

- The current top contour is built with a convex-notch path, inspired by `convex_bottom_bar`, using a circular guest shape plus mirrored shoulder transitions.
- Increase `crestWidth` to make the middle convex area wider and fuller.
- Increase `crestHeight` to raise the center item further above the bar top edge.
- Increase `shoulderWidth` to lengthen the shoulder transition on both sides.
- Increase `slopeLift` slightly if the shoulder transition feels too tight around the center.
- If the center avatar feels too low, reduce `centerTop`.

## Layout Notes

- Use `outerPadding: EdgeInsets.zero` to let the bar span the full page width.
- `adaptBottomSafeArea` is enabled by default and keeps content above the iOS home indicator area.
