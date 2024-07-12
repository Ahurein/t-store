import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/user/user_repository.dart';
import 'package:t_store/features/authentication/models/user_model.dart';
import 'package:t_store/utils/popups/loaders.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepository = Get.put(UserRepository());
  Rx<UserModel> user = UserModel.empty().obs;
  final profileLoading = false.obs;


  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
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

}
