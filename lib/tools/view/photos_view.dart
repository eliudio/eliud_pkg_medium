import 'package:eliud_core/style/style_registry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PhotoView extends StatelessWidget {
  const PhotoView.extent(
      {@required this.maxCrossAxisExtent,
        @required this.tiles,
        this.mainAxisSpacing: 4.0,
        this.crossAxisSpacing: 4.0,
        this.widgets})
      : crossAxisCount = null;

  static const EdgeInsetsGeometry padding =
  const EdgeInsets.symmetric(horizontal: 4.0);

  final List<StaggeredTile>? tiles;
  final int? crossAxisCount;
  final double? mainAxisSpacing;
  final double? crossAxisSpacing;
  final double? maxCrossAxisExtent;
  final List<Widget>? widgets;

  @override
  Widget build(BuildContext context) {
    if (maxCrossAxisExtent == null) StyleRegistry.registry().styleWithContext(context).frontEndStyle().textStyle().text(context, 'maxCrossAxisExtent is null');
    if (tiles == null) return StyleRegistry.registry().styleWithContext(context).frontEndStyle().textStyle().text(context, 'tiles is null');
    return StaggeredGridView.extentBuilder(
      primary: false,
      maxCrossAxisExtent: maxCrossAxisExtent!,
      itemCount: tiles!.length,
      itemBuilder: _getChild,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      padding: padding,
      staggeredTileBuilder: _getStaggeredTile,
    );
  }

  StaggeredTile _getStaggeredTile(int i) {
    var tile = i >= tiles!.length ? null : tiles![i];
    return tile!;
  }

  Widget _getChild(BuildContext context, int i) {
    var widget = i >= widgets!.length ? null : widgets![i];
    if (widget == null) return StyleRegistry.registry().styleWithContext(context).frontEndStyle().textStyle().text(context, 'No child');
    return widget;
  }
}
