import 'package:flutter/material.dart';
import 'package:winui/components/github_status.dart';
import 'dart:developer' as dev;

class GitHubStatusLayout extends StatelessWidget {
  const GitHubStatusLayout({
    super.key,
    required this.data,
  });

  final year = 2024;
  final List<dynamic> data;
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var dayDiff =
        DateTime(now.year, now.month + 1, 0).difference(DateTime(year));
    return CustomMultiChildLayout(
      delegate: GithubLayoutDelegate(data: data, numOfCell: dayDiff.inDays),
      children: [
        for (int i = 0; i < dayDiff.inDays; i++)
          LayoutId(
            id: i,
            child: StateBox(),
          ),
      ],
    );
  }
}

class GithubLayoutDelegate extends MultiChildLayoutDelegate {
  GithubLayoutDelegate(
      {required this.data, this.year, required this.numOfCell});
  final List<dynamic> data;
  int? year = DateTime.now().year;
  final int numOfCell;
  @override
  void performLayout(Size size) {
    final double columnWidth = size.width;
    Offset childPosition = Offset.zero;

    var count = 1;
    for (int i = 0; i < numOfCell; i++) {
      if (hasChild(i)) {
        final Size currentSize = layoutChild(
          i,
          BoxConstraints(maxHeight: size.height, maxWidth: columnWidth),
        );
        positionChild(i, childPosition);

        if (count == 7) {
          childPosition += Offset(currentSize.width, 0);
          childPosition -=
              Offset(0, currentSize.height * 6);
          count = 1;
        } else {
          childPosition +=
              Offset(0, currentSize.height);
          count++;
        }
      }
    }
  }

  // automatically cause a relayout, like any other widget.
  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) => false;
}
