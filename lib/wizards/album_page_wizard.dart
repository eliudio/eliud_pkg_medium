import 'package:eliud_core/core/wizards/registry/new_app_wizard_info_with_action_specification.dart';
import 'package:eliud_core/core/wizards/registry/registry.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/model/menu_item_model.dart';
import 'package:eliud_core/wizards/helpers/menu_helpers.dart';
import 'package:eliud_pkg_medium/platform/medium_platform.dart';
import 'package:eliud_pkg_medium/tools/bespoke_models.dart';
import 'package:flutter/material.dart';
import 'builders/page/album_page_builder.dart';

class AlbumPageWizard extends NewAppWizardInfoWithActionSpecification {
  static String ALBUM_COMPONENT_IDENTIFIER = "album";
  static String ALBUM_EXAMPLE1_PHOTO_ASSET_PATH =
      'packages/eliud_pkg_medium/assets/example_photo_1.jpg';
  static String ALBUM_EXAMPLE2_PHOTO_ASSET_PATH =
      'packages/eliud_pkg_medium/assets/example_photo_2.jpg';
  static String ALBUM_PAGE_ID = 'album';

  AlbumPageWizard() : super('album', 'Album', 'Generate Album');

  static bool hasAccessToLocalFileSystem =
      AbstractMediumPlatform.platform!.hasAccessToLocalFilesystem();

  @override
  NewAppWizardParameters newAppWizardParameters() =>
      ActionSpecificationParametersBase(
        requiresAccessToLocalFileSystem: false,
        availableInLeftDrawer: false,
        availableInRightDrawer: false,
        availableInAppBar: false,
        availableInHomeMenu: true,
        available: false,
      );

  @override
  List<MenuItemModel>? getThoseMenuItems(AppModel app) =>[
      menuItem(app, ALBUM_PAGE_ID, 'Album', Icons.album)];

  @override
  List<NewAppTask>? getCreateTasks(
    AppModel app,
    NewAppWizardParameters parameters,
    MemberModel member,
    HomeMenuProvider homeMenuProvider,
    AppBarProvider appBarProvider,
    DrawerProvider leftDrawerProvider,
    DrawerProvider rightDrawerProvider,
  ) {
    if (parameters is ActionSpecificationParametersBase) {
      var albumPageSpecifications = parameters.actionSpecifications;
      if (albumPageSpecifications.shouldCreatePageDialogOrWorkflow()) {
        var memberId = member.documentID!;
        List<NewAppTask> tasks = [];
        tasks.add(() async {
          print("Album page");
          await AlbumPageBuilder(
                  ALBUM_COMPONENT_IDENTIFIER,
                  ALBUM_EXAMPLE1_PHOTO_ASSET_PATH,
                  ALBUM_EXAMPLE2_PHOTO_ASSET_PATH,
                  ALBUM_PAGE_ID,
                  app,
                  memberId,
                  homeMenuProvider(),
                  appBarProvider(),
                  leftDrawerProvider(),
                  rightDrawerProvider())
              .create();
        });
        return tasks;
      }
    } else {
      throw Exception(
          'Unexpected class for parameters: ' + parameters.toString());
    }
  }

  @override
  AppModel updateApp(
    NewAppWizardParameters parameters,
    AppModel adjustMe,
  ) =>
      adjustMe;

  @override
  String? getPageID(String pageType) => null;

  @override
  ActionModel? getAction(AppModel app, String actionType, ) => null;
}
