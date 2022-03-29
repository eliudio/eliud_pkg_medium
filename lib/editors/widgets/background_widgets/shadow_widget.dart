import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_core/model/rgb_model.dart';
import 'package:eliud_core/model/shadow_model.dart';
import 'package:eliud_core/style/frontend/has_container.dart';
import 'package:eliud_core/style/frontend/has_dialog_field.dart';
import 'package:eliud_core/style/frontend/has_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'style_color_widget.dart';

class ShadowWidget extends StatefulWidget {
  final AppModel app;
  BackgroundModel backgroundModel;
  final String label;

  ShadowWidget({
    Key? key,
    required this.app,
    required this.label,
    required this.backgroundModel,
  }) : super(key: key);

  @override
  _ShadowState createState() => _ShadowState();
}

class _ShadowState extends State<ShadowWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.backgroundModel.shadow != null) {
      if (widget.backgroundModel.shadow!.color == null) {
        widget.backgroundModel.shadow!.color = _defaultColor();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return (widget.backgroundModel.shadow == null)
        ? inContainer(context, widget.label, [
            checkboxListTile(widget.app, context, 'Shadow', false,
                (_) => _createShadow())
          ])
        : inContainer(context, widget.label, [
            checkboxListTile(widget.app, context, 'Shadow', true,
                (_) => _removeShadow()),
            StyleColorWidget(
              value: widget.backgroundModel.shadow!.color!,
              label: 'Color',
              app: widget.app,
            ),
            inContainer(context, 'Parameters', [
              doubleField(
                  widget.backgroundModel.shadow!.offsetDX,
                  (value) => widget.backgroundModel.shadow!.offsetDX = value,
                  'Offset DX',
                  'sets [dx], the horizontal component of the offset'),
              doubleField(
                  widget.backgroundModel.shadow!.offsetDY,
                  (value) => widget.backgroundModel.shadow!.offsetDY = value,
                  'Offset DY',
                  'sets [dy], the vertical component of the offset'),
              doubleField(
                  widget.backgroundModel.shadow!.spreadRadius,
                  (value) =>
                      widget.backgroundModel.shadow!.spreadRadius = value,
                  'Spread Radius',
                  'The amount the box should be inflated prior to applying the blur'),
              doubleField(
                  widget.backgroundModel.shadow!.blurRadius,
                  (value) => widget.backgroundModel.shadow!.blurRadius = value,
                  'Blur Radius',
                  "The standard deviation of the Gaussian to convolve with the shadow's shape"),
            ]),
          ]);
  }

  Widget doubleField(double? initialValue, ValueChanged<double> valueChanged,
      String hint, String label) {
    return getListTile(context, widget.app,
        leading: Icon(Icons.description),
        title: dialogField(
          widget.app,
          context,
          initialValue: (initialValue ?? 0).toString(),
          valueChanged: (value) => valueChanged(double.parse(value)),
          keyboardType: TextInputType.numberWithOptions(signed: false, ),
          decoration: InputDecoration(
            hintText: hint,
            labelText: label,
          ),
        ));
  }

  Widget inContainer(BuildContext context, String label, List<Widget> widgets) {
    return topicContainer(widget.app, context,
        title: label,
        collapsible: true,
        collapsed: true,
        children: widgets);
  }

  void _createShadow() {
    setState(() {
      widget.backgroundModel.shadow = ShadowModel(color: _defaultColor());
    });
  }

  RgbModel _defaultColor() => RgbModel(r: 0, g: 0, b: 0, opacity: 1);

  void _removeShadow() {
    setState(() {
      widget.backgroundModel.shadow = null;
    });
  }
}
