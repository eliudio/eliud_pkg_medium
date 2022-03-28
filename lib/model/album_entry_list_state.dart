/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 album_entry_list_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_medium/model/album_entry_model.dart';

abstract class AlbumEntryListState extends Equatable {
  const AlbumEntryListState();

  @override
  List<Object?> get props => [];
}

class AlbumEntryListLoading extends AlbumEntryListState {}

class AlbumEntryListLoaded extends AlbumEntryListState {
  final List<AlbumEntryModel?>? values;
  final bool? mightHaveMore;

  const AlbumEntryListLoaded({this.mightHaveMore, this.values = const []});

  @override
  List<Object?> get props => [ values, mightHaveMore ];

  @override
  String toString() => 'AlbumEntryListLoaded { values: $values }';

  @override
  bool operator ==(Object other) => 
          other is AlbumEntryListLoaded &&
              runtimeType == other.runtimeType &&
              ListEquality().equals(values, other.values) &&
              mightHaveMore == other.mightHaveMore;
}

class AlbumEntryNotLoaded extends AlbumEntryListState {}

