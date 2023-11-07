/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 album_entry_form_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:bloc/bloc.dart';

import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_medium/model/model_export.dart';

import 'package:eliud_pkg_medium/model/album_entry_form_event.dart';
import 'package:eliud_pkg_medium/model/album_entry_form_state.dart';

class AlbumEntryFormBloc
    extends Bloc<AlbumEntryFormEvent, AlbumEntryFormState> {
  final String? appId;

  AlbumEntryFormBloc(
    this.appId,
  ) : super(AlbumEntryFormUninitialized()) {
    on<InitialiseNewAlbumEntryFormEvent>((event, emit) {
      AlbumEntryFormLoaded loaded = AlbumEntryFormLoaded(
          value: AlbumEntryModel(
        documentID: "IDENTIFIED",
        name: "",
      ));
      emit(loaded);
    });

    on<InitialiseAlbumEntryFormEvent>((event, emit) async {
      AlbumEntryFormLoaded loaded = AlbumEntryFormLoaded(value: event.value);
      emit(loaded);
    });
    on<InitialiseAlbumEntryFormNoLoadEvent>((event, emit) async {
      AlbumEntryFormLoaded loaded = AlbumEntryFormLoaded(value: event.value);
      emit(loaded);
    });
    AlbumEntryModel? newValue;
    on<ChangedAlbumEntryName>((event, emit) async {
      if (state is AlbumEntryFormInitialized) {
        final currentState = state as AlbumEntryFormInitialized;
        newValue = currentState.value!.copyWith(name: event.value);
        emit(SubmittableAlbumEntryForm(value: newValue));
      }
    });
    on<ChangedAlbumEntryMedium>((event, emit) async {
      if (state is AlbumEntryFormInitialized) {
        final currentState = state as AlbumEntryFormInitialized;
        if (event.value != null) {
          newValue = currentState.value!.copyWith(
              medium: await platformMediumRepository(appId: appId)!
                  .get(event.value));
        }
        emit(SubmittableAlbumEntryForm(value: newValue));
      }
    });
  }
}
