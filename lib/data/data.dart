import 'package:flutter/material.dart';

class SliderModel {
  String imageAssetPath;
  String title;
  String desc;

  SliderModel({this.imageAssetPath, this.title, this.desc});

  void setImageAssetPath(String getImageAssetPath) {
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDesc(String getDesc) {
    desc = getDesc;
  }

  String getImageAssetPath() {
    return imageAssetPath;
  }

  String getTitle() {
    return title;
  }

  String getDesc() {
    return desc;
  }
}

List<SliderModel> getSlides() {
  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setDesc(
      "\nIn this everchanging world \n We are feeling less and less secure.\n");
  sliderModel.setTitle("Dangers EveryWhere!");
  sliderModel.setImageAssetPath('assets/seed.png');
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc(
      "\nBy locating DANGERS and SAFE ZONES Regrow makes you more secure than ever.\n");
  sliderModel.setTitle("Feeling Secure!");
  sliderModel.setImageAssetPath("assets/seed(1).png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc("\nLet's come together and REGROW the new world.\n");
  sliderModel.setTitle("Enjoy!!This is a interesting program");
  sliderModel.setImageAssetPath("assets/tree.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();
  return slides;
}
