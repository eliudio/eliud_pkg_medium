import 'package:eliud_core/core/registry.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/package/access_rights.dart';
import 'package:eliud_core/package/medium_api.dart';
import 'package:eliud_core/style/frontend/has_button.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/tools/storage/upload_info.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

typedef Tuple2<MemberMediumAccessibleByGroup,
    List<String>?> MemberMediumAccessibleProviderFunction();

typedef PrivilegeLevelRequiredSimple PlatformMediumAccessibleProviderFunction();

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
      if (Registry.registry()!.getMediumApi().hasCamera()) {
        items.add(
          popupMenuItem<int>(app, context, label: 'Take photo', value: 0),
        );
      }
      items.add(
          popupMenuItem<int>(app, context, label: 'Upload photo', value: 1));
    }
    if (videoFeedbackFunction != null) {
      if (Registry.registry()!.getMediumApi().hasCamera()) {
        items.add(
          popupMenuItem<int>(app, context, label: 'Take video', value: 2),
        );
      }
      items.add(new PopupMenuItem<int>(
          child: text(app, context, 'Upload video'), value: 3));
    }
    return popupMenuButton(app, context,
        tooltip: tooltip,
        child: icon,
        itemBuilder: (_) => items,
        onSelected: (choice) {
          if (photoFeedbackFunction != null) {
            if (choice == 0) {
              Registry.registry()!.getMediumApi().takePhoto(
                  context,
                  app,
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
                  () => MemberMediumAccessRights(accessibleByFunction().item1,
                      accessibleByMembers: accessibleByFunction().item2),
                  videoFeedbackFunction,
                  videoFeedbackProgress);
            }
            if (choice == 3) {
              Registry.registry()!.getMediumApi().uploadVideo(
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
      if (Registry.registry()!.getMediumApi().hasCamera()) {
        items.add(
          popupMenuItem<int>(app, context, label: 'Take photo', value: 0),
        );
      }
      items.add(
          popupMenuItem<int>(app, context, label: 'Upload photo', value: 1));
    }
    if (videoFeedbackFunction != null) {
      if (Registry.registry()!.getMediumApi().hasCamera()) {
        items.add(
          popupMenuItem<int>(app, context, label: 'Take video', value: 2),
        );
      }
      items.add(new PopupMenuItem<int>(
          child: text(app, context, 'Upload video'), value: 3));
    }
    return popupMenuButton(app, context,
        tooltip: tooltip,
        child: icon,
        itemBuilder: (_) => items,
        onSelected: (choice) {
          if (photoFeedbackFunction != null) {
            if (choice == 0) {
              Registry.registry()!.getMediumApi().takePhoto(
                  context,
                  app,
                      () => PlatformMediumAccessRights(accessibleByFunction()),
                  photoFeedbackFunction,
                  photoFeedbackProgress,
                  allowCrop: allowCrop);
            }
            if (choice == 1) {
              Registry.registry()!.getMediumApi().uploadPhoto(
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
              Registry.registry()!.getMediumApi().takeVideo(
                  context,
                  app,
                      () => PlatformMediumAccessRights(accessibleByFunction()),
                  videoFeedbackFunction,
                  videoFeedbackProgress);
            }
            if (choice == 3) {
              Registry.registry()!.getMediumApi().uploadVideo(
                  context,
                  app,
                      () => PlatformMediumAccessRights(accessibleByFunction()),
                  videoFeedbackFunction,
                  videoFeedbackProgress);
            }
          }
        });
  }}
