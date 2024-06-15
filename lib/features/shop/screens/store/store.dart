import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/appbar/tabbar.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:t_store/common/widgets/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/image/t_circular_image.dart';
import '../../../../common/widgets/texts/t_brand_title_text_with_verified_icon.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: TAppBar(
          title: Text("Store", style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            TCartCounterIcon(
              onPressed: () {},
            )
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: THelperFunctions.isDarkMode(context)
                    ? TColors.black
                    : TColors.white,
                expandedHeight: 440,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      /// -- search bar
                      const TSearchContainer(
                          text: "",
                          showBackground: false,
                          padding: EdgeInsets.zero),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      /// --Featured brands
                      TSectionHeading(title: "Featured Brands", onPressed: (){},),
                      const SizedBox(height: TSizes.spaceBtwItems / 2,),
                      TGridLayout(itemCount: 4, mainAxisExtent: 80, itemBuilder: (_, index){
                        return GestureDetector(
                          onTap: (){},
                          child: TRoundedContainer(
                            padding: const EdgeInsets.all(TSizes.sm),
                            showBorder: true,
                            backgroundColor: Colors.transparent,
                            child: Row(
                              children: [
                                /// <-- Icon
                                Flexible(
                                  child: TCircularImage(
                                    image: TImages.clothIcon,
                                    isNetworkImage: false,
                                    backgroundColor: Colors.transparent,
                                    overlayColor: THelperFunctions.isDarkMode(context)? TColors.white : TColors.black,
                                  ),
                                ),
                                const SizedBox(width: TSizes.spaceBtwItems),

                                /// - Text
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const TBrandTitleTextWithVerifiedIcon(title: 'Nike', brandTextSize: TextSizes.large),
                                      Text("256 products",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context).textTheme.labelMedium,

                                      )
                                    ],),
                                )
                              ],
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                ),
                bottom: TTabBar(
                  tabs: [
                    Tab(child: Text('tab one')),
                    Tab(child: Text('tab one')),
                    Tab(child: Text('tab one')),
                    Tab(child: Text('tab one')),
                    Tab(child: Text('tab one')),

                  ],
                ),

              )
            ];
          },
          body: Container(),
        ),
      ),
    );
  }
}