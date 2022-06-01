import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:eliud_pkg_medium/tools/slider/slide_image_provider.dart';
import 'package:flutter/material.dart';

class MultiImageSlideProvider extends EasyImageProvider {
  final SlideImageProvider slideImageProvider;

  @override
  final int initialIndex;

  MultiImageSlideProvider(this.slideImageProvider, {this.initialIndex = 0});

  @override
  ImageProvider imageBuilder(BuildContext context, int index) {
    return slideImageProvider.getImage(index);
  }

  @override
  int get imageCount => slideImageProvider.count();
}
