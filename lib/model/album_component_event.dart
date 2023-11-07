/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 album_component_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_medium/model/album_model.dart';

abstract class AlbumComponentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchAlbumComponent extends AlbumComponentEvent {
  final String? id;

  FetchAlbumComponent({this.id});
}

class AlbumComponentUpdated extends AlbumComponentEvent {
  final AlbumModel value;

  AlbumComponentUpdated({required this.value});
}
