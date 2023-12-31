import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:eliud_core_main/model/app_model.dart';
import 'package:eliud_core_main/apis/style/frontend/has_button.dart';
import 'package:eliud_core_helpers/etc/screen_size.dart';
import 'package:eliud_pkg_medium/tools/slider/slide_image_provider.dart';
import 'package:flutter/material.dart';

import 'multi_image_slide_provider.dart';

class AlbumSlider extends StatefulWidget {
  final AppModel app;
  final int initialPage;
  final SlideImageProvider slideImageProvider;

  final double? height;
  final bool withButtons;

  const AlbumSlider({
    super.key,
    required this.app,
    required this.initialPage,
    required this.slideImageProvider,
    this.height,
    this.withButtons = true,
  });

  @override
  State<AlbumSlider> createState() => _AlbumSliderState();
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
