/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 model/internal_component.dart
                       
 This code is generated. This is read only. Don't touch!

*/


import 'package:eliud_core_model/tools/component/component_constructor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core_model/tools/query/query_tools.dart';

import 'package:eliud_core_model/tools/etc/has_fab.dart';


import 'package:eliud_pkg_medium/model/album_list_bloc.dart';
import 'package:eliud_pkg_medium/model/album_list.dart';
import 'package:eliud_pkg_medium/model/album_dropdown_button.dart';
import 'package:eliud_pkg_medium/model/album_list_event.dart';

import 'package:eliud_core_model/model/repository_export.dart';
import 'package:eliud_core_model/model/abstract_repository_singleton.dart';
import 'package:eliud_core_model/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_medium/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_medium/model/repository_export.dart';
import 'package:eliud_core_model/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_medium/model/model_export.dart';
import 'package:eliud_core_model/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_medium/model/entity_export.dart';

class ListComponentFactory implements ComponentConstructor {
  Widget? createNew({Key? key, required AppModel app,  required String id, int? privilegeLevel, Map<String, dynamic>? parameters}) {
    return ListComponent(app: app, componentId: id);
  }

  @override
  dynamic getModel({required AppModel app, required String id}) {
    return null;
  }
}


typedef DropdownButtonChanged(String? value, int? privilegeLevel);

class DropdownButtonComponentFactory implements ComponentDropDown {
  @override
  dynamic getModel({required AppModel app, required String id}) {
    return null;
  }


  bool supports(String id) {

    if (id == "albums") return true;
    return false;
  }

  Widget createNew({Key? key, required AppModel app, required String id, int? privilegeLevel, Map<String, dynamic>? parameters, String? value, DropdownButtonChanged? trigger, bool? optional}) {

    if (id == "albums")
      return DropdownButtonComponent(app: app, componentId: id, value: value, privilegeLevel: privilegeLevel, trigger: trigger, optional: optional);

    return Text("Id $id not found");
  }
}


class ListComponent extends StatelessWidget with HasFab {
  final AppModel app;
  final String? componentId;
  final Widget? widget;
  final int? privilegeLevel;

  @override
  Widget? fab(BuildContext context){
    if ((widget != null) && (widget is HasFab)) {
      HasFab hasFab = widget as HasFab;
      return hasFab.fab(context);
    }
    return null;
  }

  ListComponent({required this.app, this.privilegeLevel, this.componentId}) : widget = getWidget(componentId, app);

  @override
  Widget build(BuildContext context) {

    if (componentId == 'albums') { return _albumBuild(context);}
    return Text('Component with componentId == $componentId not found');
  }

  static Widget getWidget(String? componentId, AppModel app) {
    if (componentId == 'albums') { return AlbumListWidget(app: app);}
  return Container();
  }

  Widget _albumBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AlbumListBloc>(
          create: (context) => AlbumListBloc(
            eliudQuery: EliudQuery(theConditions: [
              EliudQueryCondition('conditions.privilegeLevelRequired', isEqualTo: privilegeLevel ?? 0),
              EliudQueryCondition('appId', isEqualTo: app.documentID),]
            ),
            albumRepository: albumRepository(appId: app.documentID)!,
          )..add(LoadAlbumList()),
        )
      ],
      child: widget!,
    );
  }

}


typedef Changed(String? value, int? privilegeLevel);

class DropdownButtonComponent extends StatelessWidget {
  final AppModel app;
  final String? componentId;
  final String? value;
  final Changed? trigger;
  final bool? optional;
  final int? privilegeLevel;

  DropdownButtonComponent({required this.app, this.componentId, this.privilegeLevel, this.value, this.trigger, this.optional});

  @override
  Widget build(BuildContext context) {

    if (componentId == 'albums') { return _albumBuild(context);}
    return Text('Component with componentId == $componentId not found');
  }


  Widget _albumBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AlbumListBloc>(
          create: (context) => AlbumListBloc(
            eliudQuery: EliudQuery(theConditions: [
              EliudQueryCondition('conditions.privilegeLevelRequired', isEqualTo: privilegeLevel ?? 0),
              EliudQueryCondition('appId', isEqualTo: app.documentID),]
            ),
            albumRepository: albumRepository(appId: app.documentID)!,
          )..add(LoadAlbumList()),
        )
      ],
      child: AlbumDropdownButtonWidget(app: app, value: value, privilegeLevel: privilegeLevel, trigger: trigger, optional: optional),
    );
  }

}


