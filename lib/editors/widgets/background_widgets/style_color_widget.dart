
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/rgb_model.dart';
import 'package:eliud_core/style/frontend/has_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class StyleColorWidget extends StatefulWidget {
  final AppModel app;
  final RgbModel value;
  final String label;
  final bool withContainer;
  VoidCallback? changeTrigger;

  StyleColorWidget({
    Key? key,
    required this.app,
    required this.label,
    required this.value,
    this.withContainer = true,
    this.changeTrigger,
  }) : super(key: key);

  @override
  _StyleColorWidgetState createState() => _StyleColorWidgetState();
}

class _StyleColorWidgetState extends State<StyleColorWidget> {
  Color? color;

  @override
  void initState() {
    super.initState();
    if (widget.value != null)
      color = Color.fromRGBO(widget.value.r!, widget.value.g!, widget.value.b!,
          widget.value.opacity!);
    else
      color = Color.fromRGBO(255, 0, 0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.withContainer) {
      return topicContainer(widget.app, context,
          title: widget.label,
          collapsible: true,
          collapsed: true,
          children: [
            ColorPicker(
              pickerColor: color!,
              onColorChanged: changeColor,
              //enableLabel: true,
              pickerAreaHeightPercent: 0.8,
            )
          ]);
    } else {
      return ColorPicker(
        pickerColor: color!,
        onColorChanged: changeColor,
        //enableLabel: true,
        pickerAreaHeightPercent: 0.8,
      );
    }
  }

  void changeColor(Color c) {
    setState(() {
      if (widget.changeTrigger != null) {
        widget.changeTrigger!();
      }
      color = c;
      widget.value.r = c.red;
      widget.value.g = c.green;
      widget.value.b = c.blue;
      widget.value.opacity = c.opacity;
    });
  }
}
