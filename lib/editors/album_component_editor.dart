import 'package:eliud_core/core/blocs/access/state/access_determined.dart';
import 'package:eliud_core/core/blocs/access/state/access_state.dart';
import 'package:eliud_core/core/registry.dart';
import 'package:eliud_core/model/platform_medium_model.dart';
import 'package:eliud_core/model/pos_size_model.dart';
import 'package:eliud_core/model/storage_conditions_model.dart';
import 'package:eliud_core/package/access_rights.dart';
import 'package:eliud_core/tools/screen_size.dart';
import 'package:eliud_core/tools/widgets/background_widget.dart';
import 'package:eliud_pkg_medium/editors/widgets/album_entry_widget.dart';
import 'package:eliud_pkg_medium/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_medium/model/album_entry_model.dart';
import 'package:eliud_pkg_medium/model/album_model.dart';
import 'package:flutter/material.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/style/frontend/has_button.dart';
import 'package:eliud_core/style/frontend/has_container.dart';
import 'package:eliud_core/style/frontend/has_dialog.dart';
import 'package:eliud_core/style/frontend/has_dialog_field.dart';
import 'package:eliud_core/style/frontend/has_divider.dart';
import 'package:eliud_core/style/frontend/has_list_tile.dart';
import 'package:eliud_core/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/tools/component/component_spec.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/tools/widgets/condition_simple_widget.dart';
import 'package:eliud_core/tools/widgets/header_widget.dart';
import 'package:eliud_pkg_medium/platform/medium_platform.dart';
import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/core/editor/ext_editor_base_bloc/ext_editor_base_event.dart';
import 'package:eliud_core/core/editor/ext_editor_base_bloc/ext_editor_base_state.dart';

import 'bloc/album_bloc.dart';

class AlbumComponentEditorConstructor extends ComponentEditorConstructor {
  @override
  void updateComponent(
      AppModel app, BuildContext context, model, EditorFeedback feedback) {
    _openIt(app, context, false, model.copyWith(), feedback);
  }

  @override
  void createNewComponent(
      AppModel app, BuildContext context, EditorFeedback feedback) {
    _openIt(
        app,
        context,
        true,
        AlbumModel(
          appId: app.documentID,
          documentID: newRandomKey(),
          description: 'Album',
          conditions: StorageConditionsModel(
              privilegeLevelRequired:
                  PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
        ),
        feedback);
  }

  @override
  void updateComponentWithID(AppModel app, BuildContext context, String id,
      EditorFeedback feedback) async {
    var album = await albumRepository(appId: app.documentID)!.get(id);
    if (album != null) {
      _openIt(app, context, false, album, feedback);
    } else {
      openErrorDialog(app, context, app.documentID + '/_error',
          title: 'Error', errorMessage: 'Cannot find album with id $id');
    }
  }

  void _openIt(AppModel app, BuildContext context, bool create,
      AlbumModel model, EditorFeedback feedback) {
    openComplexDialog(app, context, app.documentID + '/Album',
        title: create ? 'Create album' : 'Update album',
        includeHeading: false,
        widthFraction: .9,
        child: BlocProvider<AlbumBloc>(
          create: (context) => AlbumBloc(
            app.documentID,
            feedback,
          )..add(ExtEditorBaseInitialise<AlbumModel>(model)),
          child: AlbumComponentEditor(
            app: app,
          ),
        ));
  }
}

class AlbumComponentEditor extends StatefulWidget {
  final AppModel app;

