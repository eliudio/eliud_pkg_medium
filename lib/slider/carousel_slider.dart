import 'dart:typed_data';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/storage/fb_storage_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

abstract class SlideImageProvider {
  Widget getImage(int index);
  int count();
}

class UrlSlideImageProvider extends SlideImageProvider {
  static String videoImage =
      'packages/eliud_pkg_feed/assets/undraw_co/undraw_online_video_ivvq.png';
  final List<String> urls;

  UrlSlideImageProvider(this.urls);

  @override
  Widget getImage(int index) {
    var widget = Image.network(urls[index]);
    if (widget == null) {
      return Image.asset(
          "assets/images/manypixels.co/404_Page_Not_Found _Flatline.png",
          package: "eliud_pkg_feed");
    } else {
      return widget;
    }
  }

  @override
  int count() => urls.length;
}

class MemberMediumSlideImageProvider extends SlideImageProvider {
  final List<MemberMediumModel> media;

  MemberMediumSlideImageProvider(this.media);

  @override
  Widget getImage(int index) {
    return MemberImageModelWidget(
      memberMediumModel: media[index],
      showThumbnail: false,
      defaultWidget: Image.asset(
          "assets/images/manypixels.co/404_Page_Not_Found _Flatline.png",
          package: "eliud_pkg_feed"),
    );
  }

  @override
  int count() => media.length;
}

class Uint8ListSlideImageProvider extends SlideImageProvider {
  final List<Uint8List> data;

  Uint8ListSlideImageProvider(this.data);

  @override
  Widget getImage(int index) {
    return Image.memory(data[index]);
  }

  @override
  int count() => data.length;
}

class AlbumSlider extends StatefulWidget {
  final String? title;
  final SlideImageProvider slideImageProvider;
  final int? initialPage;
  final bool? withCloseButton;
  final bool? withNextPrevButton;

  AlbumSlider(
      {Key? key,
      this.title,
      required this.slideImageProvider,
      this.initialPage,
      this.withCloseButton = true,
      this.withNextPrevButton = true})
      : super(key: key);

  @override
  _AlbumSliderState createState() => _AlbumSliderState();
}

class _AlbumSliderState extends State<AlbumSlider> {
  CarouselSliderController? _sliderController;

  @override
  void initState() {
    super.initState();
    _sliderController = CarouselSliderController();
  }

  Widget getCarousel() {
    var height = kToolbarHeight;
    return CarouselSlider.builder(
      unlimitedMode: true,
      controller: _sliderController,
      slideBuilder: (index) {
        return Stack(
          children: <Widget>[
            StyleRegistry.registry()
                .styleWithContext(context)
                .frontEndStyle()
                .progressIndicatorStyle()
                .progressIndicator(context),
            Center(
                child: Container(
              height: MediaQuery.of(context).size.height - height,
              child: PinchZoom(
                image: widget.slideImageProvider.getImage(index),
                zoomedBackgroundColor: Colors.black.withOpacity(0.5),
                resetDuration: const Duration(milliseconds: 100),
                maxScale: 2.5,
                onZoomStart: () {},
                onZoomEnd: () {},
              ),
            )),
          ],
        );
      },
      slideTransform: DefaultTransform(),
      slideIndicator: CircularSlideIndicator(
        padding: EdgeInsets.only(bottom: 0),
        currentIndicatorColor: Colors.red,
        indicatorBackgroundColor: Colors.white,
      ),
      itemCount: widget.slideImageProvider.count(),
      initialPage: widget.initialPage!,
      enableAutoSlider: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      getCarousel(),
    ];

    if ((widget.withCloseButton != null) && (widget.withCloseButton!)) {
      widgets.add(Align(
          alignment: Alignment.topRight,
          child: TextButton(
            child: Icon(Icons.close, color: Colors.red, size: 30),
            onPressed: () {
              Navigator.maybePop(context);
            },
          )));
    }
    if ((widget.withNextPrevButton != null) && (widget.withNextPrevButton!)) {
      widgets.add(Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            child: Icon(Icons.navigate_next, color: Colors.red, size: 50),
            onPressed: () {
              _sliderController!.nextPage();
            },
          )));
      widgets.add(Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            child: Icon(Icons.navigate_before, color: Colors.red, size: 50),
            onPressed: () {
              _sliderController!.previousPage();
            },
          )));
    }
    return Stack(children: widgets);
  }
}
