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

/*
 * AlbumComponentEvent is the base class for events to be used with constructing a AlbumComponentBloc 
 */
abstract class AlbumComponentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/*
 * FetchAlbumComponent is the event to instruct the bloc to fetch the component
 */
class FetchAlbumComponent extends AlbumComponentEvent {
  final String? id;

  /*
   * Construct the FetchAlbumComponent
   */
  FetchAlbumComponent({this.id});
}

/*
 * AlbumComponentUpdated is the event to inform the bloc that a component has been updated
 */
class AlbumComponentUpdated extends AlbumComponentEvent {
  final AlbumModel value;

  /*
   * Construct the AlbumComponentUpdated
   */
  AlbumComponentUpdated({required this.value});
}
