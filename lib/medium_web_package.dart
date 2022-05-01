import 'package:eliud_core/core/registry.dart';
import 'package:eliud_pkg_medium/platform/medium_platform.dart';
import 'package:eliud_pkg_medium/platform/web_medium_platform.dart';

import 'medium_package.dart';

class MediumWebPackage extends MediumPackage {
  @override
  void init() {
    super.init();
    // initialise the platform
    Registry.registry()!.registerMediumApi(WebMediumPlatform());
  }

  @override
  List<Object?> get props => [
  ];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is MediumWebPackage &&
              runtimeType == other.runtimeType;
}
