import 'dart:typed_data';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/model/platform_medium_model.dart';
import 'package:eliud_core/model/public_medium_model.dart';
import 'package:eliud_core/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/screen_size.dart';
import 'package:eliud_core/tools/storage/member_image_model_widget.dart';
import 'package:eliud_core/tools/storage/platform_image_model_widget.dart';
import 'package:eliud_core/tools/storage/public_image_model_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

abstract class SlideImageProvider {
  ImageProvider getImage(int index);
  int count();
}

class UrlSlideImageProvider extends SlideImageProvider {
  static String videoImage =
      'packages/eliud_pkg_feed/assets/undraw_co/undraw_online_video_ivvq.png';
  final List<String> urls;

  UrlSlideImageProvider(this.urls);

  @override
  ImageProvider getImage(int index) {
    return getTheImage(urls[index]);
  }

  @override
  int count() => urls.length;
}

ImageProvider getTheImage(String? url) {
  if (url == null) {
    return Image.asset(
        "assets/images/manypixels.co/404_Page_Not_Found _Flatline.png",
        package: "eliud_pkg_feed").image;
  } else {
    return Image.network(url).image;
  }
}

class MemberMediumSlideImageProvider extends SlideImageProvider {
  final List<MemberMediumModel> media;

  MemberMediumSlideImageProvider(this.media);

  @override
  ImageProvider getImage(int index) {
    var url = media[index].url;
    return getTheImage(url);
  }

  @override
  int count() => media.length;
}

class PlatformMediumSlideImageProvider extends SlideImageProvider {
  final List<PlatformMediumModel> media;

  PlatformMediumSlideImageProvider(this.media);

  @override
  ImageProvider getImage(int index) {
    var url = media[index].url;
    return getTheImage(url);
  }

  @override
  int count() => media.length;
}

class PublicMediumSlideImageProvider extends SlideImageProvider {
  final List<PublicMediumModel> media;

  PublicMediumSlideImageProvider(this.media);


  @override
  ImageProvider getImage(int index) {
    var url = media[index].url;
    return getTheImage(url);
  }

  @override
  int count() => media.length;
}

class Uint8ListSlideImageProvider extends SlideImageProvider {
  final List<Uint8List> data;

  Uint8ListSlideImageProvider(this.data);

  @override
  ImageProvider getImage(int index) {
    return Image.memory(data[index]).image;
  }

  @override
  int count() => data.length;
}
