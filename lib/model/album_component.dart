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
import 'package:eliud_core/style/style_registry.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';

abstract class AbstractAlbumComponent extends StatelessWidget {
  static String componentName = "albums";
  final String theAppId;
  final String albumId;

  AbstractAlbumComponent({Key? key, required this.theAppId, required this.albumId}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AlbumComponentBloc> (
          create: (context) => AlbumComponentBloc(
            albumRepository: albumRepository(appId: theAppId)!)
        ..add(FetchAlbumComponent(id: albumId)),
      child: _albumBlockBuilder(context),
    );
  }

  Widget _albumBlockBuilder(BuildContext context) {
    return BlocBuilder<AlbumComponentBloc, AlbumComponentState>(builder: (context, state) {
      if (state is AlbumComponentLoaded) {
        if (state.value == null) {
          return AlertWidget(title: "Error", content: 'No Album defined');
        } else {
          return yourWidget(context, state.value);
        }
      } else if (state is AlbumComponentPermissionDenied) {
        return Icon(
          Icons.highlight_off,
          color: Colors.red,
          size: 30.0,
        );
      } else if (state is AlbumComponentError) {
        return AlertWidget(title: 'Error', content: state.message);
      } else {
        return Center(
          child: StyleRegistry.registry().styleWithContext(context).frontEndStyle().progressIndicatorStyle().progressIndicator(context),
        );
      }
    });
  }

  Widget yourWidget(BuildContext context, AlbumModel value);
}
