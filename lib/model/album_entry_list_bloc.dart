/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 album_entry_list_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:eliud_pkg_medium/model/album_entry_repository.dart';
import 'package:eliud_pkg_medium/model/album_entry_list_event.dart';
import 'package:eliud_pkg_medium/model/album_entry_list_state.dart';
import 'package:eliud_core/tools/query/query_tools.dart';



class AlbumEntryListBloc extends Bloc<AlbumEntryListEvent, AlbumEntryListState> {
  final AlbumEntryRepository _albumEntryRepository;
  StreamSubscription? _albumEntrysListSubscription;
  EliudQuery? eliudQuery;
  int pages = 1;
  final bool? paged;
  final String? orderBy;
  final bool? descending;
  final bool? detailed;
  final int albumEntryLimit;

  AlbumEntryListBloc({this.paged, this.orderBy, this.descending, this.detailed, this.eliudQuery, required AlbumEntryRepository albumEntryRepository, this.albumEntryLimit = 5})
      : assert(albumEntryRepository != null),
        _albumEntryRepository = albumEntryRepository,
        super(AlbumEntryListLoading());

  Stream<AlbumEntryListState> _mapLoadAlbumEntryListToState() async* {
    int amountNow =  (state is AlbumEntryListLoaded) ? (state as AlbumEntryListLoaded).values!.length : 0;
    _albumEntrysListSubscription?.cancel();
    _albumEntrysListSubscription = _albumEntryRepository.listen(
          (list) => add(AlbumEntryListUpdated(value: list, mightHaveMore: amountNow != list.length)),
      orderBy: orderBy,
      descending: descending,
      eliudQuery: eliudQuery,
      limit: ((paged != null) && paged!) ? pages * albumEntryLimit : null
    );
  }

  Stream<AlbumEntryListState> _mapLoadAlbumEntryListWithDetailsToState() async* {
    int amountNow =  (state is AlbumEntryListLoaded) ? (state as AlbumEntryListLoaded).values!.length : 0;
    _albumEntrysListSubscription?.cancel();
    _albumEntrysListSubscription = _albumEntryRepository.listenWithDetails(
            (list) => add(AlbumEntryListUpdated(value: list, mightHaveMore: amountNow != list.length)),
        orderBy: orderBy,
        descending: descending,
        eliudQuery: eliudQuery,
        limit: ((paged != null) && paged!) ? pages * albumEntryLimit : null
    );
  }

  Stream<AlbumEntryListState> _mapAddAlbumEntryListToState(AddAlbumEntryList event) async* {
    var value = event.value;
    if (value != null) 
      _albumEntryRepository.add(value);
  }

  Stream<AlbumEntryListState> _mapUpdateAlbumEntryListToState(UpdateAlbumEntryList event) async* {
    var value = event.value;
    if (value != null) 
      _albumEntryRepository.update(value);
  }

  Stream<AlbumEntryListState> _mapDeleteAlbumEntryListToState(DeleteAlbumEntryList event) async* {
    var value = event.value;
    if (value != null) 
      _albumEntryRepository.delete(value);
  }

  Stream<AlbumEntryListState> _mapAlbumEntryListUpdatedToState(
      AlbumEntryListUpdated event) async* {
    yield AlbumEntryListLoaded(values: event.value, mightHaveMore: event.mightHaveMore);
  }

  @override
  Stream<AlbumEntryListState> mapEventToState(AlbumEntryListEvent event) async* {
    if (event is LoadAlbumEntryList) {
      if ((detailed == null) || (!detailed!)) {
        yield* _mapLoadAlbumEntryListToState();
      } else {
        yield* _mapLoadAlbumEntryListWithDetailsToState();
      }
    }
    if (event is NewPage) {
      pages = pages + 1; // it doesn't matter so much if we increase pages beyond the end
      yield* _mapLoadAlbumEntryListWithDetailsToState();
    } else if (event is AlbumEntryChangeQuery) {
      eliudQuery = event.newQuery;
      if ((detailed == null) || (!detailed!)) {
        yield* _mapLoadAlbumEntryListToState();
      } else {
        yield* _mapLoadAlbumEntryListWithDetailsToState();
      }
    } else if (event is AddAlbumEntryList) {
      yield* _mapAddAlbumEntryListToState(event);
    } else if (event is UpdateAlbumEntryList) {
      yield* _mapUpdateAlbumEntryListToState(event);
    } else if (event is DeleteAlbumEntryList) {
      yield* _mapDeleteAlbumEntryListToState(event);
    } else if (event is AlbumEntryListUpdated) {
      yield* _mapAlbumEntryListUpdatedToState(event);
    }
  }

  @override
  Future<void> close() {
    _albumEntrysListSubscription?.cancel();
    return super.close();
  }
}


