/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 album_repository.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_pkg_medium/model/model_export.dart';
import 'package:eliud_pkg_medium/model/entity_export.dart';

import 'dart:async';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/core/base/repository_base.dart';

typedef AlbumModelTrigger = Function(List<AlbumModel?> list);
typedef AlbumChanged = Function(AlbumModel? value);
typedef AlbumErrorHandler = Function(dynamic o, dynamic e);

abstract class AlbumRepository extends RepositoryBase<AlbumModel, AlbumEntity> {
  @override
  Future<AlbumEntity> addEntity(String documentID, AlbumEntity value);
  @override
  Future<AlbumEntity> updateEntity(String documentID, AlbumEntity value);
  @override
  Future<AlbumModel> add(AlbumModel value);
  @override
  Future<void> delete(AlbumModel value);
  @override
  Future<AlbumModel?> get(String? id, {Function(Exception)? onError});
  @override
  Future<AlbumModel> update(AlbumModel value);

  @override
  Stream<List<AlbumModel?>> values(
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      SetLastDoc? setLastDoc,
      int? privilegeLevel,
      EliudQuery? eliudQuery});
  @override
  Stream<List<AlbumModel?>> valuesWithDetails(
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      SetLastDoc? setLastDoc,
      int? privilegeLevel,
      EliudQuery? eliudQuery});
  @override
  Future<List<AlbumModel?>> valuesList(
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      SetLastDoc? setLastDoc,
      int? privilegeLevel,
      EliudQuery? eliudQuery});
  @override
  Future<List<AlbumModel?>> valuesListWithDetails(
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      SetLastDoc? setLastDoc,
      int? privilegeLevel,
      EliudQuery? eliudQuery});

  @override
  StreamSubscription<List<AlbumModel?>> listen(AlbumModelTrigger trigger,
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      int? privilegeLevel,
      EliudQuery? eliudQuery});
  @override
  StreamSubscription<List<AlbumModel?>> listenWithDetails(
      AlbumModelTrigger trigger,
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      int? privilegeLevel,
      EliudQuery? eliudQuery});
  @override
  StreamSubscription<AlbumModel?> listenTo(
      String documentId, AlbumChanged changed,
      {AlbumErrorHandler? errorHandler});
  @override
  void flush();

  @override
  String? timeStampToString(dynamic timeStamp);

  @override
  dynamic getSubCollection(String documentId, String name);
  @override
  Future<AlbumModel?> changeValue(
      String documentId, String fieldName, num changeByThisValue);

  @override
  Future<void> deleteAll();
}
