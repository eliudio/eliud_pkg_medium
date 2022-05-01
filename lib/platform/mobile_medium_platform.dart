import 'dart:io';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/package/medium_api.dart';
import 'package:eliud_core/package/access_rights.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/tools/storage/basename_helper.dart';
import 'package:eliud_core/tools/storage/member_medium_helper.dart';
import 'package:eliud_core/tools/storage/upload_info.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'image_crop.dart';
import 'medium_platform.dart';
import 'mobile/eliud_camera.dart';

class MobileMediumPlatform extends AbstractMediumPlatform {
  @override
  Future<void> takePhoto(
      BuildContext context,
      AppModel app,
      String ownerId,
      AccessRightsProvider accessRightsProvider,
      MediumAvailable feedbackFunction,
      FeedbackProgress? feedbackProgress,
      {bool? allowCrop}) async {
    if (feedbackProgress != null) feedbackProgress(-1);
    var _image = await ImagePickerGC.pickImage(
      enableCloseButton: true,
      closeIcon: Icon(
        Icons.close,
        color: Colors.red,
        size: 12,
      ),
      context: context,
      source: ImgSource.Camera,
      barrierDismissible: true,
      cameraIcon: Icon(
        Icons.camera_alt,
        color: Colors.red,
      ),
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
        processPhoto(memberMediumDocumentID, app, baseName, thumbnailBaseName,
            ownerId, bytes, accessRightsProvider, feedbackFunction, feedbackProgress);
      }
    } else {
      feedbackFunction(null);
    }
  }

  @override
  void takeVideo(
      BuildContext context,
      AppModel app,
      String ownerId,
      AccessRightsProvider accessRightsProvider,
      MediumAvailable feedbackFunction,
      FeedbackProgress? feedbackProgress) {
    var memberMediumDocumentID = newRandomKey();
    EliudCamera.openVideoRecorder(context, app, (video) async {
      var memberMediumModel = await accessRightsProvider()
          .getMediumHelper(app, ownerId)
          .createThumbnailUploadVideoFile(memberMediumDocumentID, video.path,
              feedbackProgress: feedbackProgress);
      feedbackFunction(memberMediumModel);
    }, (message) {
      print('Error during takeVideo ' + message.toString());
      feedbackFunction(null);
    });
  }

  @override
  bool hasCamera() => true;

  @override
  Future<void> uploadPhoto(
      BuildContext context,
      AppModel app,
      String ownerId,
      AccessRightsProvider accessRightsProvider,
      MediumAvailable feedbackFunction,
      FeedbackProgress? feedbackProgress,
      {bool? allowCrop}) async {
    try {
      var memberMediumDocumentID = newRandomKey();
      if (feedbackProgress != null) feedbackProgress(-1);
      var _result = await FilePicker.platform
          .pickFiles(type: FileType.image, allowMultiple: false);
      if (_result == null) {
        if (feedbackProgress != null) feedbackFunction(null);
        return;
      }
      var path = _result.paths[0];
      if (path == null) {
        if (feedbackProgress != null) feedbackFunction(null);
        return;
      }

      var baseName = BaseNameHelper.baseName(memberMediumDocumentID, path);
      var thumbnailBaseName =
          BaseNameHelper.thumbnailBaseName(memberMediumDocumentID, path);
      var bytes = await File(path).readAsBytes();
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
        processPhoto(memberMediumDocumentID, app, baseName, thumbnailBaseName,
            ownerId, bytes, accessRightsProvider, feedbackFunction, feedbackProgress);
      }
    } catch (error) {
      print('Error trying to uploadPhoto: ' + error.toString());
      feedbackFunction(null);
    }
  }

  @override
  Future<void> uploadVideo(
      BuildContext context,
      AppModel app,
      String ownerId,
      AccessRightsProvider accessRightsProvider,
      MediumAvailable feedbackFunction,
      FeedbackProgress? feedbackProgress) async {
    try {
      var memberMediumDocumentID = newRandomKey();
      var result = await FilePicker.platform
          .pickFiles(type: FileType.video, allowMultiple: false);
      if (result == null) {
        feedbackFunction(null);
        return;
      }
      var aFile = result.files[0];
      var path = aFile.path;
      if (path == null) {
        feedbackFunction(null);
        return;
      }
      var memberMediumModel = await accessRightsProvider()
          .getMediumHelper(app, ownerId)
          .createThumbnailUploadVideoFile(memberMediumDocumentID, path,
              feedbackProgress: feedbackProgress);
      feedbackFunction(memberMediumModel);
    } catch (error) {
      print('Error trying to uploadVideo: ' + error.toString());
      feedbackFunction(null);
    }
  }

  @override
  bool hasAccessToAssets() => true;

  @override
  bool hasAccessToLocalFilesystem() => true;
}
