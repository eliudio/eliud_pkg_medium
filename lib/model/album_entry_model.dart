/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 album_entry_model.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core/core/base/model_base.dart';

import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_medium/model/entity_export.dart';

import 'package:eliud_pkg_medium/model/album_entry_entity.dart';

class AlbumEntryModel implements ModelBase {
  static const String packageName = 'eliud_pkg_medium';
  static const String id = 'albumEntrys';

  @override
  String documentID;
  String? name;
  PlatformMediumModel? medium;

  AlbumEntryModel({
    required this.documentID,
    this.name,
    this.medium,
  });

  @override
  AlbumEntryModel copyWith({
    String? documentID,
    String? name,
    PlatformMediumModel? medium,
  }) {
    return AlbumEntryModel(
      documentID: documentID ?? this.documentID,
      name: name ?? this.name,
      medium: medium ?? this.medium,
    );
  }

  @override
  int get hashCode => documentID.hashCode ^ name.hashCode ^ medium.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlbumEntryModel &&
          runtimeType == other.runtimeType &&
          documentID == other.documentID &&
          name == other.name &&
          medium == other.medium;

  @override
  String toString() {
    return 'AlbumEntryModel{documentID: $documentID, name: $name, medium: $medium}';
  }

  @override
  Future<List<ModelReference>> collectReferences({String? appId}) async {
    List<ModelReference> referencesCollector = [];
    if (medium != null) {
      referencesCollector.add(ModelReference(
          PlatformMediumModel.packageName, PlatformMediumModel.id, medium!));
    }
    if (medium != null) {
      referencesCollector.addAll(await medium!.collectReferences(appId: appId));
    }
    return referencesCollector;
  }

  @override
  AlbumEntryEntity toEntity({String? appId}) {
    return AlbumEntryEntity(
      name: (name != null) ? name : null,
      mediumId: (medium != null) ? medium!.documentID : null,
    );
  }

  static Future<AlbumEntryModel?> fromEntity(
      String documentID, AlbumEntryEntity? entity) async {
    if (entity == null) return null;
    return AlbumEntryModel(
      documentID: documentID,
      name: entity.name,
    );
  }

  static Future<AlbumEntryModel?> fromEntityPlus(
      String documentID, AlbumEntryEntity? entity,
      {String? appId}) async {
    if (entity == null) return null;

    PlatformMediumModel? mediumHolder;
    if (entity.mediumId != null) {
      try {
        mediumHolder =
            await platformMediumRepository(appId: appId)!.get(entity.mediumId);
      } on Exception catch (e) {
        print('Error whilst trying to initialise medium');
        print(
            'Error whilst retrieving platformMedium with id ${entity.mediumId}');
        print('Exception: $e');
      }
    }

    return AlbumEntryModel(
      documentID: documentID,
      name: entity.name,
      medium: mediumHolder,
    );
  }
}
