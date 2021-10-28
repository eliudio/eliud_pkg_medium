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

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eliud_core/tools/firestore/firestore_tools.dart';
import 'package:flutter/cupertino.dart';

import 'package:eliud_core/tools/enums.dart';
import 'package:eliud_core/tools/common_tools.dart';

import 'package:eliud_core/model/rgb_model.dart';

import 'package:eliud_core/tools/string_validator.dart';

import 'package:eliud_core/model/repository_export.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_medium/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_medium/model/repository_export.dart';
import 'package:eliud_core/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_medium/model/model_export.dart';
import 'package:eliud_core/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_medium/model/entity_export.dart';

import 'package:eliud_pkg_medium/model/album_entry_form_event.dart';
import 'package:eliud_pkg_medium/model/album_entry_form_state.dart';
import 'package:eliud_pkg_medium/model/album_entry_repository.dart';

class AlbumEntryFormBloc extends Bloc<AlbumEntryFormEvent, AlbumEntryFormState> {
  final String? appId;

  AlbumEntryFormBloc(this.appId, ): super(AlbumEntryFormUninitialized());
  @override
  Stream<AlbumEntryFormState> mapEventToState(AlbumEntryFormEvent event) async* {
    final currentState = state;
    if (currentState is AlbumEntryFormUninitialized) {
      if (event is InitialiseNewAlbumEntryFormEvent) {
        AlbumEntryFormLoaded loaded = AlbumEntryFormLoaded(value: AlbumEntryModel(
                                               documentID: "IDENTIFIED", 
                                 name: "",

        ));
        yield loaded;
        return;

      }


      if (event is InitialiseAlbumEntryFormEvent) {
        AlbumEntryFormLoaded loaded = AlbumEntryFormLoaded(value: event.value);
        yield loaded;
        return;
      } else if (event is InitialiseAlbumEntryFormNoLoadEvent) {
        AlbumEntryFormLoaded loaded = AlbumEntryFormLoaded(value: event.value);
        yield loaded;
        return;
      }
    } else if (currentState is AlbumEntryFormInitialized) {
      AlbumEntryModel? newValue = null;
      if (event is ChangedAlbumEntryName) {
        newValue = currentState.value!.copyWith(name: event.value);
        yield SubmittableAlbumEntryForm(value: newValue);

        return;
      }
      if (event is ChangedAlbumEntryMedium) {
        if (event.value != null)
          newValue = currentState.value!.copyWith(medium: await platformMediumRepository(appId: appId)!.get(event.value));
        else
          newValue = new AlbumEntryModel(
                                 documentID: currentState.value!.documentID,
                                 name: currentState.value!.name,
                                 medium: null,
          );
        yield SubmittableAlbumEntryForm(value: newValue);

        return;
      }
    }
  }


}

