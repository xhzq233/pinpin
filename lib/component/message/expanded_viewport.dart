import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class ExpandedViewport extends Viewport {
  ExpandedViewport({
    Key? key,
    AxisDirection axisDirection = AxisDirection.down,
    AxisDirection? crossAxisDirection,
    double anchor = 0.0,
    required ViewportOffset offset,
    Key? center,
    double? cacheExtent,
    List<Widget> slivers = const <Widget>[],
  }) : super(
            key: key,
            slivers: slivers,
            axisDirection: axisDirection,
            crossAxisDirection: crossAxisDirection,
            anchor: anchor,
            offset: offset,
            center: center,
            cacheExtent: cacheExtent);

  @override
  RenderViewport createRenderObject(BuildContext context) {
    return _RenderExpandedViewport(
      axisDirection: axisDirection,
      crossAxisDirection: crossAxisDirection ??
          Viewport.getDefaultCrossAxisDirection(context, axisDirection),
      anchor: anchor,
      offset: offset,
      cacheExtent: cacheExtent,
    );
  }
}

class _RenderExpandedViewport extends RenderViewport {
  _RenderExpandedViewport({
    AxisDirection axisDirection = AxisDirection.down,
    required AxisDirection crossAxisDirection,
    required ViewportOffset offset,
    double anchor = 0.0,
    List<RenderSliver>? children,
    RenderSliver? center,
    double? cacheExtent,
  }) : super(
            axisDirection: axisDirection,
            crossAxisDirection: crossAxisDirection,
            offset: offset,
            anchor: anchor,
            children: children,
            center: center,
            cacheExtent: cacheExtent);

  // 首先循环遍历所有子节点，计算总的布局范围，并记录下需要扩展的子节点。然后调用 _attemptLayout 方法
  @override
  void performLayout() {
    super.performLayout();
    RenderSliver? expand;
    RenderSliver? p = firstChild;
    double totalLayoutExtent = 0;
    double BehindExtent = 0.0, FrontExtent = 0.0;
    while (p != null) {
      totalLayoutExtent += p.geometry!.scrollExtent;
      if (p is _RenderExpanded) {
        expand = p;
        FrontExtent = totalLayoutExtent;
      }

      p = childAfter(p);
    }
    double count = 0;
    BehindExtent = totalLayoutExtent - FrontExtent;
    if (expand != null && size.height > totalLayoutExtent) {
      _attemptLayout(expand, size.height, size.width,
          offset.pixels - FrontExtent - (size.height - totalLayoutExtent));
    }
  }

  // 根据偏移量计算出需要显示的子节点，并计算出它们的位置和大小。如果子节点需要缓存，则根据缓存策略进行缓存。最后，返回计算出的最小滚动偏移量。
  double _attemptLayout(RenderSliver expandPosition, double mainAxisExtent,
      double crossAxisExtent, double correctedOffset) {
    assert(!mainAxisExtent.isNaN);
    assert(mainAxisExtent >= 0.0);
    assert(crossAxisExtent.isFinite);
    assert(crossAxisExtent >= 0.0);
    assert(correctedOffset.isFinite);

    // centerOffset is the offset from the leading edge of the RenderViewport
    // to the zero scroll offset (the line between the forward slivers and the
    // reverse slivers).
    final double centerOffset = mainAxisExtent * anchor - correctedOffset;
    final double reverseDirectionRemainingPaintExtent =
        centerOffset.clamp(0.0, mainAxisExtent);

    final double forwardDirectionRemainingPaintExtent =
        (mainAxisExtent - centerOffset).clamp(0.0, mainAxisExtent);
    final double fullCacheExtent = mainAxisExtent + 2 * cacheExtent!;
    final double centerCacheOffset = centerOffset + cacheExtent!;
    final double reverseDirectionRemainingCacheExtent =
        centerCacheOffset.clamp(0.0, fullCacheExtent);
    final double forwardDirectionRemainingCacheExtent =
        (fullCacheExtent - centerCacheOffset).clamp(0.0, fullCacheExtent);


    final RenderSliver? leadingNegativeChild = childBefore(center!);
    // positive scroll offsets
    return layoutChildSequence(
      child: expandPosition,
      scrollOffset: math.max(0.0, -centerOffset),
      overlap:
          leadingNegativeChild == null ? math.min(0.0, -centerOffset) : 0.0,
      layoutOffset: centerOffset >= mainAxisExtent
          ? centerOffset
          : reverseDirectionRemainingPaintExtent,
      remainingPaintExtent: forwardDirectionRemainingPaintExtent,
      mainAxisExtent: mainAxisExtent,
      crossAxisExtent: crossAxisExtent,
      growthDirection: GrowthDirection.forward,
      advance: childAfter,
      remainingCacheExtent: forwardDirectionRemainingCacheExtent,
      cacheOrigin: centerOffset.clamp(-cacheExtent!, 0.0),
    );
  }
}

//tag
class SliverExpanded extends SingleChildRenderObjectWidget {
  SliverExpanded({super.key}) : super(child: Container());

  @override
  RenderSliver createRenderObject(BuildContext context) {
    return _RenderExpanded();
  }
}

class _RenderExpanded extends RenderSliver
    with RenderObjectWithChildMixin<RenderBox> {
  @override
  void performLayout() {
    geometry = SliverGeometry.zero;
  }
}
