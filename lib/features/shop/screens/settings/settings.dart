import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:t_store/common/widgets/image/t_circular_image.dart';
import 'package:t_store/common/widgets/list_tile/settings_menu_tile.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/personalization/screens/address/address.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

import '../../../../common/widgets/list_tile/user_profile_tile.dart';
import '../../../personalization/screens/profile/profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
                child: Column(
              children: [
                /// - App bar
                TAppBar(
                  title: Text(
                    'Account',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(color: TColors.white),
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
        
                /// - User profile card
                TUserProfileTile(onPressed: () => Get.to(const ProfileScreen()),),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                )
              ],
            )),
        
            /// - Body
             Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// - Account settings
                  TSectionHeading(title: 'Account Settings', showActionButton: false,),
                  SizedBox(height: TSizes.spaceBtwItems),
        
                  TSettingsMenuTile(icon: Iconsax.safe_home, title: "My Addresses", subTitle: "Set shopping delivery address", onTap: ()=> Get.to(() => UserAddressScreen())),
                  TSettingsMenuTile(icon: Iconsax.shopping_cart, title: "My Cart", subTitle: "Add, remove products and move to checkout", onTap: (){}),
                  TSettingsMenuTile(icon: Iconsax.bag_tick, title: "My Orders", subTitle: "In-progress and Completed Orders", onTap: (){}),
                  TSettingsMenuTile(icon: Iconsax.bank, title: "Bank Account", subTitle: "Withdraw balance to registered bank account", onTap: (){}),
                  TSettingsMenuTile(icon: Iconsax.discount_shape, title: "My Coupons", subTitle: "List of all the discounted coupons", onTap: (){}),
                  TSettingsMenuTile(icon: Iconsax.notification, title: "Notifications", subTitle: "Set any kind of notification message", onTap: (){}),
                  TSettingsMenuTile(icon: Iconsax.security_card, title: "Account Privacy", subTitle: "Manage data usage and connected accounts", onTap: (){}),
        
                  /// - App settings
                  SizedBox(height: TSizes.spaceBtwSections),
                  TSectionHeading(title: "App Settings", showActionButton: false),
                  SizedBox(height: TSizes.spaceBtwItems),
                  TSettingsMenuTile(icon: Iconsax.document_upload, title: "Load Data", subTitle: "Upload data to your cloud firebase", onTap: (){}),
                  TSettingsMenuTile(
                      icon: Iconsax.location,
                      title: "Geolocation",
                      subTitle: "Set recommendation based on location",
                    trailing: Switch(value: true, onChanged: (value){},),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: "Safe Mode",
                    subTitle: "Search result is safe for all ages",
                    trailing: Switch(value: false, onChanged: (value){},),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.image,
                    title: "HD Image Quality",
                    subTitle: "Set image quality to be seen",
                    trailing: Switch(value: true, onChanged: (value){},),
                  ),

                  /// - Logout
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(onPressed: (){}, child: const Text('Logout')),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections * 2.5)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
