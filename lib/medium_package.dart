import 'package:eliud_core/access/access_bloc.dart';
import 'package:eliud_core/core_package.dart';
import 'package:eliud_core/eliud.dart';
import 'package:eliud_core/package/package.dart';
import 'package:eliud_core_main/apis/apis.dart';
import 'package:eliud_pkg_medium_model/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_medium_model/model/component_registry.dart';
import 'package:eliud_pkg_medium_model/model/repository_singleton.dart';
import 'package:eliud_core_main/tools/etc/member_collection_info.dart';
import 'package:eliud_core_model/model/access_model.dart';
import 'package:eliud_core_main/model/app_model.dart';
import 'package:eliud_core_main/model/member_model.dart';
import 'package:eliud_pkg_medium/wizards/album_page_wizard.dart';
import 'editors/album_component_editor.dart';
import 'extensions/album_component.dart';

import 'package:eliud_pkg_medium/medium_package_stub.dart'
    if (dart.library.io) 'medium_mobile_package.dart'
    if (dart.library.html) 'medium_web_package.dart';

abstract class MediumPackage extends Package {
  MediumPackage() : super('eliud_pkg_medium');

  @override
  Future<List<PackageConditionDetails>>? getAndSubscribe(
          AccessBloc accessBloc,
          AppModel app,
          MemberModel? member,
          bool isOwner,
          bool? isBlocked,
          PrivilegeLevel? privilegeLevel) =>
      null;

  @override
  List<String>? retrieveAllPackageConditions() => null;

  @override
  void init() {
    ComponentRegistry().init(
        AlbumComponentConstructorDefault(), AlbumComponentEditorConstructor());

    // Wizard
    Apis.apis().getWizardApi().register(AlbumPageWizard());

    AbstractRepositorySingleton.singleton = RepositorySingleton();
  }

  @override
  List<MemberCollectionInfo> getMemberCollectionInfo() => [];

  static MediumPackage instance() => getMediumPackage();

  /*
   * Register depending packages
   */
  @override
  void registerDependencies(Eliud eliud) {
    eliud.registerPackage(CorePackage.instance());
  }
}
