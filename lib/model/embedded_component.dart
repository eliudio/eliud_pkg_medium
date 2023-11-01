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

typedef AlbumEntryListChanged(List<AlbumEntryModel> values);

albumEntrysList(app, context, value, trigger) => EmbeddedComponentFactory.albumEntrysList(app, context, value, trigger);

class EmbeddedComponentFactory {

static Widget albumEntrysList(AppModel app, BuildContext context, List<AlbumEntryModel> values, AlbumEntryListChanged trigger) {
  AlbumEntryInMemoryRepository inMemoryRepository = AlbumEntryInMemoryRepository(trigger, values,);
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

class AlbumEntryInMemoryRepository implements AlbumEntryRepository {
    final List<AlbumEntryModel> items;
    final AlbumEntryListChanged trigger;
    Stream<List<AlbumEntryModel>>? theValues;

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

    Future<AlbumEntryEntity> addEntity(String documentID, AlbumEntryEntity value) {
      throw Exception('Not implemented'); 
    }

    Future<AlbumEntryEntity> updateEntity(String documentID, AlbumEntryEntity value) {
      throw Exception('Not implemented'); 
    }

    Future<AlbumEntryModel> add(AlbumEntryModel value) {
        items.add(value.copyWith(documentID: newRandomKey()));
        trigger(items);
        return Future.value(value);
    }

    Future<void> delete(AlbumEntryModel value) {
      int index = _index(value.documentID);
      if (index >= 0) items.removeAt(index);
      trigger(items);
      return Future.value(value);
    }

    Future<AlbumEntryModel> update(AlbumEntryModel value) {
      int index = _index(value.documentID);
      if (index >= 0) {
        items.replaceRange(index, index+1, [value]);
        trigger(items);
      }
      return Future.value(value);
    }

    Future<AlbumEntryModel> get(String? id, { Function(Exception)? onError }) {
      int index = _index(id!);
      var completer = new Completer<AlbumEntryModel>();
      completer.complete(items[index]);
      return completer.future;
    }

    Stream<List<AlbumEntryModel>> values({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) {
      return theValues!;
    }
    
    Stream<List<AlbumEntryModel>> valuesWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) {
      return theValues!;
    }
    
    @override
    StreamSubscription<List<AlbumEntryModel>> listen(trigger, { String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery }) {
      return theValues!.listen((theList) => trigger(theList));
    }
  
    @override
    StreamSubscription<List<AlbumEntryModel>> listenWithDetails(trigger, { String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery }) {
      return theValues!.listen((theList) => trigger(theList));
    }
    
    void flush() {}

    Future<List<AlbumEntryModel>> valuesList({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) {
      return Future.value(items);
    }
    
    Future<List<AlbumEntryModel>> valuesListWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) {
      return Future.value(items);
    }

    @override
    getSubCollection(String documentId, String name) {
      throw UnimplementedError();
    }

  @override
  String timeStampToString(timeStamp) {
    throw UnimplementedError();
  }
  
  @override
  StreamSubscription<AlbumEntryModel> listenTo(String documentId, AlbumEntryChanged changed, {AlbumEntryErrorHandler? errorHandler}) {
    throw UnimplementedError();
  }

  @override
  Future<AlbumEntryModel> changeValue(String documentId, String fieldName, num changeByThisValue) {
    throw UnimplementedError();
  }
  
  @override
  Future<AlbumEntryEntity?> getEntity(String? id, {Function(Exception p1)? onError}) {
    throw UnimplementedError();
  }

  @override
  AlbumEntryEntity? fromMap(Object? o, {Map<String, String>? newDocumentIds}) {
    throw UnimplementedError();
  }

    Future<void> deleteAll() async {}
}

