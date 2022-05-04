import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/style/frontend/has_button.dart';
import 'package:eliud_core/style/frontend/has_dialog.dart';
import 'package:eliud_core/style/frontend/has_dialog_widget.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void CroppedImage(Uint8List? imageBytes);

class ImageCropWidget extends StatefulWidget {
  final AppModel app;
  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.7;

  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.7;

  final CroppedImage croppedImage;
  final Uint8List image;

  const ImageCropWidget(
      {Key? key, required this.app, required this.image, required this.croppedImage})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ImageCropState();

  static void open(
    BuildContext context,
    AppModel app,
    CroppedImage croppedImage,
    Uint8List image,
  ) {
    openWidgetDialog(app, context, app.documentID! + '/imagecrop',
            child: ImageCropWidget(
              app: app,
              croppedImage: croppedImage,
              image: image,
            ));
  }
}

class ImageCropState extends State<ImageCropWidget> {
  final _cropController = CropController();
  bool? cropped;

  @override
  void initState() {
    cropped = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return flexibleDialog(widget.app, context,
            title: 'Crop image',
            buttons: [
              Spacer(),
              dialogButton(widget.app, context, onPressed: () {
                widget.croppedImage(null);
                Navigator.pop(context);
              }, label: 'Cancel'),
              dialogButton(widget.app, context, onPressed: () {
                _cropController.crop();
                Navigator.pop(context);
              }, label: 'Crop'),
            ],
            child: Container(
                height: ImageCropWidget.height(context),
                child: Crop(
                    controller: _cropController,
                    image: widget.image,
                    aspectRatio: 1.0,
                    onCropped: (image) {
                      cropped = true;
                      widget.croppedImage(image);
                    })));
  }
}
