/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 album_list_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_medium/model/album_model.dart';

abstract class AlbumListState extends Equatable {
  const AlbumListState();

  @override
  List<Object?> get props => [];
}

class AlbumListLoading extends AlbumListState {}

class AlbumListLoaded extends AlbumListState {
  final List<AlbumModel?>? values;
  final bool? mightHaveMore;

  const AlbumListLoaded({this.mightHaveMore, this.values = const []});

  @override
  List<Object?> get props => [ values, mightHaveMore ];

  @override
  String toString() => 'AlbumListLoaded { values: $values }';

  @override
  bool operator ==(Object other) => 
          other is AlbumListLoaded &&
              runtimeType == other.runtimeType &&
              ListEquality().equals(values, other.values) &&
              mightHaveMore == other.mightHaveMore;

  @override
  int get hashCode => values.hashCode ^ mightHaveMore.hashCode;
}

class AlbumNotLoaded extends AlbumListState {}

