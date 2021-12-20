/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 model/component_registry.dart
                       
 This code is generated. This is read only. Don't touch!

*/


import '../model/internal_component.dart';
import 'package:eliud_core/core/registry.dart';
import 'package:eliud_core/tools/component/component_spec.dart';

import '../extensions/album_component.dart';
import '../editors/album_component_editor.dart';
import 'album_component_selector.dart';
import 'package:eliud_pkg_medium/model/internal_component.dart';




class ComponentRegistry {

  void init() {
    Registry.registry()!.addInternalComponents('eliud_pkg_medium', ["albums", ]);

    Registry.registry()!.register(componentName: "eliud_pkg_medium_internalWidgets", componentConstructor: ListComponentFactory());
    Registry.registry()!.addDropDownSupporter("albums", DropdownButtonComponentFactory());
    Registry.registry()!.register(componentName: "albums", componentConstructor: AlbumComponentConstructorDefault());
    Registry.registry()!.addComponentSpec('eliud_pkg_medium', [
      ComponentSpec('albums', AlbumComponentConstructorDefault(), AlbumComponentSelector(), AlbumComponentEditorConstructor(), ), 
    ]);

  }
}

