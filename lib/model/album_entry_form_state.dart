/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 album_entry_form_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'album_entry_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AlbumEntryFormState extends Equatable {
  const AlbumEntryFormState();

  @override
  List<Object?> get props => [];
}

// Startup: menu has not been initialised yet and so we should show a "loading indicator" or something
class AlbumEntryFormUninitialized extends AlbumEntryFormState {
  @override
  List<Object?> get props => [];

  @override
  String toString() {
    return '''AlbumEntryFormState()''';
  }
}

// AlbumEntryModel has been initialised and hence AlbumEntryModel is available
class AlbumEntryFormInitialized extends AlbumEntryFormState {
  final AlbumEntryModel? value;

  @override
  List<Object?> get props => [value];

  const AlbumEntryFormInitialized({this.value});
}

// Menu has been initialised and hence a menu is available
abstract class AlbumEntryFormError extends AlbumEntryFormInitialized {
  final String? message;

  @override
  List<Object?> get props => [message, value];

  const AlbumEntryFormError({this.message, super.value});

  @override
  String toString() {
    return '''AlbumEntryFormError {
      value: $value,
      message: $message,
    }''';
  }
}

class DocumentIDAlbumEntryFormError extends AlbumEntryFormError {
  const DocumentIDAlbumEntryFormError({super.message, super.value});

  @override
  List<Object?> get props => [message, value];

  @override
  String toString() {
    return '''DocumentIDAlbumEntryFormError {
      value: $value,
      message: $message,
    }''';
  }
}

class NameAlbumEntryFormError extends AlbumEntryFormError {
  const NameAlbumEntryFormError({super.message, super.value});

  @override
  List<Object?> get props => [message, value];

  @override
  String toString() {
    return '''NameAlbumEntryFormError {
      value: $value,
      message: $message,
    }''';
  }
}

class MediumAlbumEntryFormError extends AlbumEntryFormError {
  const MediumAlbumEntryFormError({super.message, super.value});

  @override
  List<Object?> get props => [message, value];

  @override
  String toString() {
    return '''MediumAlbumEntryFormError {
      value: $value,
      message: $message,
    }''';
  }
}

class AlbumEntryFormLoaded extends AlbumEntryFormInitialized {
  const AlbumEntryFormLoaded({super.value});

  @override
  List<Object?> get props => [value];

  @override
  String toString() {
    return '''AlbumEntryFormLoaded {
      value: $value,
    }''';
  }
}

class SubmittableAlbumEntryForm extends AlbumEntryFormInitialized {
  const SubmittableAlbumEntryForm({super.value});

  @override
  List<Object?> get props => [value];

  @override
  String toString() {
    return '''SubmittableAlbumEntryForm {
      value: $value,
    }''';
  }
}
