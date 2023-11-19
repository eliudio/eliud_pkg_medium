/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 album_form_event.dart
                       
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
abstract class AlbumFormEvent extends Equatable {
  const AlbumFormEvent();

  @override
  List<Object?> get props => [];
}

class InitialiseNewAlbumFormEvent extends AlbumFormEvent {
}


class InitialiseAlbumFormEvent extends AlbumFormEvent {
  final AlbumModel? value;

  @override
  List<Object?> get props => [ value ];

  InitialiseAlbumFormEvent({this.value});
}

class InitialiseAlbumFormNoLoadEvent extends AlbumFormEvent {
  final AlbumModel? value;

  @override
  List<Object?> get props => [ value ];

  InitialiseAlbumFormNoLoadEvent({this.value});
}

class ChangedAlbumDocumentID extends AlbumFormEvent {
  final String? value;

  ChangedAlbumDocumentID({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedAlbumDocumentID{ value: $value }';
}

class ChangedAlbumAppId extends AlbumFormEvent {
  final String? value;

  ChangedAlbumAppId({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedAlbumAppId{ value: $value }';
}

class ChangedAlbumAlbumEntries extends AlbumFormEvent {
  final List<AlbumEntryModel>? value;

  ChangedAlbumAlbumEntries({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedAlbumAlbumEntries{ value: $value }';
}

class ChangedAlbumDescription extends AlbumFormEvent {
  final String? value;

  ChangedAlbumDescription({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedAlbumDescription{ value: $value }';
}

class ChangedAlbumBackgroundImage extends AlbumFormEvent {
  final BackgroundModel? value;

  ChangedAlbumBackgroundImage({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedAlbumBackgroundImage{ value: $value }';
}

class ChangedAlbumConditions extends AlbumFormEvent {
  final StorageConditionsModel? value;

  ChangedAlbumConditions({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedAlbumConditions{ value: $value }';
}

