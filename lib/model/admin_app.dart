/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 model/admin_app.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core_model/tools/admin_app_base.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_core_model/tools/common_tools.dart';
import 'package:eliud_core_model/tools/common_tools.dart';

import 'package:eliud_core_model/model/menu_def_model.dart';
import 'package:eliud_core_model/model/page_model.dart';
import 'package:eliud_core_model/model/app_bar_model.dart';
import 'package:eliud_core_model/model/body_component_model.dart';
import 'package:eliud_core_model/model/drawer_model.dart';
import 'package:eliud_core_model/model/menu_item_model.dart';
import 'package:eliud_core_model/model/home_menu_model.dart';

import 'package:eliud_core_model/model/repository_export.dart';
import 'package:eliud_core_model/model/abstract_repository_singleton.dart';
import 'package:eliud_core_model/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_medium/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_medium/model/repository_export.dart';
import 'package:eliud_core_model/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_medium/model/model_export.dart';
import 'package:eliud_core_model/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_medium/model/entity_export.dart';

class AdminApp extends AdminAppInstallerBase {
  final String appId;
  final DrawerModel _drawer;
  final DrawerModel _endDrawer;
  final AppBarModel _appBar;
  final HomeMenuModel _homeMenu;
  final RgbModel menuItemColor;
  final RgbModel selectedMenuItemColor;
  final RgbModel backgroundColor;
  
  /**
   * Construct the AdminApp
   */
  AdminApp(this.appId, this._drawer, this._endDrawer, this._appBar, this._homeMenu, this.menuItemColor, this.selectedMenuItemColor, this.backgroundColor);


  /**
   * Retrieve the admin pages
   */
  PageModel _albumsPages() {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
      documentID: "internalWidget-albums", componentName: "eliud_pkg_medium_internalWidgets", componentId: "albums"));
    PageModel page = PageModel(
        conditions: StorageConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.ownerPrivilegeRequiredSimple,
        ),
        appId: appId,
        documentID: "eliud_pkg_medium_albums_page",
        title: "Albums",
        description: "Albums",
        drawer: _drawer,
        endDrawer: _endDrawer,
        appBar: _appBar,
        homeMenu: _homeMenu,
        bodyComponents: components,
        layout: PageLayout.onlyTheFirstComponent
    );
    return page;
  }


  Future<void> _setupAdminPages() {

    return pageRepository(appId: appId)!.add(_albumsPages())

    ;
  }

  /**
   * Run the admin, i.e setup all admin pages
   */
  @override
  Future<void> run() async {
    return _setupAdminPages();
  }


}

class AdminMenu extends AdminAppMenuInstallerBase {

  /**
   * Construct the admin menu
   */
  Future<MenuDefModel> menu(AppModel app) async {
    var menuItems = <MenuItemModel>[];

    menuItems.add(
      MenuItemModel(
        documentID: "Albums",
        text: "Albums",
        description: "Albums",
        icon: IconModel(codePoint: 0xe88a, fontFamily: "MaterialIcons"),
        action: GotoPage(app, pageID: "eliud_pkg_medium_albums_page"))
    );


    MenuDefModel menu = MenuDefModel(
      admin: true,
      documentID: "eliud_pkg_medium_admin_menu",
      appId: app.documentID,
      name: "eliud_pkg_medium",
      menuItems: menuItems
    );
    await menuDefRepository(appId: app.documentID)!.add(menu);
    return menu;
  }
}

class AdminAppWiper extends AdminAppWiperBase {

  /**
   * Delete all admin pages
   */
  @override
  Future<void> deleteAll(String appID) async {
    ;
  }


}

