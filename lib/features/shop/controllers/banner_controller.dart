import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/banner/banner_repository.dart';
import 'package:t_store/features/shop/models/banner_model.dart';

import '../../../utils/popups/loaders.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  final carouselCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  final CarouselController carouselController = CarouselController();

  @override
  void onInit() {
    fetchBanner();
    super.onInit();
  }

  void updatePageIndicator(index){
    carouselCurrentIndex.value = index;
  }

  void onCircularContainerClicked(int index){
    carouselCurrentIndex.value = index;
    carouselController.animateToPage(index);
  }


  Future<void> fetchBanner() async {
    try {
      isLoading.value = true;
      final bannerRepository = Get.put(BannerRepository());
      final banners = await bannerRepository.getAllBanners();
      this.banners.assignAll(banners);
    } catch (e) {
      TLoaders.errorSnackBar(title: "Oh snap!", message: e.toString());
    } finally{
      isLoading.value = false;
    }
  }
}