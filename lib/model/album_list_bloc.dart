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

import 'package:eliud_pkg_medium/model/album_repository.dart';
import 'package:eliud_pkg_medium/model/album_list_event.dart';
import 'package:eliud_pkg_medium/model/album_list_state.dart';
import 'package:eliud_core/tools/query/query_tools.dart';

import 'album_model.dart';

typedef FilterAlbumModels = List<AlbumModel?> Function(
    List<AlbumModel?> values);

class AlbumListBloc extends Bloc<AlbumListEvent, AlbumListState> {
  final FilterAlbumModels? filter;
  final AlbumRepository _albumRepository;
  StreamSubscription? _albumsListSubscription;
  EliudQuery? eliudQuery;
  int pages = 1;
  final bool? paged;
  final String? orderBy;
  final bool? descending;
  final bool? detailed;
  final int albumLimit;

  AlbumListBloc(
      {this.filter,
      this.paged,
      this.orderBy,
      this.descending,
      this.detailed,
      this.eliudQuery,
      required AlbumRepository albumRepository,
      this.albumLimit = 5})
      : _albumRepository = albumRepository,
        super(AlbumListLoading()) {
    on<LoadAlbumList>((event, emit) {
      if ((detailed == null) || (!detailed!)) {
        _mapLoadAlbumListToState();
      } else {
        _mapLoadAlbumListWithDetailsToState();
      }
    });

    on<NewPage>((event, emit) {
      pages = pages +
          1; // it doesn't matter so much if we increase pages beyond the end
      _mapLoadAlbumListWithDetailsToState();
    });

    on<AlbumChangeQuery>((event, emit) {
      eliudQuery = event.newQuery;
      if ((detailed == null) || (!detailed!)) {
        _mapLoadAlbumListToState();
      } else {
        _mapLoadAlbumListWithDetailsToState();
      }
    });

    on<AddAlbumList>((event, emit) async {
      await _mapAddAlbumListToState(event);
    });

    on<UpdateAlbumList>((event, emit) async {
      await _mapUpdateAlbumListToState(event);
    });

    on<DeleteAlbumList>((event, emit) async {
      await _mapDeleteAlbumListToState(event);
    });

    on<AlbumListUpdated>((event, emit) {
      emit(_mapAlbumListUpdatedToState(event));
    });
  }

  List<AlbumModel?> _filter(List<AlbumModel?> original) {
    if (filter != null) {
      return filter!(original);
    } else {
      return original;
    }
  }

  Future<void> _mapLoadAlbumListToState() async {
    int amountNow = (state is AlbumListLoaded)
        ? (state as AlbumListLoaded).values!.length
        : 0;
    _albumsListSubscription?.cancel();
    _albumsListSubscription = _albumRepository.listen(
        (list) => add(AlbumListUpdated(
            value: _filter(list), mightHaveMore: amountNow != list.length)),
        orderBy: orderBy,
        descending: descending,
        eliudQuery: eliudQuery,
        limit: ((paged != null) && paged!) ? pages * albumLimit : null);
  }

  Future<void> _mapLoadAlbumListWithDetailsToState() async {
    int amountNow = (state is AlbumListLoaded)
        ? (state as AlbumListLoaded).values!.length
        : 0;
    _albumsListSubscription?.cancel();
    _albumsListSubscription = _albumRepository.listenWithDetails(
        (list) => add(AlbumListUpdated(
            value: _filter(list), mightHaveMore: amountNow != list.length)),
        orderBy: orderBy,
        descending: descending,
        eliudQuery: eliudQuery,
        limit: ((paged != null) && paged!) ? pages * albumLimit : null);
  }

  Future<void> _mapAddAlbumListToState(AddAlbumList event) async {
    var value = event.value;
    if (value != null) {
      await _albumRepository.add(value);
    }
  }

  Future<void> _mapUpdateAlbumListToState(UpdateAlbumList event) async {
    var value = event.value;
    if (value != null) {
      await _albumRepository.update(value);
    }
  }

  Future<void> _mapDeleteAlbumListToState(DeleteAlbumList event) async {
    var value = event.value;
    if (value != null) {
      await _albumRepository.delete(value);
    }
  }

  AlbumListLoaded _mapAlbumListUpdatedToState(AlbumListUpdated event) =>
      AlbumListLoaded(values: event.value, mightHaveMore: event.mightHaveMore);

  @override
  Future<void> close() {
    _albumsListSubscription?.cancel();
    return super.close();
  }
}
