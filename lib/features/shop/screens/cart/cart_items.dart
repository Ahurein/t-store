import 'package:flutter/material.dart';

import '../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../common/widgets/texts/product_price_text.dart';
import '../../../../utils/constants/sizes.dart';
import 'add_remove_button.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({Key? key, this.showAddRemoveButton = true}) : super(key: key);

  final bool showAddRemoveButton;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (_, __) => const SizedBox(
        height: TSizes.spaceBtwSections,
      ),
      itemCount: 2,
      itemBuilder: (_, index) =>  Column(
        children: [
          TCartItem(),
          if(showAddRemoveButton) SizedBox(height: TSizes.spaceBtwItems,),
          if(showAddRemoveButton) Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(width: 70,),
                  TProductQuantityWithAddRemoveButton()
                ],
              ),
              TProductPriceText(price: '256')
            ],
          )
        ],
      ),
    );
  }
}
