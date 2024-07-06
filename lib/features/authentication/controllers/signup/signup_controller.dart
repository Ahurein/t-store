import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/data/repositories/user/user_repository.dart';
import 'package:t_store/features/authentication/screens/signup/verify_email.dart';
import 'package:t_store/utils/constants/image_strings.dart';

import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/user_model.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// variables
  final email = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();

  final hidePassword = true.obs;
  final privacyPolicy = false.obs;

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  Future<void> signup() async {
    try {
      /// enable loading
      TFullScreenLoader.openLoadingDialog(
          "We are processing your information", TImages.docerAnimation);

      /// check connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }

      /// form validation
      if (!signupFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }

      /// privacy policy check
      if (!privacyPolicy.value) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
            title: "Accept Privacy Policy",
            message:
                "In order to create account, you must have to read and accept the privacy policy & terms of use");
        return;
      }

      /// register
      final userCredential =
          await AuthenticationRepository.instance.registerWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
        username: username.text.trim(),
      );

      await UserRepository.instance.saveUserRecord(newUser);

      TLoaders.successSnackBar(
        title: "Congratulations",
        message: "Your account has been created! Verify email to continue",
      );

      TFullScreenLoader.stopLoading();
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));

    } catch (e) {
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
      TFullScreenLoader.stopLoading();
    }
  }
}
