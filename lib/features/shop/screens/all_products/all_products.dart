import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:t_store/utils/constants/sizes.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        title: Text('Popular Products'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// dropdown
              DropdownButtonFormField(
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
          ),
        ),
      ),
    );
  }
}
