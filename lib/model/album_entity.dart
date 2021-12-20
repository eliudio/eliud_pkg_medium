/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 album_entity.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:collection';
import 'dart:convert';
import 'abstract_repository_singleton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eliud_core/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_medium/model/entity_export.dart';

import 'package:eliud_core/tools/common_tools.dart';
class AlbumEntity {
  final String? appId;
  final List<AlbumEntryEntity>? albumEntries;
  final String? description;
  final StorageConditionsEntity? conditions;

  AlbumEntity({this.appId, this.albumEntries, this.description, this.conditions, });


  List<Object?> get props => [appId, albumEntries, description, conditions, ];

  @override
  String toString() {
    String albumEntriesCsv = (albumEntries == null) ? '' : albumEntries!.join(', ');

    return 'AlbumEntity{appId: $appId, albumEntries: AlbumEntry[] { $albumEntriesCsv }, description: $description, conditions: $conditions}';
  }

  static AlbumEntity? fromMap(Object? o) {
    if (o == null) return null;
    var map = o as Map<String, dynamic>;

    var albumEntriesFromMap;
    albumEntriesFromMap = map['albumEntries'];
    var albumEntriesList;
    if (albumEntriesFromMap != null)
      albumEntriesList = (map['albumEntries'] as List<dynamic>)
        .map((dynamic item) =>
        AlbumEntryEntity.fromMap(item as Map)!)
        .toList();
    var conditionsFromMap;
    conditionsFromMap = map['conditions'];
    if (conditionsFromMap != null)
      conditionsFromMap = StorageConditionsEntity.fromMap(conditionsFromMap);

    return AlbumEntity(
      appId: map['appId'], 
      albumEntries: albumEntriesList, 
      description: map['description'], 
      conditions: conditionsFromMap, 
    );
  }

  Map<String, Object?> toDocument() {
    final List<Map<String?, dynamic>>? albumEntriesListMap = albumEntries != null 
        ? albumEntries!.map((item) => item.toDocument()).toList()
        : null;
    final Map<String, dynamic>? conditionsMap = conditions != null 
        ? conditions!.toDocument()
        : null;

    Map<String, Object?> theDocument = HashMap();
    if (appId != null) theDocument["appId"] = appId;
      else theDocument["appId"] = null;
    if (albumEntries != null) theDocument["albumEntries"] = albumEntriesListMap;
      else theDocument["albumEntries"] = null;
    if (description != null) theDocument["description"] = description;
      else theDocument["description"] = null;
    if (conditions != null) theDocument["conditions"] = conditionsMap;
      else theDocument["conditions"] = null;
    return theDocument;
  }

  static AlbumEntity? fromJsonString(String json) {
    Map<String, dynamic>? generationSpecificationMap = jsonDecode(json);
    return fromMap(generationSpecificationMap);
  }

  String toJsonString() {
    return jsonEncode(toDocument());
  }

}
