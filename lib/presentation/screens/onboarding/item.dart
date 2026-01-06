import 'package:ecommerce/core/constants/app_images.dart';
import 'package:ecommerce/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

class Item {
  final String img;
  final String title;
  final String subtitle;

  Item({required this.img, required this.title, required this.subtitle});
}

List<Item> getItems(BuildContext context) {
  return [
    Item(
      img: AppImages.men,
      title: AppStrings.onboardingTitle1,
      subtitle: AppStrings.onboardingSub1,
    ),
    Item(
      img: AppImages.women,
      title: AppStrings.onboardingTitle2,
      subtitle: AppStrings.onboardingSub2,
    ),
    Item(
      img: AppImages.child,
      title: AppStrings.onboardingTitle3,
      subtitle: AppStrings.onboardingSub3,
    ),
    Item(
      img: AppImages.baby,
      title: AppStrings.onboardingTitle4,
      subtitle: AppStrings.onboardingSub4,
    ),
  ];
}
