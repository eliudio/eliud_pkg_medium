import 'package:eliud_core/access/access_bloc.dart';
import 'package:eliud_core_main/apis/medium/medium_api.dart';
import 'package:eliud_core_main/model/app_model.dart';
import 'package:eliud_core_helpers/etc/random.dart';
import 'package:eliud_core_main/storage/basename_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'medium_platform.dart';

class WebMediumPlatform extends AbstractMediumPlatform {
  @override
  void takeVideo(
      BuildContext context,
      AppModel app,
      AccessRightsProvider accessRightsProvider,
      MediumAvailable feedbackFunction,
      FeedbackProgress? feedbackProgress) {}

  @override
  bool hasCamera() => false;

  @override
  Future<void> uploadVideo(
      BuildContext context,
      AppModel app,
      AccessRightsProvider accessRightsProvider,
      MediumAvailable feedbackFunction,
      FeedbackProgress? feedbackProgress) async {
    try {
      var ownerId = AccessBloc.memberId(context);
      if (ownerId == null) {
        throw Exception("Expecting to have a member logged in to take a photo");
      }

      var memberMediumDocumentID = newRandomKey();
      var result = await FilePicker.platform
          .pickFiles(type: FileType.video, allowMultiple: false);
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
      var baseName = '$memberMediumDocumentID.$name';
      print('uploadVideo.baseName: $baseName');
      var thumbnailBaseName =
          BaseNameHelper.thumbnailBaseName(memberMediumDocumentID, name);

      var memberMediumModel = await accessRightsProvider()
          .getMediumHelper(app, ownerId)
          .createThumbnailUploadVideoData(
              memberMediumDocumentID, bytes, baseName, thumbnailBaseName,
              feedbackProgress: feedbackProgress);
      feedbackFunction(memberMediumModel);
    } catch (error) {
      print('Error trying to uploadVideo: $error');
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
