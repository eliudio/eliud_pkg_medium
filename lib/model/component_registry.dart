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
import 'package:eliud_core_model/tools/component/component_spec.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core_model/tools/component/component_constructor.dart';
import 'package:eliud_core_model/apis/apis.dart';

import 'album_component_selector.dart';
import 'package:eliud_pkg_medium/model/internal_component.dart';




/* 
 * Component registry contains a list of components
 */
class ComponentRegistry {

  /* 
   * Initialise the component registry
   */
  init(ComponentConstructor albumComponentConstructorDefault, ComponentEditorConstructor albumComponentEditorConstructor, ) {
    Apis.apis().getRegistryApi().addInternalComponents('eliud_pkg_medium', ["albums", ]);

    Apis.apis().getRegistryApi().register(componentName: "eliud_pkg_medium_internalWidgets", componentConstructor: ListComponentFactory());
    Apis.apis().getRegistryApi().addDropDownSupporter("albums", DropdownButtonComponentFactory());
    Apis.apis().getRegistryApi().register(componentName: "albums", componentConstructor: albumComponentConstructorDefault);
    Apis.apis().getRegistryApi().addComponentSpec('eliud_pkg_medium', 'medium', [
      ComponentSpec('albums', albumComponentConstructorDefault, AlbumComponentSelector(), albumComponentEditorConstructor, ({String? appId}) => albumRepository(appId: appId)! ), 
    ]);
      Apis.apis().getRegistryApi().registerRetrieveRepository('eliud_pkg_medium', 'albums', ({String? appId}) => albumRepository(appId: appId)!);
  }

}


