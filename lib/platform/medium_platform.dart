import 'dart:typed_data';
import 'package:eliud_core_model/access/access_bloc.dart';
import 'package:eliud_core_model/apis/medium/medium_api.dart';
import 'package:eliud_core_model/model/app_model.dart';
import 'package:eliud_core_model/model/member_medium_model.dart';
import 'package:eliud_core_model/model/platform_medium_model.dart';
import 'package:eliud_core_model/model/public_medium_model.dart';
import 'package:eliud_core_model/style/frontend/has_button.dart';
import 'package:eliud_core_model/style/frontend/has_dialog.dart';
import 'package:eliud_core_model/style/frontend/has_text.dart';
import 'package:eliud_core_model/tools/etc/etc.dart';
import 'package:eliud_core_model/tools/etc/random.dart';
import 'package:eliud_core_model/tools/etc/screen_size.dart';
import 'package:eliud_core_model/tools/route_builders/route_builders.dart';
import 'package:eliud_core_model/tools/storage/basename_helper.dart';
import 'package:eliud_pkg_medium/tools/view/video_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../tools/slider/album_slider.dart';
import '../tools/slider/slide_image_provider.dart';
import '../tools/video_widget/embedded_video.dart';
import '../wizards/widgets/member_photo_widget.dart';
import '../wizards/widgets/platform_photo_widget.dart';
import '../wizards/widgets/public_photo_widget.dart';
import 'image_crop.dart';

abstract class AbstractMediumPlatform extends MediumApi {
  @override
  void showPhotos(BuildContext context, AppModel app,
      List<MemberMediumModel> media, int initialPage) {
    var photos = media
        .where((memberMedium) => memberMedium.mediumType == MediumType.photo)
        .toList();
    //title: "Photos",
    //
    openFlexibleDialog(app, context, '${app.documentID}/_showphotosplatform',
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

  @override
  void showPhotosUrls(
      BuildContext context, AppModel app, List<String> urls, int initialPage) {
    openFlexibleDialog(app, context, '${app.documentID}/_showphotosurls',
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

  @override
  void showPhotosPlatform(BuildContext context, AppModel app,
      List<PlatformMediumModel> media, int initialPage) {
    var photos = media
        .where((memberMedium) =>
            memberMedium.mediumType == PlatformMediumType.photo)
        .toList();
    openFlexibleDialog(app, context, '${app.documentID}/_showphotosplatform',
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

  @override
  void showPhotosPublic(BuildContext context, AppModel app,
      List<PublicMediumModel> media, int initialPage) {
    var photos = media
        .where(
            (memberMedium) => memberMedium.mediumType == PublicMediumType.photo)
        .toList();

    openFlexibleDialog(app, context, '${app.documentID}/_showphotosplatform',
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

  @override
  Future<void> showVideo(BuildContext context, AppModel app,
      MemberMediumModel memberMediumModel) async {
    Navigator.push(
        context,
        pageRouteBuilder(app,
            page: VideoView(
                sourceType: SourceType.network,
                source: memberMediumModel.url!)));
  }

  @override
  Widget embeddedVideo(
      BuildContext context, AppModel app, MemberMediumModel memberMediumModel) {
    if (memberMediumModel.url == null) {
      return text(app, context, "?");
    } else {
      return EmbeddedVideo(url: memberMediumModel.url!);
    }
  }

  @override
  Future<void> showVideoPlatform(BuildContext context, AppModel app,
      PlatformMediumModel platformMediumModel) async {
    Navigator.push(
        context,
        pageRouteBuilder(app,
            page: VideoView(
                sourceType: SourceType.network,
                source: platformMediumModel.url!)));
  }

  /*
   * Allows the user to take a photo
   * When photo is selected feedbackFunction is triggered
   */
  @override
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
  @override
  void uploadVideo(
      BuildContext context,
      AppModel app,
      AccessRightsProvider accessRightsProvider,
      MediumAvailable feedbackFunction,
      FeedbackProgress? feedbackProgress);

  /*
   * Some implementations, e.g. android, have access to the camera. Some other implementations, e.g. web, don't
   */
  @override
  bool hasCamera();

  /*
   * Some implementations, e.g. android, have access to the assets. Some other implementations, e.g. web, don't
   */
  @override
  bool hasAccessToAssets();

  /*
   * Some implementations, e.g. android, have access to the local file system, whilst others don't, e.g. Web
   */
  @override
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
      print('Error trying to processPhoto: $error');
      feedbackFunction(null);
    }
  }

  /* Allow to add an imnage / upload / ... */
  @override
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
  @override
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
  @override
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

  @override
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

  Future<void> _pickImage(
      BuildContext context,
      AppModel app,
      AccessRightsProvider accessRightsProvider,
      MediumAvailable feedbackFunction,
      FeedbackProgress? feedbackProgress,
      ImageSource source,
      {bool? allowCrop}) async {
    var ownerId = AccessBloc.memberId(context);
    if (ownerId == null) {
      throw Exception("Expecting to have a member logged in to take a photo");
    }
    if (feedbackProgress != null) feedbackProgress(-1);
    var picker = ImagePicker();
    var image = await picker.pickImage(
      source: source,
    );

    if (image != null) {
      var memberMediumDocumentID = newRandomKey();
      var baseName =
          BaseNameHelper.baseName(memberMediumDocumentID, image.path);
      var thumbnailBaseName =
          BaseNameHelper.thumbnailBaseName(memberMediumDocumentID, image.path);
      var bytes = await image.readAsBytes();
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
