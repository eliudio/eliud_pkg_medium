import 'package:eliud_core_main/apis/apis.dart';
import 'package:eliud_pkg_medium/platform/web_medium_platform.dart';

import 'medium_package.dart';

MediumPackage getMediumPackage() => MediumWebPackage();

class MediumWebPackage extends MediumPackage {
  @override
  void init() {
    super.init();
    // initialise the platform
    Apis.apis().registerMediumApi(WebMediumPlatform());
  }

  @override
  List<Object?> get props => [];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MediumWebPackage && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}
