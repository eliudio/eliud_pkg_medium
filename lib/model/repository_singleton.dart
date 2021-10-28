/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 model/repository_singleton.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'dart:collection';
import '../model/album_firestore.dart';
import '../model/album_repository.dart';
import '../model/album_cache.dart';
import '../model/album_entry_repository.dart';
import '../model/album_entry_cache.dart';

import '../model/album_entry_model.dart';

class RepositorySingleton extends AbstractRepositorySingleton {
    var _albumRepository = HashMap<String, AlbumRepository>();

    AlbumRepository? albumRepository(String? appId) {
      if ((appId != null) && (_albumRepository[appId] == null)) _albumRepository[appId] = AlbumCache(AlbumFirestore(appRepository()!.getSubCollection(appId, 'album'), appId));
      return _albumRepository[appId];
    }

}
