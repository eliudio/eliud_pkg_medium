/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 album_entry_list_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_medium/model/album_entry_model.dart';

abstract class AlbumEntryListEvent extends Equatable {
  const AlbumEntryListEvent();
  @override
  List<Object?> get props => [];
}

class LoadAlbumEntryList extends AlbumEntryListEvent {}

class NewPage extends AlbumEntryListEvent {}

class AddAlbumEntryList extends AlbumEntryListEvent {
  final AlbumEntryModel? value;

  const AddAlbumEntryList({ this.value });

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'AddAlbumEntryList{ value: $value }';
}

class UpdateAlbumEntryList extends AlbumEntryListEvent {
  final AlbumEntryModel? value;

  const UpdateAlbumEntryList({ this.value });

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'UpdateAlbumEntryList{ value: $value }';
}

class DeleteAlbumEntryList extends AlbumEntryListEvent {
  final AlbumEntryModel? value;

  const DeleteAlbumEntryList({ this.value });

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'DeleteAlbumEntryList{ value: $value }';
}

class AlbumEntryListUpdated extends AlbumEntryListEvent {
  final List<AlbumEntryModel?>? value;
  final bool? mightHaveMore;

  const AlbumEntryListUpdated({ this.value, this.mightHaveMore });

  @override
  List<Object?> get props => [ value, mightHaveMore ];

  @override
  String toString() => 'AlbumEntryListUpdated{ value: $value, mightHaveMore: $mightHaveMore }';
}

