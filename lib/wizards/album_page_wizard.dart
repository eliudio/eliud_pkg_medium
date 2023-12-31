import 'package:eliud_core_main/apis/action_api/action_model.dart';
import 'package:eliud_core_main/apis/apis.dart';
import 'package:eliud_core_main/apis/wizard_api/action_specification_parameters_base.dart';
import 'package:eliud_core_main/apis/wizard_api/new_app_wizard_info.dart';
import 'package:eliud_core_main/apis/wizard_api/new_app_wizard_info_with_action_specification.dart';
import 'package:eliud_core_main/model/app_model.dart';
import 'package:eliud_core_main/model/member_model.dart';
import 'package:eliud_core_main/model/menu_item_model.dart';
import 'package:eliud_core_main/model/public_medium_model.dart';
import 'package:eliud_core_main/wizards/helpers/menu_helpers.dart';
import 'package:flutter/material.dart';
import 'builders/page/album_page_builder.dart';

class AlbumPageWizard extends NewAppWizardInfoWithActionSpecification {
  static String albumComponentIdentifier = "album";
  static String albumExample1PhotoAssetPath =
      'packages/eliud_pkg_medium/assets/example_photo_1.jpg';
  static String albumExample2PhotoAssetPath =
      'packages/eliud_pkg_medium/assets/example_photo_2.jpg';
  static String albumPageId = 'album';

  AlbumPageWizard() : super('album', 'Album', 'Generate a default Album');

  @override
  String getPackageName() => "eliud_pkg_medium";

  static bool hasAccessToLocalFileSystem =
      Apis.apis().getMediumApi().hasAccessToLocalFilesystem();

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
  List<MenuItemModel>? getThoseMenuItems(String uniqueId, AppModel app) =>
      [menuItem(uniqueId, app, albumPageId, 'Album', Icons.album)];

  @override
  List<NewAppTask>? getCreateTasks(
    String uniqueId,
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
        var memberId = member.documentID;
        List<NewAppTask> tasks = [];
        tasks.add(() async {
          print("Album page");
          await AlbumPageBuilder(
            uniqueId,
            albumComponentIdentifier,
            albumExample1PhotoAssetPath,
            albumExample2PhotoAssetPath,
            albumPageId,
            app,
            memberId,
            homeMenuProvider(),
            appBarProvider(),
            leftDrawerProvider(),
            rightDrawerProvider(),
          ).create();
        });
        return tasks;
      }
    } else {
      throw Exception('Unexpected class for parameters: $parameters');
    }
    return null;
  }

  @override
  AppModel updateApp(
    String uniqueId,
    NewAppWizardParameters parameters,
    AppModel adjustMe,
  ) =>
      adjustMe;

  @override
  String? getPageID(String uniqueId, NewAppWizardParameters parameters,
          String pageType) =>
      null;

  @override
  ActionModel? getAction(
    String uniqueId,
    NewAppWizardParameters parameters,
    AppModel app,
    String actionType,
  ) =>
      null;

  @override
  PublicMediumModel? getPublicMediumModel(String uniqueId,
          NewAppWizardParameters parameters, String mediumType) =>
      null;
}
