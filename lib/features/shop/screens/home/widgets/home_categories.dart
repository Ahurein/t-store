import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/shimmer/category_shimmer.dart';
import 'package:t_store/features/shop/controllers/categories_controller.dart';
import 'package:t_store/features/shop/screens/sub_category/sub_category.dart';

import '../../../../../common/widgets/image_text_widgets/vertical_image_text.dart';
import '../../../../../utils/constants/image_strings.dart';

class THomeCategory extends StatelessWidget {
  const THomeCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    return Obx(() {
      if (categoryController.isLoading.value) return const TCategoryShimmer();

      if (categoryController.featuredCategories.isEmpty) {
        return Center(
          child: Text(
            "No Data Found!",
            style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),
          ),
        );
      }

      return SizedBox(
        height: 80,
        child: ListView.builder(
          itemCount: categoryController.featuredCategories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final category = categoryController.featuredCategories[index];

            return TVerticalImageText(
              title: category.name,
              image: category.image,
              onTap: () => Get.to(() => SubCategoriesScreen()),
            );
          },
        ),
      );
    });
  }
}
