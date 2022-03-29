
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/style/frontend/has_container.dart';
import 'package:eliud_core/style/frontend/has_list_tile.dart';
import 'package:flutter/material.dart';

typedef GradientPositionChanged(int? value);

class GradientPositionWidget extends StatefulWidget {
  final AppModel app;
  final int value;
  final int groupValue;
  final String label;
  final GradientPositionChanged gradientPositionChanged;

  GradientPositionWidget({
    Key? key,
    required this.app,
    required this.label,
    required this.groupValue,
    required this.value,
    required this.gradientPositionChanged,
  }) : super(key: key);

  @override
  _GradientPositionState createState() => _GradientPositionState();
}

class _GradientPositionState extends State<GradientPositionWidget> {
  @override
  Widget build(BuildContext context) {
    return topicContainer(widget.app, context,
      title: widget.label,
      collapsible: true,
      collapsed: true,
      children: [
        radioListTile(widget.app, context, 0, widget.value, 'Top Left',
            'TopLeft', widget.gradientPositionChanged),
        radioListTile(widget.app, context, 1, widget.value, 'Top Center',
            'TopCenter', widget.gradientPositionChanged),
        radioListTile(widget.app, context, 2, widget.value, 'Top Right',
            'TopRight', widget.gradientPositionChanged),
        radioListTile(widget.app, context, 3, widget.value, 'Center Left',
            'CenterLeft', widget.gradientPositionChanged),
        radioListTile(widget.app, context, 4, widget.value, 'Center', 'Center',
            widget.gradientPositionChanged),
        radioListTile(widget.app, context, 5, widget.value, 'Center Right',
            'CenterRight', widget.gradientPositionChanged),
        radioListTile(widget.app, context, 6, widget.value, 'Bottom Left',
            'BottomLeft', widget.gradientPositionChanged),
        radioListTile(widget.app, context, 7, widget.value, 'Bottom Center',
            'BottomCenter', widget.gradientPositionChanged),
        radioListTile(widget.app, context, 8, widget.value, 'Bottom Right',
            'BottomRight', widget.gradientPositionChanged),
      ],
    );
  }
}
