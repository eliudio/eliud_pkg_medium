  import 'dart:typed_data';

import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/tools/etc.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/tools/storage/member_medium_helper.dart';
import 'package:eliud_core/tools/storage/upload_info.dart';
import 'package:eliud_pkg_medium/tools/slider/carousel_slider.dart';
import 'package:eliud_pkg_medium/tools/view/video_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
 * I asssume we want a member storage section on firebase storage. A bucket / directory.
 * I assume we want a model representation of these files which we can use
 * to reference from within a feed, from a gallery, etc...
 * I assume these photos are stored in /appId/memberId/...
 * I assume we might want to have a ui to allow to organise photos in a user image repository
 */
typedef void MemberMediumAvailable(MemberMediumModel? memberMediumModel);

abstract class AbstractMediumPlatform {
  static AbstractMediumPlatform? platform;

  void showPhotos(BuildContext context, List<MemberMediumModel> media, int initialPage) {
    var photos = media.where((memberMedium) => memberMedium.mediumType == MediumType.Photo).toList();
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return AlbumSlider(title: "Photos",
          slideImageProvider: MemberMediumSlideImageProvider(ListHelper.getMemberMediumModelList(photos)),
          initialPage: initialPage);
    }));
  }

  Future<void> showVideo(BuildContext context, MemberMediumModel memberMediumModel) async {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return VideoView(
          sourceType: SourceType.Network, source: memberMediumModel.url!);
    }));
  }

  /*
   * Allows the user to take a photo
   * When photo is selected feedbackFunction is triggered
   */
  void takePhoto(BuildContext context, String appId, String ownerId, List<String> readAccess, MemberMediumAvailable feedbackFunction, FeedbackProgress? feedbackProgress, {bool? allowCrop});

  /*
   * Allows the user to take a photo
   * When photo is selected feedbackFunction is triggered
   */
  void takeVideo(BuildContext context, String appId, String ownerId, List<String> readAccess, MemberMediumAvailable feedbackFunction, FeedbackProgress? feedbackProgress);

  void uploadPhoto(BuildContext context, String appId, String ownerId, List<String> readAccess, MemberMediumAvailable feedbackFunction, FeedbackProgress? feedbackProgress, {bool? allowCrop});

  /*
   * Allows the user to select a photo from library
   * When photo is selected feedbackFunction is triggered
   */
  void uploadVideo(BuildContext context, String appId, String ownerId, List<String> readAccess, MemberMediumAvailable feedbackFunction, FeedbackProgress? feedbackProgress);

  bool hasCamera();

  Future<void> processPhoto(
      String memberMediumDocumentID,
      String appId,
      String baseName,
      String thumbnailBaseName,
      String ownerId,
      Uint8List bytes,
      List<String> readAccess,
      MemberMediumAvailable feedbackFunction,
      FeedbackProgress? feedbackProgress,
      ) async {
    try {
      var memberMediumModel =
      await MemberMediumHelper.createThumbnailUploadPhotoData(memberMediumDocumentID,
          appId, bytes, baseName, thumbnailBaseName, ownerId, readAccess,
          feedbackProgress: feedbackProgress);
      feedbackFunction(memberMediumModel);
    } catch (error) {
      print('Error trying to processPhoto: ' + error.toString());
      feedbackFunction(null);
    }
  }

}
