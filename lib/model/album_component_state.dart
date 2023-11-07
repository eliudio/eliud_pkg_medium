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

abstract class AlbumComponentState extends Equatable {
  const AlbumComponentState();

  @override
  List<Object?> get props => [];
}

class AlbumComponentUninitialized extends AlbumComponentState {}

class AlbumComponentError extends AlbumComponentState {
  final String? message;
  AlbumComponentError({this.message});
}

class AlbumComponentPermissionDenied extends AlbumComponentState {
  AlbumComponentPermissionDenied();
}

class AlbumComponentLoaded extends AlbumComponentState {
  final AlbumModel value;

  const AlbumComponentLoaded({required this.value});

  AlbumComponentLoaded copyWith({AlbumModel? copyThis}) {
    return AlbumComponentLoaded(value: copyThis ?? value);
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'AlbumComponentLoaded { value: $value }';
}
