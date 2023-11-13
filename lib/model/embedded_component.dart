/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 model/embedded_component.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_core/model/app_model.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/album_entry_list_bloc.dart';
import '../model/album_entry_list.dart';
import '../model/album_entry_list_event.dart';
import '../model/album_entry_model.dart';
import '../model/album_entry_entity.dart';
import '../model/album_entry_repository.dart';

typedef AlbumEntryListChanged = Function(List<AlbumEntryModel> values);

albumEntrysList(app, context, value, trigger) =>
    EmbeddedComponentFactory.albumEntrysList(app, context, value, trigger);

class EmbeddedComponentFactory {
/* 
 * albumEntrysList function to construct a list of AlbumEntryModel
 */
  static Widget albumEntrysList(AppModel app, BuildContext context,
      List<AlbumEntryModel> values, AlbumEntryListChanged trigger) {
    AlbumEntryInMemoryRepository inMemoryRepository =
        AlbumEntryInMemoryRepository(
      trigger,
      values,
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider<AlbumEntryListBloc>(
          create: (context) => AlbumEntryListBloc(
            albumEntryRepository: inMemoryRepository,
          )..add(LoadAlbumEntryList()),
        )
      ],
      child: AlbumEntryListWidget(app: app, isEmbedded: true),
    );
  }
}

/* 
 * AlbumEntryInMemoryRepository is an in memory implementation of AlbumEntryRepository
 */
class AlbumEntryInMemoryRepository implements AlbumEntryRepository {
  final List<AlbumEntryModel> items;
  final AlbumEntryListChanged trigger;
  Stream<List<AlbumEntryModel>>? theValues;

  /* 
     * Construct the AlbumEntryInMemoryRepository
     */
  AlbumEntryInMemoryRepository(this.trigger, this.items) {
    List<List<AlbumEntryModel>> myList = <List<AlbumEntryModel>>[];
    myList.add(items);
    theValues = Stream<List<AlbumEntryModel>>.fromIterable(myList);
  }

  int _index(String documentID) {
    int i = 0;
    for (final item in items) {
      if (item.documentID == documentID) {
        return i;
      }
      i++;
    }
    return -1;
  }

  /* 
     * Add an entity
     */
  @override
  Future<AlbumEntryEntity> addEntity(
      String documentID, AlbumEntryEntity value) {
    throw Exception('Not implemented');
  }

  /* 
     * Update an entity
     */
  @override
  Future<AlbumEntryEntity> updateEntity(
      String documentID, AlbumEntryEntity value) {
    throw Exception('Not implemented');
  }

  /* 
     * Update a model
     */
  @override
  Future<AlbumEntryModel> add(AlbumEntryModel value) {
    items.add(value.copyWith(documentID: newRandomKey()));
    trigger(items);
    return Future.value(value);
  }

  /* 
     * Delete a model
     */
  @override
  Future<void> delete(AlbumEntryModel value) {
    int index = _index(value.documentID);
    if (index >= 0) items.removeAt(index);
    trigger(items);
    return Future.value();
  }

  /* 
     * Update a model
     */
  @override
  Future<AlbumEntryModel> update(AlbumEntryModel value) {
    int index = _index(value.documentID);
    if (index >= 0) {
      items.replaceRange(index, index + 1, [value]);
      trigger(items);
    }
    return Future.value(value);
  }

  /* 
     * Get a model
     */
  @override
  Future<AlbumEntryModel> get(String? id, {Function(Exception)? onError}) {
    int index = _index(id!);
    var completer = Completer<AlbumEntryModel>();
    completer.complete(items[index]);
    return completer.future;
  }

  /* 
     * Retrieve to a list of AlbumEntryModel base on a query
     */
  @override
  Stream<List<AlbumEntryModel>> values(
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      SetLastDoc? setLastDoc,
      int? privilegeLevel,
      EliudQuery? eliudQuery}) {
    return theValues!;
  }

  /* 
     * Retrieve to a list of AlbumEntryModel, including linked models base on a query
     */
  @override
  Stream<List<AlbumEntryModel>> valuesWithDetails(
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      SetLastDoc? setLastDoc,
      int? privilegeLevel,
      EliudQuery? eliudQuery}) {
    return theValues!;
  }

  /* 
     * Subscribe to a list of AlbumEntryModel base on a query
     */
  @override
  StreamSubscription<List<AlbumEntryModel>> listen(trigger,
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      int? privilegeLevel,
      EliudQuery? eliudQuery}) {
    return theValues!.listen((theList) => trigger(theList));
  }

  /* 
     * Subscribe to a list of AlbumEntryModel, including linked models, base on a query
     */
  @override
  StreamSubscription<List<AlbumEntryModel>> listenWithDetails(trigger,
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      int? privilegeLevel,
      EliudQuery? eliudQuery}) {
    return theValues!.listen((theList) => trigger(theList));
  }

  /* 
     * Flush the repository
     */
  @override
  void flush() {}

  /* 
     * Retrieve the list of models
     */
  @override
  Future<List<AlbumEntryModel>> valuesList(
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      SetLastDoc? setLastDoc,
      int? privilegeLevel,
      EliudQuery? eliudQuery}) {
    return Future.value(items);
  }

  @override
  Future<List<AlbumEntryModel>> valuesListWithDetails(
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      SetLastDoc? setLastDoc,
      int? privilegeLevel,
      EliudQuery? eliudQuery}) {
    return Future.value(items);
  }

  /* 
     * Retrieve a subcollection of this collection
     */
  @override
  getSubCollection(String documentId, String name) {
    throw UnimplementedError();
  }

  /* 
   * Retrieve a timestamp
   */
  @override
  String timeStampToString(timeStamp) {
    throw UnimplementedError();
  }

  /* 
   * Subscribe to 1 document / 1 model
   */
  @override
  StreamSubscription<AlbumEntryModel> listenTo(
      String documentId, AlbumEntryChanged changed,
      {AlbumEntryErrorHandler? errorHandler}) {
    throw UnimplementedError();
  }

  @override
  Future<AlbumEntryModel> changeValue(
      String documentId, String fieldName, num changeByThisValue) {
    throw UnimplementedError();
  }

  @override
  Future<AlbumEntryEntity?> getEntity(String? id,
      {Function(Exception p1)? onError}) {
    throw UnimplementedError();
  }

  @override
  AlbumEntryEntity? fromMap(Object? o, {Map<String, String>? newDocumentIds}) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAll() async {}
}