  const AlbumComponentEditor({
    Key? key,
    required this.app,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AlbumComponentEditorState();
}

class _AlbumComponentEditorState extends State<AlbumComponentEditor> {
  double? _progress;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccessBloc, AccessState>(
        builder: (aContext, accessState) {
      if (accessState is AccessDetermined) {
        var member = accessState.getMember();
        if (member != null) {
          var memberId = member.documentID;
          return BlocBuilder<AlbumBloc, ExtEditorBaseState<AlbumModel>>(
              builder: (ppContext, albumState) {
            if (albumState is ExtEditorBaseInitialised<AlbumModel, dynamic>) {
              return ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: [
                    HeaderWidget(
                      app: widget.app,
                      title: 'Album',
                      okAction: () async {
                        await BlocProvider.of<AlbumBloc>(context).save(
                            ExtEditorBaseApplyChanges<AlbumModel>(
                                model: albumState.model));
                        return true;
                      },
                      cancelAction: () async {
                        return true;
                      },
                    ),
                    topicContainer(widget.app, context,
                        title: 'General',
                        collapsible: true,
                        collapsed: true,
                        children: [
                          getListTile(context, widget.app,
                              leading: Icon(Icons.vpn_key),
                              title: text(widget.app, context,
                                  albumState.model.documentID)),
                          getListTile(context, widget.app,
                              leading: Icon(Icons.description),
                              title: dialogField(
                                widget.app,
                                context,
                                initialValue: albumState.model.description,
                                valueChanged: (value) {
                                  albumState.model.description = value;
                                },
                                maxLines: 1,
                                decoration: const InputDecoration(
                                  hintText: 'Name',
                                  labelText: 'Name',
                                ),
                              )),
                        ]),
                    BackgroundWidget(
                        app: widget.app,
                        memberId: memberId,
                        value: albumState.model.backgroundImage!,
                        label: 'Background for Images'),
                    topicContainer(widget.app, context,
                        title: 'Images',
                        collapsible: true,
                        collapsed: true,
                        children: [
                          _images(context, albumState),
                        ]),
                    topicContainer(widget.app, context,
                        title: 'Condition',
                        collapsible: true,
                        collapsed: true,
                        children: [
                          getListTile(context, widget.app,
                              leading: Icon(Icons.security),
                              title: ConditionsSimpleWidget(
                                app: widget.app,
                                value: albumState.model.conditions!,
                                readOnly: albumState.model.albumEntries !=
                                        null &&
                                    albumState.model.albumEntries!.isNotEmpty,
                              )),
                        ]),
                  ]);
            } else {
              return progressIndicator(widget.app, context);
            }
          });
        } else {
          return text(widget.app, context,
              'needs to be logged in as owner to be able to edit');
        }
      } else {
        return progressIndicator(widget.app, context);
      }
    });
  }

