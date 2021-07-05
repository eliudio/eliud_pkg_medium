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
    if (feedbackProgress != null) feedbackProgress(-1);
    var _result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
    if (_result == null) {
      feedbackFunction(null);
      return;
    }
    var aFile = _result.files[0];
    var baseName = aFile.name;
    var thumbnailBaseName = aFile.extension!;
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
          processPhoto(
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
      processPhoto(appId, baseName, thumbnailBaseName, ownerId, bytes,
          readAccess, feedbackFunction, feedbackProgress);
    }
  }

  Future<void> uploadVideo(BuildContext context, String appId, String ownerId, List<String> readAccess, MemberMediumAvailable feedbackFunction, FeedbackProgress? feedbackProgress) async {
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

    var baseName = name;
    var thumbnailBaseName = BaseNameHelper.thumbnailBaseName(name);

    var memberMediumModel = await MemberMediumHelper.createThumbnailUploadVideoData(appId, bytes, baseName, thumbnailBaseName, ownerId, readAccess, feedbackProgress: feedbackProgress);
    feedbackFunction(memberMediumModel);
  }
}
