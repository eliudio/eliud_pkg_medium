import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/storage/upload_info.dart';
import 'package:eliud_pkg_medium/platform/access_rights.dart';
import 'package:eliud_pkg_medium/platform/medium_platform.dart';
import 'package:flutter/material.dart';

class MediaButtons {
  static PopupMenuButton mediaButtons(
    BuildContext context,
    AppModel app,
    String ownerId,
    MemberMediumAccessibleByGroup accessibleByGroup,
    /*List<String>? readAccess, */{
    List<String>? accessibleByMembers,
    MediumAvailable? photoFeedbackFunction,
    FeedbackProgress? photoFeedbackProgress,
    MediumAvailable? videoFeedbackFunction,
    FeedbackProgress? videoFeedbackProgress,
    Widget? icon,
    bool? allowCrop,
    String? tooltip,
  }) {
    var items = <PopupMenuItem<int>>[];
    if (photoFeedbackFunction != null) {
      if (AbstractMediumPlatform.platform!.hasCamera()) {
        items.add(
          PopupMenuItem<int>(
              child: text(app, context, 'Take photo'),
              value: 0),
        );
      }
      items.add(new PopupMenuItem<int>(
          child: text(app, context, 'Upload photo'),
          value: 1));
    }
    if (videoFeedbackFunction != null) {
      if (AbstractMediumPlatform.platform!.hasCamera()) {
        items.add(
          PopupMenuItem<int>(
              child: text(app, context, 'Take video'),
              value: 2),
        );
      }
      items.add(new PopupMenuItem<int>(
          child: text(app, context, 'Upload video'),
          value: 3));
    }
    return PopupMenuButton(
        tooltip: tooltip,
        padding: EdgeInsets.all(0.0),
        child: icon,
        itemBuilder: (_) => items,
        onSelected: (choice) {
          if (photoFeedbackFunction != null) {
            if (choice == 0) {
              AbstractMediumPlatform.platform!.takePhoto(
                  context,
                  app,
                  ownerId,
                  MemberMediumAccessRights(accessibleByGroup, accessibleByMembers: accessibleByMembers),
                  photoFeedbackFunction,
                  photoFeedbackProgress,
                  allowCrop: allowCrop);
            }
            if (choice == 1) {
              AbstractMediumPlatform.platform!.uploadPhoto(
                  context,
                  app,
                  ownerId,
                  MemberMediumAccessRights(accessibleByGroup, accessibleByMembers: accessibleByMembers),
                  photoFeedbackFunction,
                  photoFeedbackProgress,
                  allowCrop: allowCrop);
            }
          }
          if (videoFeedbackFunction != null) {
            if (choice == 2) {
              AbstractMediumPlatform.platform!.takeVideo(
                  context,
                  app,
                  ownerId,
                  MemberMediumAccessRights(accessibleByGroup, accessibleByMembers: accessibleByMembers),
                  videoFeedbackFunction,
                  videoFeedbackProgress);
            }
            if (choice == 3) {
              AbstractMediumPlatform.platform!.uploadVideo(
                  context,
                  app,
                  ownerId,
                  MemberMediumAccessRights(accessibleByGroup, accessibleByMembers: accessibleByMembers),
                  videoFeedbackFunction,
                  videoFeedbackProgress);
            }
          }
        });
  }
}
