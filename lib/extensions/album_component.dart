import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/platform_medium_model.dart';
import 'package:eliud_core/style/frontend/has_container.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/component/component_constructor.dart';
import 'package:eliud_pkg_medium/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_medium/model/album_component.dart';
import 'package:eliud_pkg_medium/model/album_entry_model.dart';
import 'package:eliud_pkg_medium/model/album_model.dart';
import 'package:eliud_pkg_medium/model/album_repository.dart';
import 'package:eliud_pkg_medium/platform/medium_platform.dart';
import 'package:eliud_pkg_medium/tools/media_helper.dart';
import 'package:flutter/material.dart';

class AlbumComponentConstructorDefault implements ComponentConstructor {
  AlbumComponentConstructorDefault();

  @override
  Widget createNew(
      {Key? key, required String id, Map<String, dynamic>? parameters}) {
    return AlbumComponent(key: key, id: id);
  }

  @override
  Future<dynamic> getModel({required String appId, required String id}) async =>
      await albumRepository(appId: appId)!.get(id);
}

class AlbumComponent extends AbstractAlbumComponent {
  String? parentPageId;

  AlbumComponent({Key? key, required String id}) : super(key: key, albumID: id);

  @override
  Widget alertWidget({title = String, content = String}) {
    return AlertWidget(title: title, content: content);
  }

  @override
  Widget yourWidget(BuildContext context, AlbumModel? albumModel) {
    if (albumModel == null) {
      return text(context, "Album is not available");
    } else {
      if (albumModel.albumEntries == null) return Container();
      var mmm = albumModel.albumEntries!.map((pm) => pm.medium!).toList();
      List<PlatformMediumModel> media = mmm;
      return MediaHelper.staggeredPlatformMediumModel(context, media, viewAction: (index) {
        _action(context, albumModel.albumEntries!, index);
      });
    }
  }

  void _action(BuildContext context, List<AlbumEntryModel> memberMedia, int index) {
    var medium = memberMedia[index];
    if (medium.medium!.mediumType! == PlatformMediumType.Photo) {
      if (memberMedia.length > 0) {
        var photos = memberMedia.map((pm) => pm.medium!).toList();
        AbstractMediumPlatform.platform!.showPhotosPlatform(context, photos, index);
      }
    } else {
      AbstractMediumPlatform.platform!
          .showVideoPlatform(context, medium.medium!);
    }
  }


  @override
  AlbumRepository getAlbumRepository(BuildContext context) {
    return albumRepository(appId: AccessBloc.currentAppId(context))!;
  }
}
