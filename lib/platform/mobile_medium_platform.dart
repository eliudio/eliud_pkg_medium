import 'package:eliud_core_model/access/access_bloc.dart';
import 'package:eliud_core_model/apis/medium/medium_api.dart';
import 'package:eliud_core_model/model/app_model.dart';
import 'package:eliud_core_model/tools/etc/random.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'medium_platform.dart';
import 'mobile/eliud_camera.dart';

class MobileMediumPlatform extends AbstractMediumPlatform {
  @override
  void takeVideo(
      BuildContext context,
      AppModel app,
      AccessRightsProvider accessRightsProvider,
      MediumAvailable feedbackFunction,
      FeedbackProgress? feedbackProgress) {
    var ownerId = AccessBloc.memberId(context);
    if (ownerId == null) {
      throw Exception("Expecting to have a member logged in to take a photo");
    }
    var memberMediumDocumentID = newRandomKey();
    EliudCamera.openVideoRecorder(context, app, (video) async {
      var memberMediumModel = await accessRightsProvider()
          .getMediumHelper(app, ownerId)
          .createThumbnailUploadVideoFile(memberMediumDocumentID, video.path,
              feedbackProgress: feedbackProgress);
      feedbackFunction(memberMediumModel);
    }, (message) {
      print('Error during takeVideo $message');
      feedbackFunction(null);
    });
  }

  @override
  bool hasCamera() => true;

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
      print('Error trying to uploadVideo: $error');
      feedbackFunction(null);
    }
  }

  @override
  bool hasAccessToAssets() => true;

  @override
  bool hasAccessToLocalFilesystem() => true;
}
