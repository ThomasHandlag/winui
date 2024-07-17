import 'package:flutter/material.dart';

class FlexLayout extends StatelessWidget {
  const FlexLayout(
      {super.key,
      required this.children,
      required this.gap,
      required this.width, required this.height});
  final List<Widget> children;
  final double gap;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: CustomMultiChildLayout(
            delegate: FlexLayoutDelegate(
                childCount: children.length, parentSize: Size(width, height), gap: gap),
            children: [
              for (int i = 0; i < children.length; i++)
                LayoutId(id: i, child: children[i]),
            ],
          ),
        ));
  }
}

class FlexLayoutDelegate extends MultiChildLayoutDelegate {
  final int childCount;
  final Size parentSize;
  double gap;
  FlexLayoutDelegate(
      {required this.parentSize, required this.childCount, this.gap = 10});
  @override
  void performLayout(Size size) {
    Offset childPosition = Offset(gap, gap);
    for (int i = 0; i < childCount; i++) {
      if (hasChild(i)) {
        final currentSize = layoutChild(
            i, BoxConstraints(maxHeight: size.height, maxWidth: size.width));
        positionChild(i, childPosition);

        if ((childPosition.dx + currentSize.width * 2) < parentSize.width) {
          childPosition += Offset(currentSize.width + gap, 0);
        } else {
          childPosition -= Offset((childPosition.dx - gap), 0);
          childPosition += Offset(0, currentSize.height + gap);
        }
      }
    }
  }

  @override
  bool shouldRelayout(FlexLayoutDelegate oldDelegate) =>
      oldDelegate.parentSize != parentSize;
}
