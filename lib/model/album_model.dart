/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 album_model.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:collection/collection.dart';
import 'package:eliud_core/tools/common_tools.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:eliud_core/model/repository_export.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_medium/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_medium/model/repository_export.dart';
import 'package:eliud_core/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_medium/model/model_export.dart';
import 'package:eliud_core/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_medium/model/entity_export.dart';


import 'package:eliud_pkg_medium/model/album_entity.dart';

import 'package:eliud_core/tools/random.dart';



class AlbumModel {
  String? documentID;

  // This is the identifier of the app to which this feed belongs
  String? appId;
  List<AlbumEntryModel>? albumEntries;
  String? description;
  StorageConditionsModel? conditions;

  AlbumModel({this.documentID, this.appId, this.albumEntries, this.description, this.conditions, })  {
    assert(documentID != null);
  }

  AlbumModel copyWith({String? documentID, String? appId, List<AlbumEntryModel>? albumEntries, String? description, StorageConditionsModel? conditions, }) {
    return AlbumModel(documentID: documentID ?? this.documentID, appId: appId ?? this.appId, albumEntries: albumEntries ?? this.albumEntries, description: description ?? this.description, conditions: conditions ?? this.conditions, );
  }

  @override
  int get hashCode => documentID.hashCode ^ appId.hashCode ^ albumEntries.hashCode ^ description.hashCode ^ conditions.hashCode;

  @override
  bool operator ==(Object other) =>
          identical(this, other) ||
          other is AlbumModel &&
          runtimeType == other.runtimeType && 
          documentID == other.documentID &&
          appId == other.appId &&
          ListEquality().equals(albumEntries, other.albumEntries) &&
          description == other.description &&
          conditions == other.conditions;

  @override
  String toString() {
    String albumEntriesCsv = (albumEntries == null) ? '' : albumEntries!.join(', ');

    return 'AlbumModel{documentID: $documentID, appId: $appId, albumEntries: AlbumEntry[] { $albumEntriesCsv }, description: $description, conditions: $conditions}';
  }

  AlbumEntity toEntity({String? appId}) {
    return AlbumEntity(
          appId: (appId != null) ? appId : null, 
          albumEntries: (albumEntries != null) ? albumEntries
            !.map((item) => item.toEntity(appId: appId))
            .toList() : null, 
          description: (description != null) ? description : null, 
          conditions: (conditions != null) ? conditions!.toEntity(appId: appId) : null, 
    );
  }

  static Future<AlbumModel?> fromEntity(String documentID, AlbumEntity? entity) async {
    if (entity == null) return null;
    var counter = 0;
    return AlbumModel(
          documentID: documentID, 
          appId: entity.appId, 
          albumEntries: 
            entity.albumEntries == null ? null : List<AlbumEntryModel>.from(await Future.wait(entity. albumEntries
            !.map((item) {
            counter++;
              return AlbumEntryModel.fromEntity(counter.toString(), item);
            })
            .toList())), 
          description: entity.description, 
          conditions: 
            await StorageConditionsModel.fromEntity(entity.conditions), 
    );
  }

  static Future<AlbumModel?> fromEntityPlus(String documentID, AlbumEntity? entity, { String? appId}) async {
    if (entity == null) return null;

    var counter = 0;
    return AlbumModel(
          documentID: documentID, 
          appId: entity.appId, 
          albumEntries: 
            entity. albumEntries == null ? null : List<AlbumEntryModel>.from(await Future.wait(entity. albumEntries
            !.map((item) {
            counter++;
            return AlbumEntryModel.fromEntityPlus(counter.toString(), item, appId: appId);})
            .toList())), 
          description: entity.description, 
          conditions: 
            await StorageConditionsModel.fromEntityPlus(entity.conditions, appId: appId), 
    );
  }

}

