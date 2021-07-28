import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/storage/upload_info.dart';
import 'package:eliud_pkg_medium/platform/medium_platform.dart';
import 'package:flutter/material.dart';

class MediaButtons {
  static PopupMenuButton mediaButtons(
    BuildContext context,
    String appId,
    String ownerId,
    List<String>? readAccess, {
    MemberMediumAvailable? photoFeedbackFunction,
    FeedbackProgress? photoFeedbackProgress,
    MemberMediumAvailable? videoFeedbackFunction,
    FeedbackProgress? videoFeedbackProgress,
    Widget? icon,
    bool? allowCrop,
    String? tooltip,
  }) {
    if (readAccess == null) throw Exception('readAccess is null');
    var items = <PopupMenuItem<int>>[];
    if (photoFeedbackFunction != null) {
      if (AbstractMediumPlatform.platform!.hasCamera()) {
        items.add(
          PopupMenuItem<int>(
              child: StyleRegistry.registry()
                  .styleWithContext(context)
                  .frontEndStyle()
                  .textStyle()
                  .text(context, 'Take photo'),
              value: 0),
        );
      }
      items.add(new PopupMenuItem<int>(
          child: StyleRegistry.registry()
              .styleWithContext(context)
              .frontEndStyle()
              .textStyle()
              .text(context, 'Upload photo'),
          value: 1));
    }
    if (videoFeedbackFunction != null) {
      if (AbstractMediumPlatform.platform!.hasCamera()) {
        items.add(
          PopupMenuItem<int>(
              child: StyleRegistry.registry()
                  .styleWithContext(context)
                  .frontEndStyle()
                  .textStyle()
                  .text(context, 'Take video'),
              value: 2),
        );
      }
      items.add(new PopupMenuItem<int>(
          child: StyleRegistry.registry()
              .styleWithContext(context)
              .frontEndStyle()
              .textStyle()
              .text(context, 'Upload video'),
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
                  appId,
                  ownerId,
                  readAccess,
                  photoFeedbackFunction,
                  photoFeedbackProgress,
                  allowCrop: allowCrop);
            }
            if (choice == 1) {
              AbstractMediumPlatform.platform!.uploadPhoto(
                  context,
                  appId,
                  ownerId,
                  readAccess,
                  photoFeedbackFunction,
                  photoFeedbackProgress,
                  allowCrop: allowCrop);
            }
          }
          if (videoFeedbackFunction != null) {
            if (choice == 2) {
              AbstractMediumPlatform.platform!.takeVideo(
                  context,
                  appId,
                  ownerId,
                  readAccess,
                  videoFeedbackFunction,
                  videoFeedbackProgress);
            }
            if (choice == 3) {
              AbstractMediumPlatform.platform!.uploadVideo(
                  context,
                  appId,
                  ownerId,
                  readAccess,
                  videoFeedbackFunction,
                  videoFeedbackProgress);
            }
          }
        });
  }
}
