import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:t_store/features/personalization/controllers/user_controller.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final userController = Get.put(UserController());

  /// variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();

  GlobalKey<FormState> loginFormKey = GlobalKey();


  @override
  void onInit() {
    email.text = localStorage.read("REMEMBER_ME_EMAIL") ?? "";
    password.text = localStorage.read("REMEMBER_ME_PASSWORD") ?? "";
    super.onInit();
  }

  Future<void> emailAndPasswordLogin() async {
    try {
      /// enable loading
      TFullScreenLoader.openLoadingDialog(
          "Logging you in...", TImages.docerAnimation);

      /// check connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }

      /// form validation
      if (!loginFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }

      /// remember me
      if(rememberMe.value){
        localStorage.write("REMEMBER_ME_EMAIL", email.text.trim());
        localStorage.write("REMEMBER_ME_PASSWORD", password.text.trim());
      }

      print('| ${email.text} .|. ${password.text} |');

      /// register
      final userCredential =
      await AuthenticationRepository.instance.loginWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      TLoaders.successSnackBar(
        title: "Success",
        message: "Login successful",
      );

      TFullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();

    } catch (e) {
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
      TFullScreenLoader.stopLoading();
    }
  }

  Future<void> googleSignIn() async {
    try{
      TFullScreenLoader.openLoadingDialog(
          "Logging you in...", TImages.docerAnimation);

      /// check connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }

      final userCredential = await AuthenticationRepository.instance.signInWithGoogle();
      await userController.saveUserRecord(userCredential);
      TFullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();

    }catch(e){
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

}