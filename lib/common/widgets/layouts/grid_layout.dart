import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class TGridLayout extends StatelessWidget {
  const TGridLayout({
    Key? key,
    required this.itemCount,
    this.mainAxisExtent = 288,
    required this.itemBuilder,
  }) : super(key: key);

  final int itemCount;
  final double mainAxisExtent;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: TSizes.gridViewSpacing,
          crossAxisSpacing: TSizes.gridViewSpacing,
          mainAxisExtent: mainAxisExtent),
      itemBuilder: itemBuilder,
    );
  }
}
