import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/navigate/navigate_bloc.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/package/package.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:eliud_core/model/access_model.dart';

import 'model/abstract_repository_singleton.dart';
import 'model/component_registry.dart';
import 'model/repository_singleton.dart';

abstract class MediumPackage extends Package {
  MediumPackage() : super('eliud_pkg_medium');

  @override
  Future<bool?> isConditionOk(String packageCondition, AppModel app, MemberModel? member, bool isOwner, bool? isBlocked, PrivilegeLevel? privilegeLevel) async => null;

  @override
  List<String>? retrieveAllPackageConditions() => null;

  @override
  void init() {
    ComponentRegistry().init();

    AbstractRepositorySingleton.singleton = RepositorySingleton();
  }

  @override
  List<MemberCollectionInfo> getMemberCollectionInfo() => [];
}
