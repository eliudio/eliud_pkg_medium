import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:eliud_core/style/frontend/has_button.dart';
import 'package:eliud_core/style/frontend/has_dialog.dart';
import 'package:eliud_core/style/frontend/has_dialog_widget.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void CroppedImage(Uint8List? imageBytes);

class ImageCropWidget extends StatefulWidget {
  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.7;

  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.7;

  final CroppedImage croppedImage;
  final Uint8List image;

  const ImageCropWidget(
      {Key? key, required this.image, required this.croppedImage})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ImageCropState();

  static void open(
    BuildContext context,
    CroppedImage croppedImage,
    Uint8List image,
  ) {
    openWidgetDialog(context,
            child: ImageCropWidget(
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
  void dispose() {
    if ((cropped != null) && (!cropped!)) {
      widget.croppedImage(null);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return flexibleDialog(context,
            title: 'Crop image',
            buttons: [
              Spacer(),
              dialogButton(context, onPressed: () {
                Navigator.pop(context);
              }, label: 'Cancel'),
              dialogButton(context, onPressed: () {
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
