import 'package:get/get.dart';

class Dimensions {
  // HEIGHT 876.5714285714286
  // WIDTH 411.42857142857144
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double pageView = screenHeight / 2.64;
  static double pageViewConrainer = screenHeight / 3.84;
  static double pageViewText = screenHeight / 7.03;
// dynamic heght padding and marign
  static double height10 = screenHeight / 84.4;
  static double height15 = screenHeight / 56.27;
  static double height20 = screenHeight / 42.2;
  static double height30 = screenHeight / 28.15;
  static double height45 = screenHeight / 18.76;
  static double height90 = screenHeight / 9.73;
  static double height200 = screenHeight / 4.38;

// dynamic width padding and marign
  static double width10 = screenWidth / 41.4;
  static double width15 = screenWidth / 27.42;
  static double width20 = screenWidth / 20.57;
  static double width30 = screenWidth / 13.71;
  static double width40 = screenWidth / 10.28;
  static double width45 = screenWidth / 9.45;
  static double width55 = screenWidth / 7.48;

// font
  static double font16 = screenHeight / 52.75;
  static double font18 = screenHeight / 48.69;
  static double font20 = screenHeight / 42.2;
  static double font25 = screenWidth / 16.45;
  static double font30 = screenWidth / 13.71;

// radius
  static double radius15 = screenHeight / 56.27;
  static double radius20 = screenHeight / 42.2;
  static double radius28 = screenHeight / 42.2;
  static double radius30 = screenHeight / 28.2;

// icons
  static double iconSize24 = screenHeight / 35.17;
  static double iconSize16 = screenHeight / 52.75;

//list view size
  static double listViewImgSize = screenWidth / 3.25;
  static double listViewTextContSize = screenWidth / 3.9;

// popular food
  static double popularFoodImgSize = screenHeight / 2.41;

// bottom height
  static double bottomHeightBar = screenHeight / 7.03;
}
