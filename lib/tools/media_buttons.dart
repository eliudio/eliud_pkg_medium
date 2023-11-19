import 'package:eliud_core_model/apis/apis.dart';
import 'package:eliud_core_model/apis/medium/access_rights.dart';
import 'package:eliud_core_model/apis/medium/medium_api.dart';
import 'package:eliud_core_model/model/app_model.dart';
import 'package:eliud_core_model/model/member_medium_model.dart';
import 'package:eliud_core_model/model/storage_conditions_model.dart';
import 'package:eliud_core_model/style/frontend/has_button.dart';
import 'package:eliud_core_model/style/frontend/has_text.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

typedef MemberMediumAccessibleProviderFunction
    = Tuple2<MemberMediumAccessibleByGroup, List<String>?> Function();

typedef PlatformMediumAccessibleProviderFunction = PrivilegeLevelRequiredSimple
    Function();

class MediaButtons {
  // memberMediaButtons
  static PopupMenuButton mediaButtons(
    BuildContext context,
    AppModel app,
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
      if (Apis.apis().getMediumApi().hasCamera()) {
        items.add(
          popupMenuItem<int>(app, context, label: 'Take photo', value: 0),
        );
      }
      items.add(
          popupMenuItem<int>(app, context, label: 'Upload photo', value: 1));
    }
    if (videoFeedbackFunction != null) {
      if (Apis.apis().getMediumApi().hasCamera()) {
        items.add(
          popupMenuItem<int>(app, context, label: 'Take video', value: 2),
        );
      }
      items.add(PopupMenuItem<int>(
          child: text(app, context, 'Upload video'), value: 3));
    }

    return popupMenuButton(app, context,
        tooltip: tooltip,
        child: icon,
        itemBuilder: (_) => items,
        onSelected: (choice) {
          if (photoFeedbackFunction != null) {
            if (choice == 0) {
              Apis.apis().getMediumApi().takePhoto(
                  context,
                  app,
                  () => MemberMediumAccessRights(accessibleByFunction().item1,
                      accessibleByMembers: accessibleByFunction().item2),
                  photoFeedbackFunction,
                  photoFeedbackProgress,
                  allowCrop: allowCrop);
            }
            if (choice == 1) {
              Apis.apis().getMediumApi().uploadPhoto(
                  context,
                  app,
                  () => MemberMediumAccessRights(accessibleByFunction().item1,
                      accessibleByMembers: accessibleByFunction().item2),
                  photoFeedbackFunction,
                  photoFeedbackProgress,
                  allowCrop: allowCrop);
            }
          }
          if (videoFeedbackFunction != null) {
            if (choice == 2) {
              Apis.apis().getMediumApi().takeVideo(
                  context,
                  app,
                  () => MemberMediumAccessRights(accessibleByFunction().item1,
                      accessibleByMembers: accessibleByFunction().item2),
                  videoFeedbackFunction,
                  videoFeedbackProgress);
            }
            if (choice == 3) {
              Apis.apis().getMediumApi().uploadVideo(
                  context,
                  app,
                  () => MemberMediumAccessRights(accessibleByFunction().item1,
                      accessibleByMembers: accessibleByFunction().item2),
                  videoFeedbackFunction,
                  videoFeedbackProgress);
            }
          }
        });
  }

  // platformMediaButtons
  static PopupMenuButton platformMediaButtons(
    BuildContext context,
    AppModel app,
    PlatformMediumAccessibleProviderFunction accessibleByFunction, {
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
      if (Apis.apis().getMediumApi().hasCamera()) {
        items.add(
          popupMenuItem<int>(app, context, label: 'Take photo', value: 0),
        );
      }
      items.add(
          popupMenuItem<int>(app, context, label: 'Upload photo', value: 1));
    }
    if (videoFeedbackFunction != null) {
      if (Apis.apis().getMediumApi().hasCamera()) {
        items.add(
          popupMenuItem<int>(app, context, label: 'Take video', value: 2),
        );
      }
      items.add(PopupMenuItem<int>(
          child: text(app, context, 'Upload video'), value: 3));
    }
    return popupMenuButton(app, context,
        tooltip: tooltip,
        child: icon,
        itemBuilder: (_) => items,
        onSelected: (choice) {
          if (photoFeedbackFunction != null) {
            if (choice == 0) {
              Apis.apis().getMediumApi().takePhoto(
                  context,
                  app,
                  () => PlatformMediumAccessRights(accessibleByFunction()),
                  photoFeedbackFunction,
                  photoFeedbackProgress,
                  allowCrop: allowCrop);
            }
            if (choice == 1) {
              Apis.apis().getMediumApi().uploadPhoto(
                  context,
                  app,
                  () => PlatformMediumAccessRights(accessibleByFunction()),
                  photoFeedbackFunction,
                  photoFeedbackProgress,
                  allowCrop: allowCrop);
            }
          }
          if (videoFeedbackFunction != null) {
            if (choice == 2) {
              Apis.apis().getMediumApi().takeVideo(
                  context,
                  app,
                  () => PlatformMediumAccessRights(accessibleByFunction()),
                  videoFeedbackFunction,
                  videoFeedbackProgress);
            }
            if (choice == 3) {
              Apis.apis().getMediumApi().uploadVideo(
                  context,
                  app,
                  () => PlatformMediumAccessRights(accessibleByFunction()),
                  videoFeedbackFunction,
                  videoFeedbackProgress);
            }
          }
        });
  }
}
