import 'package:eliud_core/model/conditions_simple_model.dart';
import 'package:eliud_core/tools/storage/member_medium_helper.dart';
import 'package:eliud_core/tools/storage/medium_helper.dart';
import 'package:eliud_core/tools/storage/platform_medium_helper.dart';

abstract class AccessRights<T extends MediumHelper> {
  T getMediumHelper(String appId, String ownerId);
}

class MemberMediumAccessRights extends AccessRights<MemberMediumHelper> {
  final List<String> readAccess;

  MemberMediumAccessRights(this.readAccess);

  MemberMediumHelper getMediumHelper(String appId, String ownerId) {
    return MemberMediumHelper(appId, ownerId, readAccess);
  }
}

class PlatformMediumAccessRights extends AccessRights<PlatformMediumHelper> {
  final PrivilegeLevelRequiredSimple privilegeLevelRequired;

  PlatformMediumAccessRights(this.privilegeLevelRequired);

  PlatformMediumHelper getMediumHelper(String appId, String ownerId) {
    return PlatformMediumHelper(appId, ownerId, privilegeLevelRequired);
  }
}

