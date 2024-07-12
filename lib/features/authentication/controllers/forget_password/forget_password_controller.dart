import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/features/authentication/screens/password_configuration/reset_password.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  sendPasswordResetEmail() async {
    try {
      /// enable loading
      TFullScreenLoader.openLoadingDialog(
          "Sending password reset email", TImages.docerAnimation);

      /// check connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }

      /// form validation
      if (!forgetPasswordFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(title: "Email Sent", message: "Email link sent to reset your password".tr);
      
      Get.to(() => ResetPassword(email: email.text.trim()));
    }catch(e){
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
      TFullScreenLoader.stopLoading();
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      /// enable loading
      TFullScreenLoader.openLoadingDialog(
          "Sending password reset email", TImages.docerAnimation);

      /// check connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(title: "Email Sent", message: "Email link sent to reset your password".tr);

    }catch(e){
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
      TFullScreenLoader.stopLoading();
    }
  }
}