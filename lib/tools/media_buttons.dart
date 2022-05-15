import 'package:eliud_core/core/registry.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/package/access_rights.dart';
import 'package:eliud_core/package/medium_api.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/storage/upload_info.dart';
import 'package:eliud_pkg_medium/platform/medium_platform.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

typedef Tuple2<MemberMediumAccessibleByGroup,
    List<String>?> MemberMediumAccessibleProviderFunction();

class MediaButtons {
  static PopupMenuButton mediaButtons(
    BuildContext context,
    AppModel app,
    String ownerId,
    MemberMediumAccessibleProviderFunction accessibleByFunction, {
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
      if (Registry.registry()!.getMediumApi().hasCamera()) {
        items.add(
          PopupMenuItem<int>(child: text(app, context, 'Take photo'), value: 0),
        );
      }
      items.add(new PopupMenuItem<int>(
          child: text(app, context, 'Upload photo'), value: 1));
    }
    if (videoFeedbackFunction != null) {
      if (Registry.registry()!.getMediumApi().hasCamera()) {
        items.add(
          PopupMenuItem<int>(child: text(app, context, 'Take video'), value: 2),
        );
      }
      items.add(new PopupMenuItem<int>(
          child: text(app, context, 'Upload video'), value: 3));
    }
    return PopupMenuButton(
        tooltip: tooltip,
        padding: EdgeInsets.all(8.0),
        child: icon,
        itemBuilder: (_) => items,
        onSelected: (choice) {
          if (photoFeedbackFunction != null) {
            if (choice == 0) {
              Registry.registry()!.getMediumApi().takePhoto(
                  context,
                  app,
                  ownerId,
                  () => MemberMediumAccessRights(accessibleByFunction().item1,
                      accessibleByMembers: accessibleByFunction().item2),
                  photoFeedbackFunction,
                  photoFeedbackProgress,
                  allowCrop: allowCrop);
            }
            if (choice == 1) {
              Registry.registry()!.getMediumApi().uploadPhoto(
                  context,
                  app,
                  ownerId,
                  () => MemberMediumAccessRights(accessibleByFunction().item1,
                      accessibleByMembers: accessibleByFunction().item2),
                  photoFeedbackFunction,
                  photoFeedbackProgress,
                  allowCrop: allowCrop);
            }
          }
          if (videoFeedbackFunction != null) {
            if (choice == 2) {
              Registry.registry()!.getMediumApi().takeVideo(
                  context,
                  app,
                  ownerId,
                  () => MemberMediumAccessRights(accessibleByFunction().item1,
                      accessibleByMembers: accessibleByFunction().item2),
                  videoFeedbackFunction,
                  videoFeedbackProgress);
            }
            if (choice == 3) {
              Registry.registry()!.getMediumApi().uploadVideo(
                  context,
                  app,
                  ownerId,
                  () => MemberMediumAccessRights(accessibleByFunction().item1,
                      accessibleByMembers: accessibleByFunction().item2),
                  videoFeedbackFunction,
                  videoFeedbackProgress);
            }
          }
        });
  }
}
