/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 album_list_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:eliud_pkg_medium/model/album_repository.dart';
import 'package:eliud_pkg_medium/model/album_list_event.dart';
import 'package:eliud_pkg_medium/model/album_list_state.dart';
import 'package:eliud_core/tools/query/query_tools.dart';



class AlbumListBloc extends Bloc<AlbumListEvent, AlbumListState> {
  final AlbumRepository _albumRepository;
  StreamSubscription? _albumsListSubscription;
  EliudQuery? eliudQuery;
  int pages = 1;
  final bool? paged;
  final String? orderBy;
  final bool? descending;
  final bool? detailed;
  final int albumLimit;

  AlbumListBloc({this.paged, this.orderBy, this.descending, this.detailed, this.eliudQuery, required AlbumRepository albumRepository, this.albumLimit = 5})
      : assert(albumRepository != null),
        _albumRepository = albumRepository,
        super(AlbumListLoading());

  Stream<AlbumListState> _mapLoadAlbumListToState() async* {
    int amountNow =  (state is AlbumListLoaded) ? (state as AlbumListLoaded).values!.length : 0;
    _albumsListSubscription?.cancel();
    _albumsListSubscription = _albumRepository.listen(
          (list) => add(AlbumListUpdated(value: list, mightHaveMore: amountNow != list.length)),
      orderBy: orderBy,
      descending: descending,
      eliudQuery: eliudQuery,
      limit: ((paged != null) && paged!) ? pages * albumLimit : null
    );
  }

  Stream<AlbumListState> _mapLoadAlbumListWithDetailsToState() async* {
    int amountNow =  (state is AlbumListLoaded) ? (state as AlbumListLoaded).values!.length : 0;
    _albumsListSubscription?.cancel();
    _albumsListSubscription = _albumRepository.listenWithDetails(
            (list) => add(AlbumListUpdated(value: list, mightHaveMore: amountNow != list.length)),
        orderBy: orderBy,
        descending: descending,
        eliudQuery: eliudQuery,
        limit: ((paged != null) && paged!) ? pages * albumLimit : null
    );
  }

  Stream<AlbumListState> _mapAddAlbumListToState(AddAlbumList event) async* {
    var value = event.value;
    if (value != null) 
      _albumRepository.add(value);
  }

  Stream<AlbumListState> _mapUpdateAlbumListToState(UpdateAlbumList event) async* {
    var value = event.value;
    if (value != null) 
      _albumRepository.update(value);
  }

  Stream<AlbumListState> _mapDeleteAlbumListToState(DeleteAlbumList event) async* {
    var value = event.value;
    if (value != null) 
      _albumRepository.delete(value);
  }

  Stream<AlbumListState> _mapAlbumListUpdatedToState(
      AlbumListUpdated event) async* {
    yield AlbumListLoaded(values: event.value, mightHaveMore: event.mightHaveMore);
  }

  @override
  Stream<AlbumListState> mapEventToState(AlbumListEvent event) async* {
    if (event is LoadAlbumList) {
      if ((detailed == null) || (!detailed!)) {
        yield* _mapLoadAlbumListToState();
      } else {
        yield* _mapLoadAlbumListWithDetailsToState();
      }
    }
    if (event is NewPage) {
      pages = pages + 1; // it doesn't matter so much if we increase pages beyond the end
      yield* _mapLoadAlbumListWithDetailsToState();
    } else if (event is AlbumChangeQuery) {
      eliudQuery = event.newQuery;
      if ((detailed == null) || (!detailed!)) {
        yield* _mapLoadAlbumListToState();
      } else {
        yield* _mapLoadAlbumListWithDetailsToState();
      }
    } else if (event is AddAlbumList) {
      yield* _mapAddAlbumListToState(event);
    } else if (event is UpdateAlbumList) {
      yield* _mapUpdateAlbumListToState(event);
    } else if (event is DeleteAlbumList) {
      yield* _mapDeleteAlbumListToState(event);
    } else if (event is AlbumListUpdated) {
      yield* _mapAlbumListUpdatedToState(event);
    }
  }

  @override
  Future<void> close() {
    _albumsListSubscription?.cancel();
    return super.close();
  }
}


