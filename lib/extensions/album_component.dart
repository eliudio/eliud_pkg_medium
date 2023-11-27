import 'package:eliud_core_main/apis/apis.dart';
import 'package:eliud_core_main/apis/registryapi/component/component_constructor.dart';
import 'package:eliud_core_main/model/app_model.dart';
import 'package:eliud_core_main/model/platform_medium_model.dart';
import 'package:eliud_core_main/apis/style/frontend/has_text.dart';
import 'package:eliud_pkg_medium_model/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_medium_model/model/album_component.dart';
import 'package:eliud_pkg_medium_model/model/album_entry_model.dart';
import 'package:eliud_pkg_medium_model/model/album_model.dart';
import 'package:eliud_pkg_medium/tools/media_helper.dart';
import 'package:flutter/material.dart';

class AlbumComponentConstructorDefault implements ComponentConstructor {
  AlbumComponentConstructorDefault();

  @override
  Widget createNew(
      {Key? key,
      required AppModel app,
      required String id,
      Map<String, dynamic>? parameters}) {
    return AlbumComponent(key: key, app: app, id: id);
  }

  @override
  Future<dynamic> getModel({required AppModel app, required String id}) async =>
      await albumRepository(appId: app.documentID)!.get(id);
}

class AlbumComponent extends AbstractAlbumComponent {
  AlbumComponent({super.key, required super.app, required String id})
      : super(albumId: id);

  @override
  Widget yourWidget(BuildContext context, AlbumModel? value) {
    if (value == null) {
      return text(app, context, "Album is not available");
    } else {
      if (value.albumEntries == null) return Container();
      List<PlatformMediumModel> mmm = [];
      for (var medium in value.albumEntries!) {
        if (medium.medium != null) {
          mmm.add(medium.medium!);
        }
      }

      List<PlatformMediumModel> media = mmm;
      return MediaHelper.staggeredPlatformMediumModel(app, context, media,
          background: value.backgroundImage, viewAction: (index) {
        _action(context, value.albumEntries!, index);
      });
    }
  }

  void _action(
      BuildContext context, List<AlbumEntryModel> memberMedia, int index) {
    var medium = memberMedia[index];
    if (medium.medium!.mediumType! == PlatformMediumType.photo) {
      if (memberMedia.isNotEmpty) {
        var photos = memberMedia.map((pm) => pm.medium!).toList();
        Apis.apis()
            .getMediumApi()
            .showPhotosPlatform(context, app, photos, index);
      }
    } else {
      Apis.apis()
          .getMediumApi()
          .showVideoPlatform(context, app, medium.medium!);
    }
  }
}
