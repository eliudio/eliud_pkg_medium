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
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/core/base/entity_base.dart';

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

