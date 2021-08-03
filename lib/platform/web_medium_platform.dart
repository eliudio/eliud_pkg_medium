import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/tools/storage/basename_helper.dart';
import 'package:eliud_core/tools/storage/medium_data.dart';
import 'package:eliud_core/tools/storage/member_medium_helper.dart';
import 'package:eliud_core/tools/storage/upload_info.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'image_crop.dart';
import 'medium_platform.dart';

class WebMediumPlatform extends AbstractMediumPlatform {
  @override
  void takePhoto(BuildContext context, String appId, String ownerId, List<String> readAccess, MemberMediumAvailable feedbackFunction, FeedbackProgress? feedbackProgress, {bool? allowCrop}) {}

  @override
  void takeVideo(BuildContext context, String appId, String ownerId, List<String> readAccess, MemberMediumAvailable feedbackFunction, FeedbackProgress? feedbackProgress) {}

  @override
  bool hasCamera() => false;

  Future<void> uploadPhoto(BuildContext context, String appId, String ownerId, List<String> readAccess, MemberMediumAvailable feedbackFunction, FeedbackProgress? feedbackProgress, {bool? allowCrop}) async {
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
        ImageCropWidget.open(context, (croppedImage) {
          if (croppedImage == null) {
            feedbackFunction(null);
          } else {
            processPhoto(memberMediumDocumentID,
                appId,
                baseName,
                thumbnailBaseName,
                ownerId,
                croppedImage,
                readAccess,
                feedbackFunction,
                feedbackProgress);
          }
        }, bytes);
      } else {
        processPhoto(memberMediumDocumentID, appId, baseName, thumbnailBaseName, ownerId, bytes,
            readAccess, feedbackFunction, feedbackProgress);
      }
    } catch (error) {
      print('Error trying to uploadPhoto: ' + error.toString());
      feedbackFunction(null);
    }
  }

  Future<void> uploadVideo(BuildContext context, String appId, String ownerId, List<String> readAccess, MemberMediumAvailable feedbackFunction, FeedbackProgress? feedbackProgress) async {
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

      var memberMediumModel = await MemberMediumHelper.createThumbnailUploadVideoData(memberMediumDocumentID, appId, bytes, baseName, thumbnailBaseName, ownerId, readAccess, feedbackProgress: feedbackProgress);
      feedbackFunction(memberMediumModel);
    } catch (error) {
      print('Error trying to uploadVideo: ' + error.toString());
      feedbackFunction(null);
    }
  }
}
