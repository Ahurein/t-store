import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/image/t_circular_image.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text("Profile"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
                /// - Profile picture
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      const TCircularImage(image: TImages.user, width: 80, height: 80,),
                      TextButton(onPressed: (){}, child: const Text('Change Profile Picture'))
                    ],
                  ),
                ),

              /// - Details
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// - Profile info
              TSectionHeading(title: "Profile Information", showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),
              TProfileMenu(title: 'Name', value: "Coding with T",onPressed: (){}),
              TProfileMenu(title: 'Username', value: "4name",onPressed: (){}),
              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// - Personal info
              TSectionHeading(title: "Personal Information", showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),
              TProfileMenu(title: 'User ID', value: "49494",icon: Iconsax.copy ,onPressed: (){}),
              TProfileMenu(title: 'E-mail', value: "s@gmail.com",onPressed: (){}),
              TProfileMenu(title: 'Phone Number', value: "+23355545555",onPressed: (){}),
              TProfileMenu(title: 'Gender', value: "Male",onPressed: (){}),
              TProfileMenu(title: 'Date Of Birth', value: "10 Oct, 2022",onPressed: (){}),

              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              Center(
                child: TextButton(
                  onPressed: (){},
                  child: const Text("Close Account", style: TextStyle(color: Colors.red),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}