  Widget _images(BuildContext context,
      ExtEditorBaseInitialised<AlbumModel, dynamic> state) {
    var widgets = <Widget>[];
    var items =
        state.model.albumEntries != null ? state.model.albumEntries! : [];
    if (state.model.albumEntries != null) {
      var photos = <PlatformMediumModel>[];
      items.forEach((item) {
        if (item.medium != null) {
          photos.add(item.medium!);
        }
      });
    }
    for (var item in items) {
      var medium = item.medium;
      if (medium != null) {
        widgets.add(GestureDetector(
            onTap: () {
              BlocProvider.of<AlbumBloc>(context).add(
                  SelectForEditEvent<AlbumModel, AlbumEntryModel>(item: item));
            },
            child: Padding(
                padding: const EdgeInsets.all(5),
                child: item == state.currentEdit
                    ? Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red, width: 1),
                        ),
                        child: Image.network(
                          medium.url!,
                          //            height: height,
                        ))
                    : Image.network(
                        medium.url!,
                        //            height: height,
                      ))));
      }
    }
    widgets.add(_addButton(state));

    var theWidget = GridView.extent(
        maxCrossAxisExtent: 200,
        padding: const EdgeInsets.all(0),
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        physics: const ScrollPhysics(), // to disable GridView's scrolling
        shrinkWrap: true,
        children: widgets);

    if (state.currentEdit != null) {
      var currentEdit = state.currentEdit!;
      return ListView(shrinkWrap: true, physics: ScrollPhysics(), children: [
        theWidget,
        divider(widget.app, context),
        Row(children: [
          button(widget.app, context,
              icon: Icon(
                Icons.arrow_left,
              ),
              label: 'Move up', onPressed: () async {
            BlocProvider.of<AlbumBloc>(context).add(
                MoveEvent<AlbumModel, AlbumEntryModel>(
                    isUp: true, item: currentEdit));
          }),
          Spacer(),
          button(widget.app, context,
              icon: Icon(
                Icons.edit,
              ),
              label: 'Edit', onPressed: () async {
            openFlexibleDialog(
              widget.app,
              context,
              widget.app.documentID + '/_listeditem',
              includeHeading: false,
              widthFraction: .8,
              child: AlbumEntryModelWidget.getIt(
                context,
                widget.app,
                false,
                fullScreenWidth(context) * .8,
                fullScreenHeight(context) - 100,
                currentEdit,
                (newItem) => _listedItemModelCallback(currentEdit, newItem),
                state.model.conditions!.privilegeLevelRequired == null
                    ? 0
                    : state.model.conditions!.privilegeLevelRequired!.index,
              ),
            );
          }),
          Spacer(),
          button(widget.app, context,
              icon: Icon(
                Icons.delete,
              ),
              label: 'Delete', onPressed: () async {
            BlocProvider.of<AlbumBloc>(context).add(
                DeleteItemEvent<AlbumModel, AlbumEntryModel>(
                    itemModel: currentEdit));
          }),
          Spacer(),
          button(widget.app, context,
              icon: Icon(
                Icons.arrow_right,
              ),
              label: 'Move down', onPressed: () async {
            BlocProvider.of<AlbumBloc>(context).add(
                MoveEvent<AlbumModel, AlbumEntryModel>(
                    isUp: false, item: currentEdit));
          }),
        ]),
      ]);
    } else {
      return theWidget;
    }
  }

  void _listedItemModelCallback(
    AlbumEntryModel oldItem,
    AlbumEntryModel newItem,
  ) {
    BlocProvider.of<AlbumBloc>(context).add(
        UpdateItemEvent<AlbumModel, AlbumEntryModel>(
            oldItem: oldItem, newItem: newItem));
  }

  Widget _addButton(ExtEditorBaseInitialised<AlbumModel, dynamic> albumState) {
    if (_progress != null) {
      return progressIndicatorWithValue(widget.app, context, value: _progress!);
    } else {
      return popupMenuButton<int>(
          widget.app, context,
          child: Icon(Icons.add),
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
                  label: 'Upload image',
                ),
              ],
          onSelected: (value) async {
            if (value == 0) {
              Registry.registry()!.getMediumApi().takePhoto(
                  context,
                  widget.app,
                  widget.app.ownerID,
                  () => PlatformMediumAccessRights(
                      albumState.model.conditions!.privilegeLevelRequired!),
                  (photo) => _photoFeedbackFunction(photo),
                  _photoUploading,
                  allowCrop: false);
            } else if (value == 1) {
              Registry.registry()!.getMediumApi().uploadPhoto(
                  context,
                  widget.app,
                  widget.app.ownerID,
                  () => PlatformMediumAccessRights(
                      albumState.model.conditions!.privilegeLevelRequired!),
                  (photo) => _photoFeedbackFunction(photo),
                  _photoUploading,
                  allowCrop: false);
            }
          });
    }
  }

  void _photoFeedbackFunction(PlatformMediumModel? platformMediumModel) {
    setState(() {
      _progress = null;
      if (platformMediumModel != null) {
        BlocProvider.of<AlbumBloc>(context)
            .add(AddItemEvent<AlbumModel, AlbumEntryModel>(
                itemModel: AlbumEntryModel(
          documentID: newRandomKey(),
          medium: platformMediumModel,
          name: 'new entry',
        )));
      }
    });
  }

  void _photoUploading(dynamic progress) {
    if (progress != null) {}
    setState(() {
      _progress = progress;
    });
  }
}
