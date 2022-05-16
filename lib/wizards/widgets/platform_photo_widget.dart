import 'package:eliud_core/core/registry.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/platform_medium_model.dart';
import 'package:eliud_core/model/public_medium_model.dart';
import 'package:eliud_core/model/storage_conditions_model.dart';
import 'package:eliud_core/package/access_rights.dart';
import 'package:eliud_core/package/medium_api.dart';
import 'package:eliud_core/style/frontend/has_button.dart';
import 'package:eliud_core/style/frontend/has_container.dart';
import 'package:eliud_core/style/frontend/has_list_tile.dart';
import 'package:eliud_core/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_medium/platform/medium_platform.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlatformPhotoWidget extends StatefulWidget {
  final AppModel app;
  final MediumAvailable feedbackFunction;
  final String? defaultImage;
  final PlatformMediumModel? initialImage;
  final bool? allowCrop;

  const PlatformPhotoWidget(
      {Key? key,
        required this.app,
        this.defaultImage,
        required this.feedbackFunction,
        required this.initialImage,
        this.allowCrop})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PlatformPhotoWidgetState();
}

class _PlatformPhotoWidgetState extends State<PlatformPhotoWidget> {
  double? _progress;

  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, physics: ScrollPhysics(), children: [
          getListTile(context, widget.app,
              trailing: popupMenuButton<int>(
                  widget.app, context,
                  child: Icon(Icons.more_vert),
                  itemBuilder: (context) => [
                    if (Registry.registry()!.getMediumApi().hasCamera())
                      popupMenuItem(
                        widget.app, context,
                        value: 0,
                        label: 'Take photo',
                      ),
                    popupMenuItem(
                      widget.app, context,
                      value: 1,
                      label: 'Upload photo',
                    ),
                    if (widget.defaultImage != null)
                      popupMenuItem(
                        widget.app, context,
                        value: 2,
                        label: 'Default photo',
                      ),
                    popupMenuItem(
                      widget.app, context,
                      value: 3,
                      label: 'Clear photo',
                    ),
                  ],
                  onSelected: (value) async {
                    if (value == 0) {
                      Registry.registry()!.getMediumApi().takePhoto(
                          context,
                          widget.app,
                          widget.app.ownerID!,
                              () => PlatformMediumAccessRights(PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
                              (photo) => _photoFeedbackFunction(widget.app, photo),
                          _photoUploading,
                          allowCrop: widget.allowCrop);
                    } else if (value == 1) {
                      Registry.registry()!.getMediumApi().uploadPhoto(
                          context,
                          widget.app,
                          widget.app.ownerID!,
                              () => PlatformMediumAccessRights(PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
                              (photo) => _photoFeedbackFunction(widget.app, photo),
                          _photoUploading,
                          allowCrop: widget.allowCrop);
                    } else if (value == 2) {
                      var photo = await PlatformMediumAccessRights(PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple)
                          .getMediumHelper(
                        widget.app,
                        widget.app.ownerID!,
                      )
                          .createThumbnailUploadPhotoAsset(newRandomKey(), widget.defaultImage!,
                          feedbackProgress: _photoUploading);
                      _photoFeedbackFunction(widget.app, photo);
                    } else if (value == 3) {
                      _photoFeedbackFunction(widget.app, null);
                    }
                  }),
              title: _progress != null
                  ? progressIndicatorWithValue(widget.app, context,
                  value: _progress!)
                  : widget.initialImage == null || widget.initialImage!.url == null
                  ? Center(child: text(widget.app, context, 'No image set'))
                  : Image.network(
                widget.initialImage!.url!,
                height: 100,
              ))
        ]);
  }

  void _photoFeedbackFunction(
      AppModel appModel, PlatformMediumModel? platformMediumModel) {
    setState(() {
      _progress = null;
      widget.feedbackFunction(platformMediumModel);
    });
  }

  void _photoUploading(dynamic progress) {
    if (progress != null) {}
    setState(() {
      _progress = progress;
    });
  }
}

