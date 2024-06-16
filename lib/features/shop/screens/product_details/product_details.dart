import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:t_store/common/widgets/icons/t_circular_icon.dart';
import 'package:t_store/common/widgets/image/t_rounded_image.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({Key? key}) : super(key: key);

  @override
    Widget build(BuildContext context) {
      final isDark = THelperFunctions.isDarkMode(context);

      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              /// - Product image slider
              TCurvedEdgeWidget(
                child: Container(
                  color: isDark ? TColors.darkerGrey : TColors.light,
                  child: Stack(
                    children: [
                      /// Main large image
                      const SizedBox(
                        height: 400,
                        child: Padding(
                          padding: EdgeInsets.all(TSizes.productImageRadius * 2),
                          child: Center(
                            child: Image(
                              image: AssetImage(TImages.productImage5),
                            ),
                          ),
                        ),
                      ),

                      /// Slider
                        Positioned(
                          right: 0,
                          bottom: 30,
                          left: TSizes.defaultSpace / 2,
                          child: SizedBox(
                            height: 80,
                            child: ListView.separated(
                              separatorBuilder: (_, __) => const SizedBox(
                                width: TSizes.spaceBtwItems,
                              ),
                              itemCount: 8,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (_, index) => TRoundedImage(
                                imageUrl: TImages.productImage3,
                                width: 80,
                                border: Border.all(color: TColors.primary),
                                padding: const EdgeInsets.all(TSizes.sm),
                                backgroundColor:
                                    isDark ? TColors.dark : TColors.white,
                              ),
                            ),
                          ),
                        ),
                      
                      /// App bar
                      const TAppBar(
                        showBackArrow: true,
                        actions: [
                          TCircularIcon(icon: Iconsax.heart5, color: Colors.red,)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
}
