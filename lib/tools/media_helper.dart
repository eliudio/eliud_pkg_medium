import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/model/platform_medium_model.dart';
import 'package:eliud_core/style/frontend/has_button.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/tools/etc.dart';
import 'package:eliud_core/tools/storage/medium_base.dart';
import 'package:eliud_core/tools/storage/member_image_model_widget.dart';
import 'package:eliud_core/tools/storage/platform_image_model_widget.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MediaHelper {
  static int POPUP_MENU_DELETE_VALUE = 0;
  static int POPUP_MENU_VIEW = 1;

  static Widget videoAndPhotoDivider(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.black,
      indent: MediaQuery.of(context).size.width * 0.1,
      endIndent: MediaQuery.of(context).size.width * 0.1,
    );
  }

  static Widget staggeredPhotosWithThumbnail(AppModel app,
      BuildContext context, List<PhotoWithThumbnail> photos,
      {Function(int index)? deleteAction,
      Function(int index)? viewAction,
      double? height,
      bool reverse = false,
      bool shrinkWrap = false}) {
    List<Widget> widgets = [];
    for (int i = 0; i < photos.length; i++) {
      var medium = photos[i];
      var image, name;
      image = Image.memory(medium.thumbNailData.data);
      name = medium.photoData.baseName;

      widgets.add(_getPopupMenuButton(app,
          context, name, image, i, deleteAction, viewAction));
    }
    return _getContainer(widgets, height, reverse, shrinkWrap);
  }

  static Widget staggeredVideosWithThumbnail(AppModel app,
      BuildContext context, List<VideoWithThumbnail> videos,
      {Function(int index)? deleteAction,
      Function(int index)? viewAction,
      double? height,
      bool reverse = false,
      bool shrinkWrap = false}) {
    List<Widget> widgets = [];
    for (int i = 0; i < videos.length; i++) {
      var medium = videos[i];
      var image, name;
      image = Image.memory(medium.thumbNailData.data);
      name = medium.videoData.baseName;

      widgets.add(_getPopupMenuButton(app,
          context, name, image, i, deleteAction, viewAction));
    }
    return _getContainer(widgets, height, reverse, shrinkWrap);
  }

  static Widget staggeredMemberMediumModel(AppModel app,
      BuildContext context, List<MemberMediumModel> media,
      {Function(int index)? deleteAction,
      Function(int index)? viewAction,
      double? progressExtra,
      String? progressLabel,
      double? height,
      bool reverse = false,
      bool shrinkWrap = false}) {
    List<Widget> widgets = [];
    for (int i = 0; i < media.length; i++) {
      var medium = media[i];
      var image, name;
      image = MemberImageModelWidget(
        memberMediumModel: medium,
        showThumbnail: true,
      );
      name = medium.urlThumbnail!;

      widgets.add(_getPopupMenuButton(app,
          context, name, image, i, deleteAction, viewAction));
    }
    if (progressExtra != null) {
      if (progressExtra >= 0) {
        widgets.add(Center(
            child: CircularPercentIndicator(
          radius: 60.0,
          lineWidth: 5.0,
          percent: progressExtra,
          center: text(app, context, '100%'),
        )));
      } else {
        widgets.add(Center(child: CircularProgressIndicator()));
      }
    }
    return _getContainer(widgets, height, reverse, shrinkWrap);
  }

  static Widget staggeredPlatformMediumModel(AppModel app,
      BuildContext context, List<PlatformMediumModel> media,
      {Function(int index)? deleteAction,
        Function(int index)? viewAction,
        double? progressExtra,
        String? progressLabel,
        double? height,
        bool reverse = false,
        bool shrinkWrap = false,
        BackgroundModel? background,
      }) {
    var member;
    if (background != null) {
      var member = AccessBloc.member(context);
    }
    List<Widget> widgets = [];
    for (int i = 0; i < media.length; i++) {
      var medium = media[i];
      var image, name;
      image = Container(
          clipBehavior: BoxDecorationHelper.determineClipBehaviour(app, member, background),
          decoration: BoxDecorationHelper.boxDecoration(app, member, background),
          margin: BoxDecorationHelper.determineMargin(app, member, background),
          padding: BoxDecorationHelper.determinePadding(app, member, background),
          child: PlatformImageModelWidget(
            platformMediumModel: medium,
            showThumbnail: true,
          ));
      name = medium.urlThumbnail!;

      widgets.add(_getPopupMenuButton(app,
          context, name, image, i, deleteAction, viewAction));
    }
    if (progressExtra != null) {
      if (progressExtra >= 0) {
        widgets.add(Center(
            child: CircularPercentIndicator(
              radius: 60.0,
              lineWidth: 5.0,
              percent: progressExtra,
              center: text(app, context, '100%'),
            )));
      } else {
        widgets.add(Center(child: CircularProgressIndicator()));
      }
    }

    return Container(
        padding: const EdgeInsets.all(16.0),
        child: GridView.extent(
            maxCrossAxisExtent: 200,
            padding: const EdgeInsets.all(20),
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            physics: const ScrollPhysics(), // to disable GridView's scrolling
            shrinkWrap: true,
            children: widgets));

  }

  static Widget _getPopupMenuButton(AppModel app,
      BuildContext context,
      String name,
      Widget image,
      int index,
      Function(int index)? deleteAction,
      Function(int index)? viewAction) {
    if (deleteAction == null) {
      if (viewAction == null) {
        return image;
      } else {
        return GestureDetector(
            onTap: () {
              viewAction(index);
            },
            child: image);
      }
    } else {
      List<PopupMenuItem<int>> menuItems = [];
      if (viewAction != null) {
        menuItems.add(popupMenuItem<int>(
            app, context,
            label: 'View', value: POPUP_MENU_VIEW));
      }
      menuItems.add(popupMenuItem<int>(
          app, context,
          label: 'Delete', value: POPUP_MENU_DELETE_VALUE));

      return popupMenuButton(
        app, context,
          tooltip: name,
          child: image,
          itemBuilder: (_) => menuItems,
          onSelected: (choice) {
            if (choice == POPUP_MENU_DELETE_VALUE) {
              deleteAction(index);
            }
            if ((choice == POPUP_MENU_VIEW) && (viewAction != null)) {
              viewAction(index);
            }
          });
    }
  }

  static Widget _getContainer(
      List<Widget> widgets, double? height, bool reverse, bool shrinkWrap) {
    return Container(
        height: height == null ? 200 : height,
        child: CustomScrollView(
          shrinkWrap: shrinkWrap,
          reverse: reverse,
          scrollDirection: Axis.horizontal,
          primary: false,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(0),
              sliver: SliverGrid.extent(
                  maxCrossAxisExtent: 200,
                  children: widgets,
                  mainAxisSpacing: 10),
            ),
          ],
        ));
  }
}
