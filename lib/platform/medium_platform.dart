  import 'dart:typed_data';

import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/model/platform_medium_model.dart';
import 'package:eliud_core/tools/etc.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/tools/router_builders.dart';
import 'package:eliud_core/tools/storage/upload_info.dart';
import 'package:eliud_pkg_medium/tools/slider/carousel_slider.dart';
import 'package:eliud_pkg_medium/tools/view/video_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'access_rights.dart';

/*
 * I asssume we want a member storage section on firebase storage. A bucket / directory.
 * I assume we want a model representation of these files which we can use
 * to reference from within a feed, from a gallery, etc...
 * I assume these photos are stored in /appId/memberId/...
 * I assume we might want to have a ui to allow to organise photos in a user image repository
 */
typedef void MediumAvailable(dynamic? mediumModel);
typedef AccessRights AccessRightsProvider();

abstract class AbstractMediumPlatform {
  static AbstractMediumPlatform? platform;

  void showPhotos(BuildContext context, AppModel app, List<MemberMediumModel> media, int initialPage) {
    var photos = media.where((memberMedium) => memberMedium.mediumType == MediumType.Photo).toList();
    Navigator.push(context, pageRouteBuilder(app, page: AlbumSlider(app: app, title: "Photos",
          slideImageProvider: MemberMediumSlideImageProvider(ListHelper.getMemberMediumModelList(photos)),
          initialPage: initialPage)));
  }

  void showPhotosPlatform(BuildContext context, AppModel app, List<PlatformMediumModel> media, int initialPage) {
    var photos = media.where((memberMedium) => memberMedium.mediumType == PlatformMediumType.Photo).toList();
    Navigator.push(context, pageRouteBuilder(app, page: AlbumSlider(app: app, title: "Photos",
          slideImageProvider: PlatformMediumSlideImageProvider(ListHelper.getPlatformMediumModelList(photos)),
          initialPage: initialPage)));
  }

  Future<void> showVideo(BuildContext context, AppModel app, MemberMediumModel memberMediumModel) async {
    Navigator.push(context, pageRouteBuilder(app, page: VideoView(
          sourceType: SourceType.Network, source: memberMediumModel.url!)
    ));
  }

  Future<void> showVideoPlatform(BuildContext context, AppModel app, PlatformMediumModel platformMediumModel) async {
    Navigator.push(context, pageRouteBuilder(app, page: VideoView(
          sourceType: SourceType.Network, source: platformMediumModel.url!)
    ));
  }

  /*
   * Allows the user to take a photo
   * When photo is selected feedbackFunction is triggered
   */
  void takePhoto(BuildContext context, AppModel app, String ownerId,       AccessRightsProvider accessRightsProvider, MediumAvailable feedbackFunction, FeedbackProgress? feedbackProgress, {bool? allowCrop});

  /*
   * Allows the user to take a photo
   * When photo is selected feedbackFunction is triggered
   */
  void takeVideo(BuildContext context, AppModel app, String ownerId, AccessRightsProvider accessRightsProvider, MediumAvailable feedbackFunction, FeedbackProgress? feedbackProgress);

  void uploadPhoto(BuildContext context, AppModel app, String ownerId, AccessRightsProvider accessRightsProvider, MediumAvailable feedbackFunction, FeedbackProgress? feedbackProgress, {bool? allowCrop});

  /*
   * Allows the user to select a photo from library
   * When photo is selected feedbackFunction is triggered
   */
  void uploadVideo(BuildContext context, AppModel app, String ownerId, AccessRightsProvider accessRightsProvider, MediumAvailable feedbackFunction, FeedbackProgress? feedbackProgress);

  /*
   * Some implementations, e.g. android, have access to the camera. Some other implementations, e.g. web, don't
   */
  bool hasCamera();

  /*
   * Some implementations, e.g. android, have access to the assets. Some other implementations, e.g. web, don't
   */
  bool hasAccessToAssets();


  /*
   * Some implementations, e.g. android, have access to the local file system, whilst others don't, e.g. Web
   */
  bool hasAccessToLocalFilesystem();

  Future<void> processPhoto(
      String memberMediumDocumentID,
      AppModel app,
      String baseName,
      String thumbnailBaseName,
      String ownerId,
      Uint8List bytes,
      AccessRightsProvider accessRightsProvider,
      MediumAvailable feedbackFunction,
      FeedbackProgress? feedbackProgress,
      ) async {
    try {
      var mediumModel =  await accessRightsProvider().getMediumHelper(app, ownerId).createThumbnailUploadPhotoData(memberMediumDocumentID,
          bytes, baseName, thumbnailBaseName,
          feedbackProgress: feedbackProgress);
      feedbackFunction(mediumModel);
    } catch (error) {
      print('Error trying to processPhoto: ' + error.toString());
      feedbackFunction(null);
    }
  }

}
