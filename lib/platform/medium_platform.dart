import 'dart:typed_data';
import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/model/platform_medium_model.dart';
import 'package:eliud_core/model/public_medium_model.dart';
import 'package:eliud_core/package/medium_api.dart';
import 'package:eliud_core/style/frontend/has_button.dart';
import 'package:eliud_core/style/frontend/has_dialog.dart';
import 'package:eliud_core/tools/etc.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/tools/router_builders.dart';
import 'package:eliud_core/tools/screen_size.dart';
import 'package:eliud_core/tools/storage/basename_helper.dart';
import 'package:eliud_core/tools/storage/upload_info.dart';
import 'package:eliud_pkg_medium/tools/view/video_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../tools/slider/album_slider.dart';
import '../tools/slider/slide_image_provider.dart';
import '../wizards/widgets/member_photo_widget.dart';
import '../wizards/widgets/platform_photo_widget.dart';
import '../wizards/widgets/public_photo_widget.dart';
import 'image_crop.dart';

abstract class AbstractMediumPlatform extends MediumApi {
  void showPhotos(BuildContext context, AppModel app,
      List<MemberMediumModel> media, int initialPage) {
    var photos = media
        .where((memberMedium) => memberMedium.mediumType == MediumType.Photo)
        .toList();
    //title: "Photos",
    //
    openFlexibleDialog(app, context, app.documentID + '/_showphotosplatform',
        includeHeading: true,
        title: "Photos",
        buttons: [
          dialogButton(app, context,
              label: 'Close', onPressed: () => Navigator.of(context).pop()),
        ],
        widthFraction: .9,
        child: AlbumSlider(
            height: fullFullScreenHeight(context) * .7,
            app: app,
            slideImageProvider: MemberMediumSlideImageProvider(
                ListHelper.getMemberMediumModelList(photos)),
            initialPage: initialPage));
  }

  void showPhotosUrls(
      BuildContext context, AppModel app, List<String> urls, int initialPage) {
    openFlexibleDialog(app, context, app.documentID + '/_showphotosurls',
        includeHeading: true,
        title: "Photos",
        buttons: [
          dialogButton(app, context,
              label: 'Close', onPressed: () => Navigator.of(context).pop()),
        ],
        widthFraction: .9,
        child: AlbumSlider(
            height: fullFullScreenHeight(context) * .7,
            app: app,
            slideImageProvider: UrlSlideImageProvider(urls),
            initialPage: initialPage));
  }

  void showPhotosPlatform(BuildContext context, AppModel app,
      List<PlatformMediumModel> media, int initialPage) {
    var photos = media
        .where((memberMedium) =>
            memberMedium.mediumType == PlatformMediumType.Photo)
        .toList();
    openFlexibleDialog(app, context, app.documentID + '/_showphotosplatform',
        includeHeading: true,
        title: "Photos",
        buttons: [
          dialogButton(app, context,
              label: 'Close', onPressed: () => Navigator.of(context).pop()),
        ],
        widthFraction: .9,
        child: AlbumSlider(
            height: fullFullScreenHeight(context) * .7,
            app: app,
            slideImageProvider: PlatformMediumSlideImageProvider(
                ListHelper.getPlatformMediumModelList(photos)),
            initialPage: initialPage));
  }

  void showPhotosPublic(BuildContext context, AppModel app,
      List<PublicMediumModel> media, int initialPage) {
    var photos = media
        .where(
            (memberMedium) => memberMedium.mediumType == PublicMediumType.Photo)
        .toList();

    openFlexibleDialog(app, context, app.documentID + '/_showphotosplatform',
        includeHeading: true,
        title: "Photos",
        buttons: [
          dialogButton(app, context,
              label: 'Close', onPressed: () => Navigator.of(context).pop()),
        ],
        widthFraction: .9,
        child: AlbumSlider(
            height: fullFullScreenHeight(context) * .7,
            app: app,
            slideImageProvider: PublicMediumSlideImageProvider(
                ListHelper.getPublicMediumModelList(photos)),
            initialPage: initialPage));
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
      AccessRightsProvider accessRightsProvider,
      MediumAvailable feedbackFunction,
      FeedbackProgress? feedbackProgress);

