import 'package:eliud_core/core/wizards/builders/page_builder.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart'
    as corerepo;
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/tools/storage/platform_medium_helper.dart';
import 'package:eliud_pkg_medium/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_medium/model/album_component.dart';
import 'package:eliud_pkg_medium/model/album_entry_model.dart';
import 'package:eliud_pkg_medium/model/album_model.dart';

class AlbumPageBuilder extends PageBuilder {
  final String examplePhoto1AssetPath;
  final String examplePhoto2AssetPath;
  final String albumComponentIdentifier;

  AlbumPageBuilder(
      this.albumComponentIdentifier,
      this.examplePhoto1AssetPath,
      this.examplePhoto2AssetPath,
      String pageId,
      AppModel app,
      String memberId,
      HomeMenuModel theHomeMenu,
      AppBarModel theAppBar,
      DrawerModel leftDrawer,
      DrawerModel rightDrawer)
      : super(pageId, app, memberId, theHomeMenu, theAppBar, leftDrawer,
            rightDrawer);

  Future<PageModel> _setupPage() async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .pageRepository(app.documentID!)!
        .add(_page());
  }

  PageModel _page() {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1",
        componentName: AbstractAlbumComponent.componentName,
        componentId: albumComponentIdentifier));

    return PageModel(
        documentID: pageId,
        appId: app.documentID!,
        title: "Album",
        drawer: leftDrawer,
        endDrawer: rightDrawer,
        appBar: theAppBar,
        homeMenu: theHomeMenu,
        layout: PageLayout.ListView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.Level1PrivilegeRequiredSimple,
        ),
        bodyComponents: components);
  }

  Future<AlbumModel> albumModel() async {
    var helper = ExampleAlbumHelper(
        app: app,
        memberId: memberId,
        examplePhoto1AssetPath: examplePhoto1AssetPath,
        examplePhoto2AssetPath: examplePhoto2AssetPath);
    return AlbumModel(
      documentID: albumComponentIdentifier,
      appId: app.documentID!,
      albumEntries: [
        await helper.example1(),
        await helper.example2(),
      ],
      description: "Example Photos",
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
    );
  }

  Future<AlbumModel> _setupAlbum() async {
    return await albumRepository(appId: app.documentID!)!.add(await albumModel());
  }

  Future<PageModel> create() async {
    await _setupAlbum();
    return await _setupPage();
  }
}

class ExampleAlbumHelper {
  final AppModel app;
  final String memberId;
  final String examplePhoto1AssetPath;
  final String examplePhoto2AssetPath;

  ExampleAlbumHelper({
    required this.app,
    required this.memberId,
    required this.examplePhoto1AssetPath,
    required this.examplePhoto2AssetPath,
  });

  Future<AlbumEntryModel> example1() async {
    return AlbumEntryModel(
        documentID: newRandomKey(),
        name: 'example 1',
        medium: await PlatformMediumHelper(app, memberId,
                PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple)
            .createThumbnailUploadPhotoAsset(
                newRandomKey(), examplePhoto1AssetPath));
  }

  Future<AlbumEntryModel> example2() async {
    return AlbumEntryModel(
        documentID: newRandomKey(),
        name: 'example 2',
        medium: await PlatformMediumHelper(app, memberId,
                PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple)
            .createThumbnailUploadPhotoAsset(
                newRandomKey(), examplePhoto2AssetPath));
  }
}
