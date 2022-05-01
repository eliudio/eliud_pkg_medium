import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/platform_medium_model.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/model/storage_conditions_model.dart';
import 'package:eliud_core/package/access_rights.dart';
import 'package:eliud_core/package/medium_api.dart';
import 'package:eliud_core/style/frontend/has_container.dart';
import 'package:eliud_core/style/frontend/has_list_tile.dart';
import 'package:eliud_core/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_medium/platform/medium_platform.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MemberPhotoWidget extends StatefulWidget {
  final String title;
  final AppModel app;
  final MediumAvailable feedbackFunction;
  final String? defaultImage;
  final MemberMediumModel? initialImage;

  const MemberPhotoWidget(
      {Key? key,
        required this.title,
        required this.app,
        required this.defaultImage,
        required this.feedbackFunction,
        required this.initialImage})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MemberPhotoWidgetState();
}

class _MemberPhotoWidgetState extends State<MemberPhotoWidget> {
  double? _progress;

  @override
  Widget build(BuildContext context) {
    return topicContainer(widget.app, context,
        title: widget.title,
        collapsible: true,
        collapsed: true,
        children: [
          getListTile(context, widget.app,
              trailing: PopupMenuButton<int>(
                  child: Icon(Icons.more_vert),
                  elevation: 10,
                  itemBuilder: (context) => [
                    if (AbstractMediumPlatform.platform!.hasCamera())
                      PopupMenuItem(
                        value: 0,
                        child: text(widget.app, context, 'Take photo'),
                      ),
                    PopupMenuItem(
                      value: 1,
                      child: text(widget.app, context, 'Upload photo'),
                    ),
                    if (widget.defaultImage != null)
                      PopupMenuItem(
                        value: 2,
                        child: text(widget.app, context, 'Default photo'),
                      ),
                    PopupMenuItem(
                      value: 3,
                      child: text(widget.app, context, 'Clear photo'),
                    ),
                  ],
                  onSelected: (value) async {
                    if (value == 0) {
                      AbstractMediumPlatform.platform!.takePhoto(
                          context,
                          widget.app,
                          widget.app.ownerID!,
                              () => MemberMediumAccessRights(MemberMediumAccessibleByGroup.Public),
                              (photo) => _photoFeedbackFunction(widget.app, photo),
                          _photoUploading,
                          allowCrop: false);
                    } else if (value == 1) {
                      AbstractMediumPlatform.platform!.uploadPhoto(
                          context,
                          widget.app,
                          widget.app.ownerID!,
                              () => MemberMediumAccessRights(MemberMediumAccessibleByGroup.Public),
                              (photo) => _photoFeedbackFunction(widget.app, photo),
                          _photoUploading,
                          allowCrop: false);
                    } else if (value == 2) {
                      var photo = await MemberMediumAccessRights(MemberMediumAccessibleByGroup.Public)
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
      AppModel appModel, MemberMediumModel? platformMediumModel) {
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
