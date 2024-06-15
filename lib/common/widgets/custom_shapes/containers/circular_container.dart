import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TRoundedContainer extends StatelessWidget {
  const TRoundedContainer({
    super.key,
    this.width,
    this.height,
    this.padding,
    this.child,
    this.radius = TSizes.cardRadiusLg,
     this.backgroundColor = TColors.white,
    this.margin,
    this.onTap,
    this.showBorder = false,
    this.borderColor = TColors.borderPrimary
  });

  final double? width;
  final double? height;
  final double radius;
  final EdgeInsets? padding;
  final Widget? child;
  final Color backgroundColor;
  final EdgeInsets? margin;
  final void Function()? onTap;
  final bool showBorder;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: backgroundColor,
          border: showBorder ? Border.all(color: borderColor) : null,
        ),
        child: child,
      ),
    );
  }
}
