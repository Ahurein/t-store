import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';
import '../../layouts/grid_layout.dart';
import '../product_cards/product_card_vertical.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          items: ["Name", 'Higher Price', 'Lower Price', 'Sale']
              .map((e) => DropdownMenuItem(child: Text(e), value: e))
              .toList(),
          onChanged: (Object? value) {},
        ),
        const SizedBox(height: TSizes.spaceBtwSections,),

        /// products
        TGridLayout(itemCount: 10,
            itemBuilder: (_, index) => TProductCardVertical()
        )
      ],
    );
  }
}
