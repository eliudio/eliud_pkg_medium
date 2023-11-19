/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 album_form_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'album_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AlbumFormState extends Equatable {
  const AlbumFormState();

  @override
  List<Object?> get props => [];
}

// Startup: menu has not been initialised yet and so we should show a "loading indicator" or something
class AlbumFormUninitialized extends AlbumFormState {
  @override
  List<Object?> get props => [];

  @override
  String toString() {
    return '''AlbumFormState()''';
  }
}

// AlbumModel has been initialised and hence AlbumModel is available
class AlbumFormInitialized extends AlbumFormState {
  final AlbumModel? value;

  @override
  List<Object?> get props => [ value ];

  const AlbumFormInitialized({ this.value });
}

// Menu has been initialised and hence a menu is available
abstract class AlbumFormError extends AlbumFormInitialized {
  final String? message;

  @override
  List<Object?> get props => [ message, value ];

  const AlbumFormError({this.message, AlbumModel? value }) : super(value: value);

  @override
  String toString() {
    return '''AlbumFormError {
      value: $value,
      message: $message,
    }''';
  }
}
class DocumentIDAlbumFormError extends AlbumFormError { 
  const DocumentIDAlbumFormError({ String? message, AlbumModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''DocumentIDAlbumFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class AppIdAlbumFormError extends AlbumFormError { 
  const AppIdAlbumFormError({ String? message, AlbumModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''AppIdAlbumFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class AlbumEntriesAlbumFormError extends AlbumFormError { 
  const AlbumEntriesAlbumFormError({ String? message, AlbumModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''AlbumEntriesAlbumFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class DescriptionAlbumFormError extends AlbumFormError { 
  const DescriptionAlbumFormError({ String? message, AlbumModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''DescriptionAlbumFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class BackgroundImageAlbumFormError extends AlbumFormError { 
  const BackgroundImageAlbumFormError({ String? message, AlbumModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''BackgroundImageAlbumFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class ConditionsAlbumFormError extends AlbumFormError { 
  const ConditionsAlbumFormError({ String? message, AlbumModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''ConditionsAlbumFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class AlbumFormLoaded extends AlbumFormInitialized { 
  const AlbumFormLoaded({ AlbumModel? value }): super(value: value);

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() {
    return '''AlbumFormLoaded {
      value: $value,
    }''';
  }
}


class SubmittableAlbumForm extends AlbumFormInitialized { 
  const SubmittableAlbumForm({ AlbumModel? value }): super(value: value);

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() {
    return '''SubmittableAlbumForm {
      value: $value,
    }''';
  }
}


