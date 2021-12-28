import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/tools/storage/basename_helper.dart';
import 'package:eliud_core/tools/storage/member_medium_helper.dart';
import 'package:eliud_core/tools/storage/upload_info.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'access_rights.dart';
import 'image_crop.dart';
import 'medium_platform.dart';

class WebMediumPlatform extends AbstractMediumPlatform {
  @override
  void takePhoto(BuildContext context, AppModel app, String ownerId, AccessRights accessRights, MediumAvailable feedbackFunction, FeedbackProgress? feedbackProgress, {bool? allowCrop}) {}

  @override
  void takeVideo(BuildContext context, AppModel app, String ownerId, AccessRights accessRights, MediumAvailable feedbackFunction, FeedbackProgress? feedbackProgress) {}

  @override
  bool hasCamera() => false;

  Future<void> uploadPhoto(BuildContext context, AppModel app, String ownerId,AccessRights accessRights, MediumAvailable feedbackFunction, FeedbackProgress? feedbackProgress, {bool? allowCrop}) async {
    try {
      var memberMediumDocumentID = newRandomKey();
      if (feedbackProgress != null) feedbackProgress(-1);
      var _result = await FilePicker.platform
          .pickFiles(type: FileType.image, allowMultiple: false);
      if (_result == null) {
        feedbackFunction(null);
        return;
      }
      var aFile = _result.files[0];
      var baseName = memberMediumDocumentID + '-' + aFile.name;
  //    var thumbnailBaseName = aFile.extension!;
      if (baseName == null) {
        print("basename is null");
      } else {
        print("basename is " + baseName);
      }
      var thumbnailBaseName = baseName + '.thumbnail.png';
      var bytes = aFile.bytes;
      if (bytes == null) {
        feedbackFunction(null);
        return;
      }

      if ((allowCrop != null) && (allowCrop)) {
        ImageCropWidget.open(context, app, (croppedImage) {
          if (croppedImage == null) {
            feedbackFunction(null);
          } else {
            processPhoto(memberMediumDocumentID,
                app,
                baseName,
                thumbnailBaseName,
                ownerId,
                croppedImage,
                accessRights,
                feedbackFunction,
                feedbackProgress);
          }
        }, bytes);
      } else {
        processPhoto(memberMediumDocumentID, app, baseName, thumbnailBaseName, ownerId, bytes,
            accessRights, feedbackFunction, feedbackProgress);
      }
    } catch (error) {
      print('Error trying to uploadPhoto: ' + error.toString());
      feedbackFunction(null);
    }
  }

  Future<void> uploadVideo(BuildContext context, AppModel app, String ownerId, AccessRights accessRights, MediumAvailable feedbackFunction, FeedbackProgress? feedbackProgress) async {
    try {
      var memberMediumDocumentID = newRandomKey();
      var result = await FilePicker.platform.pickFiles(type: FileType.video, allowMultiple: false);
      if (result == null) {
        feedbackFunction(null);
        return;
      }
      var aFile = result.files[0];
      var bytes = aFile.bytes;
      if (bytes == null) {
        feedbackFunction(null);
        return;
      }
      var name = aFile.name;
      if (name == null) {
        feedbackFunction(null);
        return;
      }

      var baseName = memberMediumDocumentID + '.' + name;
      print('uploadVideo.baseName: ' + baseName);
      var thumbnailBaseName = BaseNameHelper.thumbnailBaseName(memberMediumDocumentID, name);

      var memberMediumModel = await accessRights.getMediumHelper(app, ownerId).createThumbnailUploadVideoData(memberMediumDocumentID, bytes, baseName, thumbnailBaseName, feedbackProgress: feedbackProgress);
      feedbackFunction(memberMediumModel);
    } catch (error) {
      print('Error trying to uploadVideo: ' + error.toString());
      feedbackFunction(null);
    }
  }


  // Assets need to be store in the directory assets in the web directory of your flutterweb app.
  // For example, if you have images about.png loaded by specifying path 'packages/eliud_pkg_create/assets/annoyed.png',
  // then make sure this file annoyed.png is available from you web directory like this:
  // C:\src\eliud\minkey\web\assets\packages\eliud_pkg_create\assets\annoyed.png
  // where index.html is available from C:\src\eliud\minkey\web
  @override
  bool hasAccessToAssets() => true;

  @override
  bool hasAccessToLocalFilesystem() => false;
}
