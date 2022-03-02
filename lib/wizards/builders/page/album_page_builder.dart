import 'package:eliud_core/core/wizards/builders/page_builder.dart';
import 'package:eliud_core/core/wizards/registry/registry.dart';
import 'package:eliud_core/core/wizards/tools/documentIdentifier.dart';
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
      String uniqueId,
      this.albumComponentIdentifier,
      this.examplePhoto1AssetPath,
      this.examplePhoto2AssetPath,
      String pageId,
      AppModel app,
      String memberId,
      HomeMenuModel theHomeMenu,
      AppBarModel theAppBar,
      DrawerModel leftDrawer,
      DrawerModel rightDrawer,
      PageProvider pageProvider,
      ActionProvider actionProvider
      )
      : super(uniqueId, pageId, app, memberId, theHomeMenu, theAppBar, leftDrawer,
            rightDrawer, pageProvider, actionProvider);

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
        componentId: constructDocumentId(uniqueId: uniqueId, documentId: albumComponentIdentifier)));

    return PageModel(
        documentID: constructDocumentId(uniqueId: uniqueId, documentId: pageId),
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
    var example1 = await helper.example1();
    var example2 = await helper.example2();
    var albumModel = AlbumModel(
      documentID: constructDocumentId(uniqueId: uniqueId, documentId: albumComponentIdentifier),
      appId: app.documentID!,
      albumEntries: [
        example1,
        example2,
      ],
      description: "Example Photos",
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
    );
    print("return albumModel");
    return albumModel;
  }

  Future<AlbumModel> _setupAlbum() async {
    var _albumModel =
        await albumRepository(appId: app.documentID!)!.add(await albumModel());
    return _albumModel;
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
    var medium = await PlatformMediumHelper(app, memberId,
            PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple)
        .createThumbnailUploadPhotoAsset(
            newRandomKey(), examplePhoto1AssetPath);
    return AlbumEntryModel(
        documentID: newRandomKey(), name: 'example 1', medium: medium);
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
