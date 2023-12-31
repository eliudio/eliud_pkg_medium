import 'package:eliud_core_helpers/etc/random.dart';
import 'package:eliud_core_main/editor/ext_editor_base_bloc/ext_editor_base_bloc.dart';
import 'package:eliud_core_main/model/background_model.dart';
import 'package:eliud_core_main/model/storage_conditions_model.dart';
import 'package:eliud_core_main/apis/registryapi/component/component_spec.dart';

import 'package:eliud_pkg_medium_model/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_medium_model/model/album_entity.dart';
import 'package:eliud_pkg_medium_model/model/album_entry_model.dart';
import 'package:eliud_pkg_medium_model/model/album_model.dart';

class AlbumBloc
    extends ExtEditorBaseBloc<AlbumModel, AlbumEntryModel, AlbumEntity> {
  AlbumBloc(String appId, EditorFeedback feedback)
      : super(appId, albumRepository(appId: appId)!, feedback);

  @override
  AlbumModel addItem(AlbumModel model, AlbumEntryModel newItem) {
    List<AlbumEntryModel> newItems =
        model.albumEntries == null ? [] : model.albumEntries!;
    newItems.add(newItem);
    var newModel = model.copyWith(albumEntries: newItems);
    return newModel;
  }

  @override
  AlbumModel deleteItem(AlbumModel model, AlbumEntryModel deleteItem) {
    var newItems = <AlbumEntryModel>[];
    if (model.albumEntries != null) {
      for (var item in model.albumEntries!) {
        if (item != deleteItem) {
          newItems.add(item);
        }
      }
    }
    var newModel = model.copyWith(albumEntries: newItems);
    return newModel;
  }

  @override
  AlbumModel newInstance(StorageConditionsModel conditions) {
    return AlbumModel(
      appId: appId,
      documentID: newRandomKey(),
      backgroundImage: BackgroundModel(),
      description: 'new album',
      conditions: conditions,
    );
  }

  @override
  AlbumModel setDefaultValues(AlbumModel t, StorageConditionsModel conditions) {
    return t.copyWith(
        backgroundImage: t.backgroundImage ?? BackgroundModel(),
        conditions: t.conditions ?? conditions);
  }

  @override
  AlbumModel updateItem(
      AlbumModel model, AlbumEntryModel oldItem, AlbumEntryModel newItem) {
    List<AlbumEntryModel> currentItems =
        model.albumEntries == null ? [] : model.albumEntries!;
    var index = currentItems.indexOf(oldItem);
    if (index != -1) {
      var newItems = currentItems.map((e) => e).toList();
      newItems[index] = newItem;
      var newModel = model.copyWith(albumEntries: newItems);
      return newModel;
    } else {
      throw Exception("Could not find $oldItem");
    }
  }

  @override
  List<AlbumEntryModel> copyOf(List<AlbumEntryModel> ts) {
    return ts.map((t) => t).toList();
  }
}
