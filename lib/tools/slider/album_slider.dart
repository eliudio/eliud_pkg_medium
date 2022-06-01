import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/model/platform_medium_model.dart';
import 'package:eliud_core/model/public_medium_model.dart';
import 'package:eliud_core/style/frontend/has_button.dart';
import 'package:eliud_core/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/screen_size.dart';
import 'package:eliud_core/tools/storage/member_image_model_widget.dart';
import 'package:eliud_core/tools/storage/platform_image_model_widget.dart';
import 'package:eliud_core/tools/storage/public_image_model_widget.dart';
import 'package:eliud_pkg_medium/tools/slider/slide_image_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

import 'multi_image_slide_provider.dart';

class AlbumSlider extends StatefulWidget {
  final AppModel app;
  final int initialPage;
  final SlideImageProvider slideImageProvider;

  final double? height;
  final bool withButtons;

  const AlbumSlider({
    Key? key,
    required this.app,
    required this.initialPage,
    required this.slideImageProvider,
    this.height,
    this.withButtons = true,
  }) : super(key: key);

  @override
  _AlbumSliderState createState() => _AlbumSliderState();
}

class _AlbumSliderState extends State<AlbumSlider> {
  late final _pageController = PageController(initialPage: widget.initialPage);
  static const _kDuration = Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  late final _easyEmbeddedImageProvider = MultiImageSlideProvider(
      widget.slideImageProvider,
      initialIndex: widget.initialPage);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
          height: widget.height ??
              fullScreenHeight(context) - (widget.withButtons ? 150 : 0),
          child: Center(child: CircularProgressIndicator())),
      Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: widget.height ??
                fullScreenHeight(context) - (widget.withButtons ? 150 : 0),
            child: EasyImageViewPager(
                easyImageProvider: _easyEmbeddedImageProvider,
                pageController: _pageController),
          ),
        ],
      )),
      if (widget.withButtons)
        Center(
            child: Row(
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            button(widget.app, context, label: '<< Prev', onPressed: () {
              final currentPage = _pageController.page?.toInt() ?? 0;
              _pageController.animateToPage(
                  currentPage > 0 ? currentPage - 1 : 0,
                  duration: _kDuration,
                  curve: _kCurve);
            }),
            Spacer(),
            button(widget.app, context, label: 'Next >>', onPressed: () {
              final currentPage = _pageController.page?.toInt() ?? 0;
              final lastPage = _easyEmbeddedImageProvider.imageCount - 1;
              _pageController.animateToPage(
                  currentPage < lastPage ? currentPage + 1 : lastPage,
                  duration: _kDuration,
                  curve: _kCurve);
            }),
          ],
        )),
    ]);
  }
}

class CustomImageProvider extends EasyImageProvider {
  @override
  final int initialIndex;
  final List<String> imageUrls;

  CustomImageProvider({required this.imageUrls, this.initialIndex = 0})
      : super();

  @override
  ImageProvider<Object> imageBuilder(BuildContext context, int index) {
    return NetworkImage(imageUrls[index]);
  }

  @override
  int get imageCount => imageUrls.length;
}
