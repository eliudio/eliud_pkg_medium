/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 album_component.dart
                       
 This code is generated. This is read only. Don't touch!

*/


import 'package:eliud_pkg_medium/model/album_component_bloc.dart';
import 'package:eliud_pkg_medium/model/album_component_event.dart';
import 'package:eliud_pkg_medium/model/album_model.dart';
import 'package:eliud_pkg_medium/model/album_repository.dart';
import 'package:eliud_pkg_medium/model/album_component_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core_model/style/style_registry.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core_model/widgets/alert_widget.dart';
import 'package:eliud_core_model/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_core_model/model/app_model.dart';

/*
 * AbstractAlbumComponent is the base class to extend / implement in case you need to implement a component
 */
abstract class AbstractAlbumComponent extends StatelessWidget {
  static String componentName = "albums";
  final AppModel app;
  final String albumId;

  /*
   * Construct AbstractAlbumComponent
   */
  AbstractAlbumComponent({Key? key, required this.app, required this.albumId}): super(key: key);

  /*
   * build the component
   */
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AlbumComponentBloc> (
          create: (context) => AlbumComponentBloc(
            albumRepository: albumRepository(appId: app.documentID)!)
        ..add(FetchAlbumComponent(id: albumId)),
      child: _albumBlockBuilder(context),
    );
  }

  Widget _albumBlockBuilder(BuildContext context) {
    return BlocBuilder<AlbumComponentBloc, AlbumComponentState>(builder: (context, state) {
      if (state is AlbumComponentLoaded) {
        return yourWidget(context, state.value);
      } else if (state is AlbumComponentPermissionDenied) {
        return Icon(
          Icons.highlight_off,
          color: Colors.red,
          size: 30.0,
        );
      } else if (state is AlbumComponentError) {
        return AlertWidget(app: app, title: 'Error', content: state.message);
      } else {
        return Center(
          child: StyleRegistry.registry().styleWithApp(app).frontEndStyle().progressIndicatorStyle().progressIndicator(app, context),
        );
      }
    });
  }

  /*
   * Implement this method to provide your widget
   */
  Widget yourWidget(BuildContext context, AlbumModel value);
}

