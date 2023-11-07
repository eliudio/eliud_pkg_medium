/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 album_entry_repository.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_pkg_medium/model/model_export.dart';
import 'package:eliud_pkg_medium/model/entity_export.dart';

import 'dart:async';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/core/base/repository_base.dart';

typedef AlbumEntryModelTrigger = Function(List<AlbumEntryModel?> list);
typedef AlbumEntryChanged = Function(AlbumEntryModel? value);
typedef AlbumEntryErrorHandler = Function(dynamic o, dynamic e);

abstract class AlbumEntryRepository
    extends RepositoryBase<AlbumEntryModel, AlbumEntryEntity> {
  @override
  Future<AlbumEntryEntity> addEntity(String documentID, AlbumEntryEntity value);
  @override
  Future<AlbumEntryEntity> updateEntity(
      String documentID, AlbumEntryEntity value);
  @override
  Future<AlbumEntryModel> add(AlbumEntryModel value);
  @override
  Future<void> delete(AlbumEntryModel value);
  @override
  Future<AlbumEntryModel?> get(String? id, {Function(Exception)? onError});
  @override
  Future<AlbumEntryModel> update(AlbumEntryModel value);

  @override
  Stream<List<AlbumEntryModel?>> values(
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      SetLastDoc? setLastDoc,
      int? privilegeLevel,
      EliudQuery? eliudQuery});
  @override
  Stream<List<AlbumEntryModel?>> valuesWithDetails(
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      SetLastDoc? setLastDoc,
      int? privilegeLevel,
      EliudQuery? eliudQuery});
  @override
  Future<List<AlbumEntryModel?>> valuesList(
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      SetLastDoc? setLastDoc,
      int? privilegeLevel,
      EliudQuery? eliudQuery});
  @override
  Future<List<AlbumEntryModel?>> valuesListWithDetails(
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      SetLastDoc? setLastDoc,
      int? privilegeLevel,
      EliudQuery? eliudQuery});

  @override
  StreamSubscription<List<AlbumEntryModel?>> listen(
      AlbumEntryModelTrigger trigger,
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      int? privilegeLevel,
      EliudQuery? eliudQuery});
  @override
  StreamSubscription<List<AlbumEntryModel?>> listenWithDetails(
      AlbumEntryModelTrigger trigger,
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      int? privilegeLevel,
      EliudQuery? eliudQuery});
  @override
  StreamSubscription<AlbumEntryModel?> listenTo(
      String documentId, AlbumEntryChanged changed,
      {AlbumEntryErrorHandler? errorHandler});
  @override
  void flush();

  @override
  String? timeStampToString(dynamic timeStamp);

  @override
  dynamic getSubCollection(String documentId, String name);
  @override
  Future<AlbumEntryModel?> changeValue(
      String documentId, String fieldName, num changeByThisValue);

  @override
  Future<void> deleteAll();
}
