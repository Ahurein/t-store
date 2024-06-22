import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TSingleAddress extends StatelessWidget {
  const TSingleAddress({super.key, required this.selectedAddress});

  final bool selectedAddress;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return TRoundedContainer(
      padding: EdgeInsets.all(TSizes.md),
      width: double.infinity,
        showBorder: true,
        backgroundColor: selectedAddress ? TColors.primary.withOpacity(0.5) : Colors.transparent,
        borderColor: selectedAddress ? Colors.transparent : isDark ? TColors.darkerGrey  : TColors.grey,
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      child: Stack(
        children: [
          Positioned(
            right: 5,
        top: 0,
            child: Icon(
              selectedAddress ? Iconsax.tick_circle5 : null,
              color: selectedAddress ? isDark ? TColors.light : TColors.dark.withOpacity(0.6) : null,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'John doe',
                maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: TSizes.sm/2,),
              const Text('(+233) 522 565', overflow: TextOverflow.ellipsis, maxLines: 1,),
              const SizedBox(height: TSizes.sm/2,),
              const Text('82232332 timoty coves, south asia, accra ghana sdf', softWrap: true,)
            ],
          )
        ],
      ),
    );
  }
}
