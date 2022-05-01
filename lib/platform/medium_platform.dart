import 'dart:typed_data';

import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/model/platform_medium_model.dart';
import 'package:eliud_core/model/public_medium_model.dart';
import 'package:eliud_core/package/medium_api.dart';
import 'package:eliud_core/tools/etc.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/tools/router_builders.dart';
import 'package:eliud_core/tools/storage/upload_info.dart';
import 'package:eliud_pkg_medium/tools/slider/carousel_slider.dart';
import 'package:eliud_pkg_medium/tools/view/video_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../wizards/widgets/member_photo_widget.dart';
import '../wizards/widgets/platform_photo_widget.dart';
import '../wizards/widgets/public_photo_widget.dart';

abstract class AbstractMediumPlatform extends MediumApi {
  static AbstractMediumPlatform? platform;

  void showPhotos(BuildContext context, AppModel app,
      List<MemberMediumModel> media, int initialPage) {
    var photos = media
        .where((memberMedium) => memberMedium.mediumType == MediumType.Photo)
        .toList();
    Navigator.push(
        context,
        pageRouteBuilder(app,
            page: AlbumSlider(
                app: app,
                title: "Photos",
                slideImageProvider: MemberMediumSlideImageProvider(
                    ListHelper.getMemberMediumModelList(photos)),
                initialPage: initialPage)));
  }

  void showPhotosPlatform(BuildContext context, AppModel app,
      List<PlatformMediumModel> media, int initialPage) {
    var photos = media
        .where((memberMedium) =>
            memberMedium.mediumType == PlatformMediumType.Photo)
        .toList();
    Navigator.push(
        context,
        pageRouteBuilder(app,
            page: AlbumSlider(
                app: app,
                title: "Photos",
                slideImageProvider: PlatformMediumSlideImageProvider(
                    ListHelper.getPlatformMediumModelList(photos)),
                initialPage: initialPage)));
  }

  void showPhotosPublic(BuildContext context, AppModel app,
      List<PublicMediumModel> media, int initialPage) {
    var photos = media
        .where(
            (memberMedium) => memberMedium.mediumType == PublicMediumType.Photo)
        .toList();
    Navigator.push(
        context,
        pageRouteBuilder(app,
            page: AlbumSlider(
                app: app,
                title: "Photos",
                slideImageProvider: PublicMediumSlideImageProvider(
                    ListHelper.getPublicMediumModelList(photos)),
                initialPage: initialPage)));
  }

  Future<void> showVideo(BuildContext context, AppModel app,
      MemberMediumModel memberMediumModel) async {
    Navigator.push(
        context,
        pageRouteBuilder(app,
            page: VideoView(
                sourceType: SourceType.Network,
                source: memberMediumModel.url!)));
  }

  Future<void> showVideoPlatform(BuildContext context, AppModel app,
      PlatformMediumModel platformMediumModel) async {
    Navigator.push(
        context,
        pageRouteBuilder(app,
            page: VideoView(
                sourceType: SourceType.Network,
                source: platformMediumModel.url!)));
  }

  /*
   * Allows the user to take a photo
   * When photo is selected feedbackFunction is triggered
   */
  void takeVideo(
      BuildContext context,
      AppModel app,
      String ownerId,
      AccessRightsProvider accessRightsProvider,
      MediumAvailable feedbackFunction,
      FeedbackProgress? feedbackProgress);

  void uploadPhoto(
      BuildContext context,
      AppModel app,
      String ownerId,
      AccessRightsProvider accessRightsProvider,
      MediumAvailable feedbackFunction,
      FeedbackProgress? feedbackProgress,
      {bool? allowCrop});

  /*
   * Allows the user to select a photo from library
   * When photo is selected feedbackFunction is triggered
   */
  void uploadVideo(
      BuildContext context,
      AppModel app,
      String ownerId,
      AccessRightsProvider accessRightsProvider,
      MediumAvailable feedbackFunction,
      FeedbackProgress? feedbackProgress);

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
      var mediumModel = await accessRightsProvider()
          .getMediumHelper(app, ownerId)
          .createThumbnailUploadPhotoData(
              memberMediumDocumentID, bytes, baseName, thumbnailBaseName,
              feedbackProgress: feedbackProgress);
      feedbackFunction(mediumModel);
    } catch (error) {
      print('Error trying to processPhoto: ' + error.toString());
      feedbackFunction(null);
    }
  }

  /* Allow to add an imnage / upload / ... */
  Widget getPublicPhotoWidget(
          {Key? key,
          required String title,
          required BuildContext context, required AppModel app,
          String?
              defaultImage, // asset location of default image which the user can choose
          required MediumAvailable feedbackFunction,
          required PublicMediumModel? initialImage}) =>
      PublicPhotoWidget(
        key: key,
        title: title,
        app: app,
        defaultImage: defaultImage,
        feedbackFunction: feedbackFunction,
        initialImage: initialImage,
      );
  Widget getPlatformPhotoWidget(
      {Key? key,
      required String title,
        required BuildContext context, required AppModel app,
      String?
          defaultImage, // asset location of default image which the user can choose
      required MediumAvailable feedbackFunction,
      required PlatformMediumModel? initialImage}) =>
      PlatformPhotoWidget(
        key: key,
        title: title,
        app: app,
        defaultImage: defaultImage,
        feedbackFunction: feedbackFunction,
        initialImage: initialImage,
      );
  /*
   * Currently default / only access is public. Should expand the api to allow to change
   */
  Widget getMemberPhotoWidget(
      {Key? key,
      required String title,
        required BuildContext context, required AppModel app,
      String?
          defaultImage, // asset location of default image which the user can choose
      required MediumAvailable feedbackFunction,
      required MemberMediumModel? initialImage}) =>
      MemberPhotoWidget(
        key: key,
        title: title,
        app: app,
        defaultImage: defaultImage,
        feedbackFunction: feedbackFunction,
        initialImage: initialImage,
      );
}
