/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 album_component_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_medium/model/album_model.dart';

/* 
 * AlbumComponentState is the base class for state for AlbumComponentBloc
 */
abstract class AlbumComponentState extends Equatable {
  const AlbumComponentState();

  @override
  List<Object?> get props => [];
}

/* 
 * AlbumComponentUninitialized is the uninitialized state of the AlbumComponentBloc 
 */
class AlbumComponentUninitialized extends AlbumComponentState {}

/* 
 * AlbumComponentError is the error state of the AlbumComponentBloc 
 */
class AlbumComponentError extends AlbumComponentState {
  final String? message;
  AlbumComponentError({ this.message });
}

/* 
 * AlbumComponentPermissionDenied is to indicate permission denied state of the AlbumComponentBloc 
 */
class AlbumComponentPermissionDenied extends AlbumComponentState {
  AlbumComponentPermissionDenied();
}

/* 
 * AlbumComponentLoaded is used to set the state of the AlbumComponentBloc to the loaded state
 */
class AlbumComponentLoaded extends AlbumComponentState {
  final AlbumModel value;

  /* 
   * construct AlbumComponentLoaded
   */
  const AlbumComponentLoaded({ required this.value });

  /* 
   * copy method
   */
  AlbumComponentLoaded copyWith({ AlbumModel? copyThis }) {
    return AlbumComponentLoaded(value: copyThis ?? this.value);
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'AlbumComponentLoaded { value: $value }';
}

