import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_core/model/decoration_color_model.dart';
import 'package:eliud_core/style/frontend/has_container.dart';
import 'package:eliud_core/style/frontend/has_list_tile.dart';
import 'package:flutter/material.dart';

import 'background_widgets/decoration_color_list_widget.dart';
import 'background_widgets/gradient_position_widget.dart';
import 'background_widgets/image_widget.dart';
import 'background_widgets/shadow_widget.dart';

class BackgroundWidget extends StatefulWidget {
  final AppModel app;
  final BackgroundModel value;
  final String label;
  final String memberId;

  BackgroundWidget({
    Key? key,
    required this.app,
    required this.label,
    required this.value,
    required this.memberId,
  }) : super(key: key);

  @override
  _BackgroundWidgetWidgetState createState() => _BackgroundWidgetWidgetState();
}

class _BackgroundWidgetWidgetState extends State<BackgroundWidget> {
  @override
  Widget build(BuildContext context) {
    return topicContainer(widget.app, context,
        title: widget.label,
        collapsible: true,
        collapsed: true,
        children: [
          ImageWidget(
            app: widget.app,
            label: 'Background image',
            ownerId: widget.memberId,
            backgroundModel: widget.value,
          ),
          GradientPositionWidget(
            app: widget.app,
            groupValue: 0,
            label: 'Begin Gradient Position',
            value: widget.value.beginGradientPosition != null
                ? widget.value.beginGradientPosition!.index
                : 0,
            gradientPositionChanged: _setBeginGradientPosition,
          ),
          GradientPositionWidget(
            app: widget.app,
            groupValue: 1,
            label: 'End Gradient Position',
            value: widget.value.endGradientPosition != null
                ? widget.value.endGradientPosition!.index
                : 0,
            gradientPositionChanged: _setEndGradientPosition,
          ),
          DecorationColorListWidget(
            app: widget.app,
            label: 'Decoration colors',
            colorListChanged: _setColorListChanged,
            colors: widget.value.decorationColors ?? [],
          ),
          topicContainer(widget.app, context,
              title: 'Border',
              collapsible: true,
              collapsed: true,
              children: [
                checkboxListTile(widget.app, context, 'With border',
                    widget.value.border ?? false, _borderChanged),
              ]),
          ShadowWidget(
            app: widget.app,
            label: 'Shadow',
            backgroundModel: widget.value,
          )
        ]);
  }

  void _borderChanged(bool? value) {
    setState(() {
      widget.value.border = value;
    });
  }

  void _setBeginGradientPosition(int? value) {
    setState(() {
      widget.value.beginGradientPosition = toStartGradientPosition(value);
    });
  }

  void _setEndGradientPosition(int? value) {
    setState(() {
      widget.value.endGradientPosition = toEndGradientPosition(value);
    });
  }

  void _setColorListChanged(List<DecorationColorModel>? value) {
    setState(() {
      widget.value.decorationColors = value;
    });
  }
}
