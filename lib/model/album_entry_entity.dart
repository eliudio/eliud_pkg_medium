/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 album_entry_entity.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:collection';
import 'dart:convert';
import 'package:eliud_core_model/tools/etc/random.dart';
import 'abstract_repository_singleton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eliud_core_model/tools/base/entity_base.dart';
import 'package:eliud_core_model/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_medium/model/entity_export.dart';

import 'package:eliud_core_model/tools/common_tools.dart';
class AlbumEntryEntity implements EntityBase {
  final String? name;
  final String? mediumId;

  AlbumEntryEntity({this.name, this.mediumId, });

  AlbumEntryEntity copyWith({String? documentID, String? name, String? mediumId, }) {
    return AlbumEntryEntity(name : name ?? this.name, mediumId : mediumId ?? this.mediumId, );
  }
  List<Object?> get props => [name, mediumId, ];

  @override
  String toString() {
    return 'AlbumEntryEntity{name: $name, mediumId: $mediumId}';
  }

  static AlbumEntryEntity? fromMap(Object? o, {Map<String, String>? newDocumentIds}) {
    if (o == null) return null;
    var map = o as Map<String, dynamic>;

    var mediumIdNewDocmentId = map['mediumId'];
    if ((newDocumentIds != null) && (mediumIdNewDocmentId != null)) {
      var mediumIdOldDocmentId = mediumIdNewDocmentId;
      mediumIdNewDocmentId = newRandomKey();
      newDocumentIds[mediumIdOldDocmentId] = mediumIdNewDocmentId;
    }
    return AlbumEntryEntity(
      name: map['name'], 
      mediumId: mediumIdNewDocmentId, 
    );
  }

  Map<String, Object?> toDocument() {
    Map<String, Object?> theDocument = HashMap();
    if (name != null) theDocument["name"] = name;
      else theDocument["name"] = null;
    if (mediumId != null) theDocument["mediumId"] = mediumId;
      else theDocument["mediumId"] = null;
    return theDocument;
  }

  @override
  AlbumEntryEntity switchAppId({required String newAppId}) {
    var newEntity = copyWith();
    return newEntity;
  }

  static AlbumEntryEntity? fromJsonString(String json, {Map<String, String>? newDocumentIds}) {
    Map<String, dynamic>? generationSpecificationMap = jsonDecode(json);
    return fromMap(generationSpecificationMap, newDocumentIds: newDocumentIds);
  }

  String toJsonString() {
    return jsonEncode(toDocument());
  }

  Future<Map<String, Object?>> enrichedDocument(Map<String, Object?> theDocument) async {
    return theDocument;
  }

}

