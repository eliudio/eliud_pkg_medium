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
        super(AlbumEntryListLoading()) {
    on <LoadAlbumEntryList> ((event, emit) {
      if ((detailed == null) || (!detailed!)) {
        _mapLoadAlbumEntryListToState();
      } else {
        _mapLoadAlbumEntryListWithDetailsToState();
      }
    });
    
    on <NewPage> ((event, emit) {
      pages = pages + 1; // it doesn't matter so much if we increase pages beyond the end
      _mapLoadAlbumEntryListWithDetailsToState();
    });
    
    on <AlbumEntryChangeQuery> ((event, emit) {
      eliudQuery = event.newQuery;
      if ((detailed == null) || (!detailed!)) {
        _mapLoadAlbumEntryListToState();
      } else {
        _mapLoadAlbumEntryListWithDetailsToState();
      }
    });
      
    on <AddAlbumEntryList> ((event, emit) async {
      await _mapAddAlbumEntryListToState(event);
    });
    
    on <UpdateAlbumEntryList> ((event, emit) async {
      await _mapUpdateAlbumEntryListToState(event);
    });
    
    on <DeleteAlbumEntryList> ((event, emit) async {
      await _mapDeleteAlbumEntryListToState(event);
    });
    
    on <AlbumEntryListUpdated> ((event, emit) {
      emit(_mapAlbumEntryListUpdatedToState(event));
    });
  }

  Future<void> _mapLoadAlbumEntryListToState() async {
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

  Future<void> _mapLoadAlbumEntryListWithDetailsToState() async {
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

  Future<void> _mapAddAlbumEntryListToState(AddAlbumEntryList event) async {
    var value = event.value;
    if (value != null) {
      await _albumEntryRepository.add(value);
    }
  }

  Future<void> _mapUpdateAlbumEntryListToState(UpdateAlbumEntryList event) async {
    var value = event.value;
    if (value != null) {
      await _albumEntryRepository.update(value);
    }
  }

  Future<void> _mapDeleteAlbumEntryListToState(DeleteAlbumEntryList event) async {
    var value = event.value;
    if (value != null) {
      await _albumEntryRepository.delete(value);
    }
  }

  AlbumEntryListLoaded _mapAlbumEntryListUpdatedToState(
      AlbumEntryListUpdated event) => AlbumEntryListLoaded(values: event.value, mightHaveMore: event.mightHaveMore);

  @override
  Future<void> close() {
    _albumEntrysListSubscription?.cancel();
    return super.close();
  }
}


