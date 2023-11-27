import 'package:eliud_core_main/model/app_bar_model.dart';
import 'package:eliud_core_main/model/body_component_model.dart';
import 'package:eliud_core_main/model/drawer_model.dart';
import 'package:eliud_core_main/model/home_menu_model.dart';
import 'package:eliud_core_main/wizards/tools/document_identifier.dart';
import 'package:eliud_core_main/model/abstract_repository_singleton.dart'
    as mainrepo;
import 'package:eliud_core_main/model/app_model.dart';
import 'package:eliud_core_main/model/page_model.dart';
import 'package:eliud_core_main/model/storage_conditions_model.dart';
import 'package:eliud_core_helpers/etc/random.dart';
import 'package:eliud_core_main/storage/platform_medium_helper.dart';
import 'package:eliud_core_main/wizards/builders/page_builder.dart';
import 'package:eliud_pkg_medium_model/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_medium_model/model/album_component.dart';
import 'package:eliud_pkg_medium_model/model/album_entry_model.dart';
import 'package:eliud_pkg_medium_model/model/album_model.dart';

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
  ) : super(
          uniqueId,
          pageId,
          app,
          memberId,
          theHomeMenu,
          theAppBar,
          leftDrawer,
          rightDrawer,
        );

  Future<PageModel> _setupPage() async {
    return await mainrepo.AbstractRepositorySingleton.singleton
        .pageRepository(app.documentID)!
        .add(_page());
  }

  PageModel _page() {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1",
        componentName: AbstractAlbumComponent.componentName,
        componentId: constructDocumentId(
            uniqueId: uniqueId, documentId: albumComponentIdentifier)));

    return PageModel(
        documentID: constructDocumentId(uniqueId: uniqueId, documentId: pageId),
        appId: app.documentID,
        title: "Album",
        description: "Album",
        drawer: leftDrawer,
        endDrawer: rightDrawer,
        appBar: theAppBar,
        homeMenu: theHomeMenu,
        layout: PageLayout.listView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.level1PrivilegeRequiredSimple,
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
      documentID: constructDocumentId(
          uniqueId: uniqueId, documentId: albumComponentIdentifier),
      appId: app.documentID,
      albumEntries: [
        example1,
        example2,
      ],
      description: "Example Photos",
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
    );
    print("return albumModel");
    return albumModel;
  }

  Future<AlbumModel> _setupAlbum() async {
    var theAlbumModel =
        await albumRepository(appId: app.documentID)!.add(await albumModel());
    return theAlbumModel;
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
            PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple)
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
                PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple)
            .createThumbnailUploadPhotoAsset(
                newRandomKey(), examplePhoto2AssetPath));
  }
}
