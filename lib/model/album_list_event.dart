/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 album_list_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_medium/model/album_model.dart';

abstract class AlbumListEvent extends Equatable {
  const AlbumListEvent();
  @override
  List<Object?> get props => [];
}

class LoadAlbumList extends AlbumListEvent {}

class NewPage extends AlbumListEvent {}

class AddAlbumList extends AlbumListEvent {
  final AlbumModel? value;

  const AddAlbumList({ this.value });

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'AddAlbumList{ value: $value }';
}

class UpdateAlbumList extends AlbumListEvent {
  final AlbumModel? value;

  const UpdateAlbumList({ this.value });

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'UpdateAlbumList{ value: $value }';
}

class DeleteAlbumList extends AlbumListEvent {
  final AlbumModel? value;

  const DeleteAlbumList({ this.value });

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'DeleteAlbumList{ value: $value }';
}

class AlbumListUpdated extends AlbumListEvent {
  final List<AlbumModel?>? value;
  final bool? mightHaveMore;

  const AlbumListUpdated({ this.value, this.mightHaveMore });

  @override
  List<Object?> get props => [ value, mightHaveMore ];

  @override
  String toString() => 'AlbumListUpdated{ value: $value, mightHaveMore: $mightHaveMore }';
}

class AlbumChangeQuery extends AlbumListEvent {
  final EliudQuery newQuery;

  const AlbumChangeQuery({ required this.newQuery });

  @override
  List<Object?> get props => [ newQuery ];

  @override
  String toString() => 'AlbumChangeQuery{ value: $newQuery }';
}