  /*
   * Allows the user to select a photo from library
   * When photo is selected feedbackFunction is triggered
   */
  void uploadVideo(
      BuildContext context,
      AppModel app,
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
          required BuildContext context,
          required AppModel app,
          String?
              defaultImage, // asset location of default image which the user can choose
          required MediumAvailable feedbackFunction,
          required PublicMediumModel? initialImage,
          bool? allowCrop}) =>
      PublicPhotoWidget(
        key: key,
        app: app,
        defaultImage: defaultImage,
        feedbackFunction: feedbackFunction,
        initialImage: initialImage,
        allowCrop: allowCrop,
      );
  Widget getPlatformPhotoWidget(
          {Key? key,
          required BuildContext context,
          required AppModel app,
          String?
              defaultImage, // asset location of default image which the user can choose
          required MediumAvailable feedbackFunction,
          required PlatformMediumModel? initialImage,
          bool? allowCrop}) =>
      PlatformPhotoWidget(
        key: key,
        app: app,
        defaultImage: defaultImage,
        feedbackFunction: feedbackFunction,
        initialImage: initialImage,
        allowCrop: allowCrop,
      );
  /*
   * Currently default / only access is public. Should expand the api to allow to change
   */
  Widget getMemberPhotoWidget(
          {Key? key,
          required BuildContext context,
          required AppModel app,
          String?
              defaultImage, // asset location of default image which the user can choose
          required MediumAvailable feedbackFunction,
          required MemberMediumModel? initialImage,
          bool? allowCrop}) =>
      MemberPhotoWidget(
        key: key,
        app: app,
        defaultImage: defaultImage,
        feedbackFunction: feedbackFunction,
        initialImage: initialImage,
        allowCrop: allowCrop,
      );

  @override
  Future<void> takePhoto(
      BuildContext context,
      AppModel app,
      AccessRightsProvider accessRightsProvider,
      MediumAvailable feedbackFunction,
      FeedbackProgress? feedbackProgress,
      {bool? allowCrop}) async {
    return _pickImage(context, app, accessRightsProvider, feedbackFunction,
        feedbackProgress, ImageSource.camera,
        allowCrop: allowCrop);
  }

  Future<void> uploadPhoto(
      BuildContext context,
      AppModel app,
      AccessRightsProvider accessRightsProvider,
      MediumAvailable feedbackFunction,
      FeedbackProgress? feedbackProgress,
      {bool? allowCrop}) async {
    return _pickImage(context, app, accessRightsProvider, feedbackFunction,
        feedbackProgress, ImageSource.gallery,
        allowCrop: allowCrop);
  }

  @override
  Future<void> _pickImage(
      BuildContext context,
      AppModel app,
      AccessRightsProvider accessRightsProvider,
      MediumAvailable feedbackFunction,
      FeedbackProgress? feedbackProgress,
      ImageSource source,
      {bool? allowCrop}) async {
    var ownerId = AccessBloc.memberId(context);
    if (ownerId == null)
      throw Exception("Expecting to have a member logged in to take a photo");
    if (feedbackProgress != null) feedbackProgress(-1);
    var _picker = ImagePicker();
    var _image = await _picker.pickImage(
      source: source,
    );

    if (_image != null) {
      var memberMediumDocumentID = newRandomKey();
      var baseName =
      BaseNameHelper.baseName(memberMediumDocumentID, _image.path);
      var thumbnailBaseName =
      BaseNameHelper.thumbnailBaseName(memberMediumDocumentID, _image.path);
      var bytes = await _image.readAsBytes();
      if ((allowCrop != null) && (allowCrop)) {
        ImageCropWidget.open(context, app, (croppedImage) {
          if (croppedImage == null) {
            feedbackFunction(null);
          } else {
            processPhoto(
                memberMediumDocumentID,
                app,
                baseName,
                thumbnailBaseName,
                ownerId,
                croppedImage,
                accessRightsProvider,
                feedbackFunction,
                feedbackProgress);
          }
        }, bytes);
      } else {
        processPhoto(
            memberMediumDocumentID,
            app,
            baseName,
            thumbnailBaseName,
            ownerId,
            bytes,
            accessRightsProvider,
            feedbackFunction,
            feedbackProgress);
      }
    } else {
      feedbackFunction(null);
    }
  }

}
