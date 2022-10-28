import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/style/frontend/has_container.dart';
import 'package:eliud_core/style/frontend/has_dialog_field.dart';
import 'package:eliud_core/style/frontend/has_divider.dart';
import 'package:eliud_core/style/frontend/has_list_tile.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/tools/widgets/header_widget.dart';
import 'package:eliud_pkg_medium/model/album_entry_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef void AlbumEntryModelCallback(AlbumEntryModel listedItemModel);

class AlbumEntryModelWidget extends StatefulWidget {
  final bool create;
  final double widgetWidth;
  final double widgetHeight;
  final AppModel app;
  final AlbumEntryModel listedItemModel;
  final AlbumEntryModelCallback listedItemModelCallback;
  final int containerPrivilege;

  AlbumEntryModelWidget._({
    Key? key,
    required this.app,
    required this.create,
    required this.widgetWidth,
    required this.widgetHeight,
    required this.listedItemModel,
    required this.listedItemModelCallback,
    required this.containerPrivilege,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AlbumEntryModelWidgetState();
  }

  static Widget getIt(
      BuildContext context,
      AppModel app,
      bool create,
      double widgetWidth,
      double widgetHeight,
      AlbumEntryModel listedItemModel,
      AlbumEntryModelCallback listedItemModelCallback,
      int containerPrivilege) {
    var copyOf = listedItemModel.copyWith();
    return AlbumEntryModelWidget._(
      app: app,
      create: create,
      widgetWidth: widgetWidth,
      widgetHeight: widgetHeight,
      listedItemModel: copyOf,
      listedItemModelCallback: listedItemModelCallback,
      containerPrivilege: containerPrivilege,
    );
  }
}

class _AlbumEntryModelWidgetState extends State<AlbumEntryModelWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, physics: ScrollPhysics(), children: [
      HeaderWidget(
        app: widget.app,
        cancelAction: () async {
          return true;
        },
        okAction: () async {
          widget.listedItemModelCallback(widget.listedItemModel);
          return true;
        },
        title: 'Fader image settings',
      ),
      divider(widget.app, context),
      topicContainer(widget.app, context,
          title: 'General',
          collapsible: true,
          collapsed: true,
          children: [
            getListTile(context, widget.app,
                leading: Icon(Icons.vpn_key),
                title: text(
                    widget.app, context, widget.listedItemModel.documentID)),
            getListTile(context, widget.app,
                leading: Icon(Icons.description),
                title: dialogField(
                  widget.app,
                  context,
                  initialValue: widget.listedItemModel.name,
                  valueChanged: (value) {
                    widget.listedItemModel.name = value;
                  },
                  maxLines: 1,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                    labelText: 'Description',
                  ),
                )),
          ]),
    ]);
  }
}
