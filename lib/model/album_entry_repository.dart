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

typedef AlbumEntryModelTrigger(List<AlbumEntryModel?> list);
typedef AlbumEntryChanged(AlbumEntryModel? value);
typedef AlbumEntryErrorHandler(o, e);

abstract class AlbumEntryRepository extends RepositoryBase<AlbumEntryModel, AlbumEntryEntity> {
  Future<AlbumEntryEntity> addEntity(String documentID, AlbumEntryEntity value);
  Future<AlbumEntryEntity> updateEntity(String documentID, AlbumEntryEntity value);
  Future<AlbumEntryModel> add(AlbumEntryModel value);
  Future<void> delete(AlbumEntryModel value);
  Future<AlbumEntryModel?> get(String? id, { Function(Exception)? onError });
  Future<AlbumEntryModel> update(AlbumEntryModel value);

  Stream<List<AlbumEntryModel?>> values({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery });
  Stream<List<AlbumEntryModel?>> valuesWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery });
  Future<List<AlbumEntryModel?>> valuesList({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery });
  Future<List<AlbumEntryModel?>> valuesListWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery });

  StreamSubscription<List<AlbumEntryModel?>> listen(AlbumEntryModelTrigger trigger, {String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery });
  StreamSubscription<List<AlbumEntryModel?>> listenWithDetails(AlbumEntryModelTrigger trigger, {String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery });
  StreamSubscription<AlbumEntryModel?> listenTo(String documentId, AlbumEntryChanged changed, {AlbumEntryErrorHandler? errorHandler});
  void flush();
  
  String? timeStampToString(dynamic timeStamp);

  dynamic getSubCollection(String documentId, String name);
  Future<AlbumEntryModel?> changeValue(String documentId, String fieldName, num changeByThisValue);

  Future<void> deleteAll();
}


