import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/data/repositories/user/user_repository.dart';
import 'package:t_store/features/authentication/models/user_model.dart';
import 'package:t_store/features/authentication/screens/login/login.dart';
import 'package:t_store/features/personalization/screens/profile/widgets/re_authenticate_user_login_form.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';
import 'package:t_store/utils/popups/loaders.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepository = Get.put(UserRepository());
  Rx<UserModel> user = UserModel.empty().obs;
  final profileLoading = false.obs;

  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();


  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    }catch (e) {
      user(UserModel.empty());
    }finally {
      profileLoading.value = false;
    }
  }

  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      if(userCredential != null){
        final nameParts = UserModel.nameParts(userCredential.user?.displayName ?? "");
        final username = UserModel.generateUsername(userCredential.user?.displayName ?? "");

        final user = UserModel(
          id: userCredential.user!.uid,
          firstName: nameParts[0],
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(" "): "",
          email: userCredential.user?.email ?? "",
          phoneNumber: userCredential.user?.phoneNumber ?? "",
          profilePicture: userCredential.user?.photoURL?? "",
          username: username,
        );

        await userRepository.saveUserRecord(user);
      }
    } catch (e) {
      TLoaders.warningSnackBar(
        title: "Data not saved",
        message:
            'Something went wrong while saving your information. you can re-save your data in your profile',
      );
    }
  }

  void deleteAccountWarningPopup(){
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: 'Delete account',
      middleText: 'Are you sure you want to delete your account permanently? This action is not reversible',
      confirm: ElevatedButton(onPressed: () => deleteUserAccount(), child: const Padding(padding: EdgeInsets.symmetric(horizontal: TSizes.lg), child: Text("Delete"),)),
      cancel: OutlinedButton(onPressed: () => Navigator.of(Get.overlayContext!).pop(), child: const Text("Delete"))
    );
  }

  Future<void> deleteUserAccount() async {
    try{
      TFullScreenLoader.openLoadingDialog("Processing", TImages.docerAnimation);
      final auth = AuthenticationRepository.instance;
      final providers = auth.authUser!.providerData.map((e) => e.providerId);
      if(providers.isNotEmpty){
        if(providers.contains("google.com")){
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          TFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        }else if(providers.contains("password")){
          TFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());

        }
      }
    }catch(e){
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: "Oh snap!", message: e.toString());
    }
  }

  void reAuthenticateEmailAndPassword(){

  }

}
