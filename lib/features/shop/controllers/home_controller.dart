import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  static HomeController get instance => Get.find();

  final carouselCurrentIndex = 0.obs;

  final CarouselController carouselController = CarouselController();

  void updatePageIndicator(index){
    carouselCurrentIndex.value = index;
  }

  void onCircularContainerClicked(int index){
    carouselCurrentIndex.value = index;
    carouselController.animateToPage(index);
  }
}