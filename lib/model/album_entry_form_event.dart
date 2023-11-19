/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 album_entry_form_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:eliud_core_model/tools/common_tools.dart';
import 'package:eliud_core_model/model/repository_export.dart';
import 'package:eliud_core_model/model/abstract_repository_singleton.dart';
import 'package:eliud_core_model/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_medium/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_medium/model/repository_export.dart';
import 'package:eliud_core_model/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_medium/model/model_export.dart';
import 'package:eliud_core_model/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_medium/model/entity_export.dart';


@immutable
abstract class AlbumEntryFormEvent extends Equatable {
  const AlbumEntryFormEvent();

  @override
  List<Object?> get props => [];
}

class InitialiseNewAlbumEntryFormEvent extends AlbumEntryFormEvent {
}


class InitialiseAlbumEntryFormEvent extends AlbumEntryFormEvent {
  final AlbumEntryModel? value;

  @override
  List<Object?> get props => [ value ];

  InitialiseAlbumEntryFormEvent({this.value});
}

class InitialiseAlbumEntryFormNoLoadEvent extends AlbumEntryFormEvent {
  final AlbumEntryModel? value;

  @override
  List<Object?> get props => [ value ];

  InitialiseAlbumEntryFormNoLoadEvent({this.value});
}

class ChangedAlbumEntryDocumentID extends AlbumEntryFormEvent {
  final String? value;

  ChangedAlbumEntryDocumentID({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedAlbumEntryDocumentID{ value: $value }';
}

class ChangedAlbumEntryName extends AlbumEntryFormEvent {
  final String? value;

  ChangedAlbumEntryName({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedAlbumEntryName{ value: $value }';
}

class ChangedAlbumEntryMedium extends AlbumEntryFormEvent {
  final String? value;

  ChangedAlbumEntryMedium({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedAlbumEntryMedium{ value: $value }';
}

