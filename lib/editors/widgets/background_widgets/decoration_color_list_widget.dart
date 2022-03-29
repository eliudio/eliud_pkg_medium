import 'package:eliud_core/style/frontend/has_container.dart';
import 'package:eliud_core/style/frontend/has_dialog_field.dart';
import 'package:eliud_core/style/frontend/has_list_tile.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:eliud_core/model/model_export.dart';

import 'style_color_widget.dart';

typedef ColorListChanged(List<DecorationColorModel>? value);

class DecorationColorListWidget extends StatefulWidget {
  final AppModel app;
  final String label;
  List<DecorationColorModel> colors;
  final ColorListChanged colorListChanged;

  DecorationColorListWidget({
    Key? key,
    required this.app,
    required this.label,
    required this.colors,
    required this.colorListChanged,
  }) : super(key: key);

  @override
  _DecorationColorListState createState() => _DecorationColorListState();
}

class _DecorationColorListState extends State<DecorationColorListWidget> {
  @override
  Widget build(BuildContext context) {
    List<Widget> colorEntries = [];
    if (widget.colors.isNotEmpty) {
      int i = 1;
      for (var color in widget.colors) {
        if (color.color != null) {
          colorEntries.add(topicContainer(widget.app, context,
              title: 'Gradient color #' + i.toString(),
              collapsible: true,
              collapsed: true,
              children: [
                StyleColorWidget(
                    withContainer: false,
                    app: widget.app,
                    value: color.color!,
                    label: 'Gradient color #' + i.toString()),
                getListTile(context, widget.app,
                    leading: Icon(Icons.description),
                    title: dialogField(
                      widget.app,
                      context,
                      initialValue: (color.stop ?? 0).toString(),
                      valueChanged: (value) {
                        color.stop = double.parse(value);
                      },
                      keyboardType: TextInputType.numberWithOptions(signed: false, ),
                      decoration: const InputDecoration(
                        hintText: 'Stop',
                        labelText: 'Stop',
                      ),
                    ))
              ]));
          i++;
        }
      }
    }
    colorEntries.add(_addButton());
    return topicContainer(
      widget.app,
      context,
      title: widget.label,
      collapsible: true,
      collapsed: true,
      children: colorEntries,
    );
  }

  Widget _addButton() {
    return Row(children: [
      Spacer(),
      if (widget.colors.length >= 1)
        GestureDetector(
            child: Icon(Icons.delete),
            onTap: () {
              setState(() {
                widget.colors.removeLast();
              });
            }),
      if (widget.colors.length >= 1) Spacer(),
      GestureDetector(
          child: Icon(Icons.add),
          onTap: () {
            setState(() {
              widget.colors.add(DecorationColorModel(
                  documentID: newRandomKey(),
                  color: RgbModel(r: 0, g: 0, b: 0, opacity: 1),
                  stop: 0));
            });
          }),
      Spacer(),
    ]);
  }
}
