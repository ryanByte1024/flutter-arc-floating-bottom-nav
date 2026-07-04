# arc_floating_bottom_nav

[English](./README.md) | 简体中文

一个可自定义的 Flutter 悬浮底部导航栏组件，支持中间抬起的主按钮。

## 演示效果

![演示效果](https://raw.githubusercontent.com/ryanByte1024/flutter-arc-floating-bottom-nav/master/static/demo.gif)

## 功能特性

- 通过 `currentIndex` 控制选中态
- 支持单个居中抬起项，可使用图片或自定义组件
- 支持调节顶部曲线，实现圆滑的中间上凸效果
- 支持颜色、间距、模糊、阴影、文字样式和图标状态配置
- 适配底部安全区
- 自带 `example` 示例工程

## 安装

```yaml
dependencies:
  arc_floating_bottom_nav: ^0.1.0
```

## 使用示例

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

## 主要 API

- `FloatingBottomNavigationBar`
- `FloatingBottomNavigationItem`
- `FloatingBottomNavigationStyle`
- `FloatingBottomNavigationCurve`

## 参数说明

### FloatingBottomNavigationBar

| 参数 | 类型 | 含义 |
| --- | --- | --- |
| `items` | `List<FloatingBottomNavigationItem>` | 导航项列表。至少需要 3 个，并且必须且只能有 1 个 `isCenter: true` 的中间项。 |
| `currentIndex` | `int` | 当前选中的索引。 |
| `onTap` | `ValueChanged<int>` | 点击导航项时触发的回调。 |
| `style` | `FloatingBottomNavigationStyle` | 导航栏整体布局和视觉样式配置。 |

### FloatingBottomNavigationItem

| 参数 | 类型 | 含义 |
| --- | --- | --- |
| `label` | `String` | 图标或中间头像下方显示的文字。 |
| `icon` | `IconData?` | 普通导航项默认图标。 |
| `activeIcon` | `IconData?` | 普通导航项选中时显示的图标。 |
| `iconSize` | `double?` | 普通状态下的图标尺寸。 |
| `activeIconSize` | `double?` | 选中状态下的图标尺寸。 |
| `iconBuilder` | `Widget Function(BuildContext, bool, Color)?` | 普通导航项的自定义图标构建器，参数依次为 `context`、`selected`、解析后的颜色。 |
| `isCenter` | `bool` | 是否标记为唯一的中间抬起项。 |
| `filledSelection` | `bool` | 为 `true` 时，普通导航项在选中状态下会显示实心圆形底。 |
| `centerImage` | `ImageProvider<Object>?` | 中间项使用的图片资源。 |
| `centerChild` | `Widget?` | 不使用 `centerImage` 时，中间项显示的自定义内容。 |
| `centerSize` | `double?` | 中间项未选中时的尺寸。 |
| `activeCenterSize` | `double?` | 中间项选中时的尺寸。 |
| `activeColor` | `Color?` | 当前项激活态图标或文字颜色覆盖值。 |
| `inactiveColor` | `Color?` | 当前项未激活态图标或文字颜色覆盖值。 |
| `activeLabelStyle` | `TextStyle?` | 当前项激活态文字样式覆盖值。 |
| `inactiveLabelStyle` | `TextStyle?` | 当前项未激活态文字样式覆盖值。 |
| `selectionGradient` | `Gradient?` | 普通导航项选中实心圆背景使用的渐变。 |

### FloatingBottomNavigationStyle

| 参数 | 类型 | 含义 |
| --- | --- | --- |
| `outerPadding` | `EdgeInsets` | 整个导航栏组件外层留白。 |
| `barHeight` | `double` | 常规宽度屏幕下的导航栏高度。 |
| `compactBarHeight` | `double` | 窄屏下的导航栏高度。 |
| `barTop` | `double` | 常规宽度屏幕下，裁剪背景顶部的起始偏移。 |
| `compactBarTop` | `double` | 窄屏下，裁剪背景顶部的起始偏移。 |
| `centerGap` | `double` | 常规宽度屏幕下，为中间抬起项预留的水平空白宽度。 |
| `compactCenterGap` | `double` | 窄屏下，为中间抬起项预留的水平空白宽度。 |
| `centerTop` | `double` | 中间抬起项的顶部偏移，值越小越靠上。 |
| `adaptBottomSafeArea` | `bool` | 是否自动增加底部安全区内边距。 |
| `backgroundColor` | `Color` | 导航栏背景填充颜色。 |
| `blurSigma` | `double` | `BackdropFilter` 的模糊强度。 |
| `backgroundShadow` | `BoxShadow?` | 导航栏背景的可选阴影。 |
| `curve` | `FloatingBottomNavigationCurve` | 顶部中间上凸形状的配置。 |
| `selectedItemColor` | `Color` | 普通导航项默认选中颜色。 |
| `unselectedItemColor` | `Color` | 普通导航项默认未选中颜色。 |
| `selectedCenterLabelColor` | `Color` | 中间项默认选中标题颜色。 |
| `unselectedCenterLabelColor` | `Color` | 中间项默认未选中标题颜色。 |
| `itemTopPadding` | `double` | 普通导航项内容距离顶部的内边距。 |
| `itemSpacing` | `double` | 普通导航项图标与文字之间的垂直间距。 |
| `itemLabelStyle` | `TextStyle` | 普通导航项未选中时的默认文字样式。 |
| `selectedItemLabelStyle` | `TextStyle` | 普通导航项选中时的默认文字样式。 |
| `itemIconSize` | `double` | 普通导航项图标的兜底尺寸。 |
| `filledSelectionSize` | `double` | 普通导航项选中实心圆背景的直径。 |
| `defaultSelectionGradient` | `Gradient` | 普通导航项实心选中背景的默认渐变。 |
| `centerSelectedSize` | `double` | 中间项选中时的兜底尺寸。 |
| `centerUnselectedSize` | `double` | 中间项未选中时的兜底尺寸。 |
| `centerButtonPadding` | `EdgeInsets` | 中间圆形按钮内部的内边距。 |
| `centerButtonColor` | `Color` | 中间项图片或自定义内容背后的底色。 |
| `centerShadowColor` | `Color` | 中间按钮阴影颜色。 |
| `centerShadowBlur` | `double` | 中间按钮阴影模糊半径。 |
| `centerShadowOffset` | `Offset` | 中间按钮阴影偏移。 |
| `centerLabelSpacing` | `double` | 微调中间头像与文字之间的垂直距离。 |
| `centerLabelStyle` | `TextStyle` | 中间项未选中时的默认文字样式。 |
| `selectedCenterLabelStyle` | `TextStyle` | 中间项选中时的默认文字样式。 |
| `centerForegroundGradient` | `Gradient` | 覆盖在中间图片或自定义内容上的前景渐变。 |

### FloatingBottomNavigationCurve

| 参数 | 类型 | 含义 |
| --- | --- | --- |
| `topY` | `double` | 顶部左右平直区域的基准 Y 值。 |
| `shoulderWidth` | `double` | 左右两侧进入中间凸起前的过渡宽度。 |
| `crestWidth` | `double` | 用来生成中间凸起的虚拟圆形区域直径。 |
| `crestHeight` | `double` | 虚拟圆形区域相对导航栏顶部向上抬起的高度。 |
| `topCornerRadius` | `double` | 背景左上角和右上角圆角半径。 |
| `bottomCornerRadius` | `double` | 背景左下角和右下角圆角半径。 |
| `slopeLift` | `double` | 顶部基线与虚拟圆之间的额外间距，会轻微影响肩部过渡的松紧程度。 |
| `shoulderRoundness` | `double` | 旧版曲线模型遗留参数，当前仅为兼容 API 保留，不参与渲染。 |
| `crestRoundness` | `double` | 旧版曲线模型遗留参数，当前仅为兼容 API 保留，不参与渲染。 |

## 调参建议

- 当前顶部轮廓使用的是参考 `convex_bottom_bar` 的 convex-notch 路径，由虚拟圆形区域和两侧肩部过渡共同生成。
- 想让中间更宽、更饱满：增大 `crestWidth`。
- 想让中间更上凸：增大 `crestHeight`。
- 想让左右肩部过渡更长：增大 `shoulderWidth`。
- 如果肩部看起来包得太紧：小幅增大 `slopeLift`。
- 如果头像位置显得偏低：减小 `centerTop`。

## 布局说明

- 使用 `outerPadding: EdgeInsets.zero` 可以让导航栏横向铺满页面。
- `adaptBottomSafeArea` 默认开启，可避免内容压到 iOS Home Indicator 区域。
