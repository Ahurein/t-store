import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/user/user_repository.dart';
import 'package:t_store/features/personalization/controllers/user_controller.dart';
import 'package:t_store/features/personalization/screens/profile/profile.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      /// enable loading
      TFullScreenLoader.openLoadingDialog(
          "We are updating you information", TImages.docerAnimation);

      /// check connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }

      /// form validation
      if (!updateUserNameFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }

      Map<String, dynamic> name  = {"FirstName": firstName.text.trim(), "LastName": lastName.text.trim() };
      await userRepository.updateSingleField(name);

      userController.user.value.firstName =  firstName.text.trim();
      userController.user.value.lastName =  lastName.text.trim();

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(title: "Congratulations", message: "Your name has been updated".tr);

      Get.to(() => ProfileScreen());
    }catch(e){
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
      TFullScreenLoader.stopLoading();
    }
  }
}