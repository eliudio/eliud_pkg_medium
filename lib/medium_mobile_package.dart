import 'package:eliud_core_model/apis/apis.dart';
import 'package:eliud_pkg_medium/platform/mobile_medium_platform.dart';

import 'medium_package.dart';

MediumPackage getMediumPackage() => MediumMobilePackage();

class MediumMobilePackage extends MediumPackage {
  @override
  void init() {
    super.init();
    Apis.apis().registerMediumApi(MobileMediumPlatform());
  }

  @override
  List<Object?> get props => [];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MediumMobilePackage && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}
