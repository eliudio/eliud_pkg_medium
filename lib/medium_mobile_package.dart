import 'package:eliud_pkg_medium/platform/medium_platform.dart';
import 'package:eliud_pkg_medium/platform/mobile_medium_platform.dart';

import 'medium_package.dart';

class MediumMobilePackage extends MediumPackage {
  @override
  void init() {
    super.init();
    // initialise the platform
    AbstractMediumPlatform.platform = MobileMediumPlatform();
  }

  @override
  List<Object?> get props => [
  ];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is MediumMobilePackage &&
              runtimeType == other.runtimeType;
}
