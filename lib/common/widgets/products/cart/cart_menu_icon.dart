import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key,
    required this.onPressed,
    this.iconColor,
  });

  final VoidCallback onPressed;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {

    final isDark = THelperFunctions.isDarkMode(context);

    return Stack(
      children: [
        IconButton(
            onPressed: onPressed,
            icon: Icon(
              Iconsax.shopping_bag,
              color:  iconColor ?? (isDark ? TColors.white : TColors.dark),
            )),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: TColors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                "5",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: TColors.white, fontSizeFactor: 0.8),
              ),
            ),
          ),
        )
      ],
    );
  }
}
