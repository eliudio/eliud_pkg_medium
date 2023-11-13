/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 album_entry_form.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/core/blocs/access/state/access_state.dart';
import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_core/core/navigate/router.dart' as eliudrouter;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/style/style_registry.dart';

import 'package:eliud_core/model/internal_component.dart';

import 'package:eliud_core/tools/enums.dart';

import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_medium/model/model_export.dart';

import 'package:eliud_pkg_medium/model/album_entry_list_bloc.dart';
import 'package:eliud_pkg_medium/model/album_entry_list_event.dart';
import 'package:eliud_pkg_medium/model/album_entry_model.dart';
import 'package:eliud_pkg_medium/model/album_entry_form_bloc.dart';
import 'package:eliud_pkg_medium/model/album_entry_form_event.dart';
import 'package:eliud_pkg_medium/model/album_entry_form_state.dart';

class AlbumEntryForm extends StatelessWidget {
  final AppModel app;
  final FormAction formAction;
  final AlbumEntryModel? value;
  final ActionModel? submitAction;

  AlbumEntryForm(
      {super.key,
      required this.app,
      required this.formAction,
      required this.value,
      this.submitAction});

  /// Build the AlbumEntryForm
  @override
  Widget build(BuildContext context) {
    //var accessState = AccessBloc.getState(context);
    var appId = app.documentID;
    if (formAction == FormAction.showData) {
      return BlocProvider<AlbumEntryFormBloc>(
        create: (context) => AlbumEntryFormBloc(
          appId,
        )..add(InitialiseAlbumEntryFormEvent(value: value)),
        child: _MyAlbumEntryForm(
            app: app, submitAction: submitAction, formAction: formAction),
      );
    }
    if (formAction == FormAction.showPreloadedData) {
      return BlocProvider<AlbumEntryFormBloc>(
        create: (context) => AlbumEntryFormBloc(
          appId,
        )..add(InitialiseAlbumEntryFormNoLoadEvent(value: value)),
        child: _MyAlbumEntryForm(
            app: app, submitAction: submitAction, formAction: formAction),
      );
    } else {
      return Scaffold(
          appBar: StyleRegistry.registry()
              .styleWithApp(app)
              .adminFormStyle()
              .appBarWithString(app, context,
                  title: formAction == FormAction.updateAction
                      ? 'Update AlbumEntry'
                      : 'Add AlbumEntry'),
          body: BlocProvider<AlbumEntryFormBloc>(
            create: (context) => AlbumEntryFormBloc(
              appId,
            )..add((formAction == FormAction.updateAction
                ? InitialiseAlbumEntryFormEvent(value: value)
                : InitialiseNewAlbumEntryFormEvent())),
            child: _MyAlbumEntryForm(
                app: app, submitAction: submitAction, formAction: formAction),
          ));
    }
  }
}

class _MyAlbumEntryForm extends StatefulWidget {
  final AppModel app;
  final FormAction? formAction;
  final ActionModel? submitAction;

  _MyAlbumEntryForm({required this.app, this.formAction, this.submitAction});

  @override
  State<_MyAlbumEntryForm> createState() => _MyAlbumEntryFormState(formAction);
}

class _MyAlbumEntryFormState extends State<_MyAlbumEntryForm> {
  final FormAction? formAction;
  late AlbumEntryFormBloc _myFormBloc;

  final TextEditingController _nameController = TextEditingController();
  String? _medium;

  _MyAlbumEntryFormState(this.formAction);

  @override
  void initState() {
    super.initState();
    _myFormBloc = BlocProvider.of<AlbumEntryFormBloc>(context);
    _nameController.addListener(_onNameChanged);
  }

  @override
  Widget build(BuildContext context) {
    var accessState = AccessBloc.getState(context);
    return BlocBuilder<AlbumEntryFormBloc, AlbumEntryFormState>(
        builder: (context, state) {
      if (state is AlbumEntryFormUninitialized) {
        return Center(
          child: StyleRegistry.registry()
              .styleWithApp(widget.app)
              .adminListStyle()
              .progressIndicator(widget.app, context),
        );
      }

      if (state is AlbumEntryFormLoaded) {
        _nameController.text = state.value!.name.toString();
        if (state.value!.medium != null) {
          _medium = state.value!.medium!.documentID;
        } else {
          _medium = "";
        }
      }
      if (state is AlbumEntryFormInitialized) {
        List<Widget> children = [];
        children.add(Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: StyleRegistry.registry()
                .styleWithApp(widget.app)
                .adminFormStyle()
                .groupTitle(widget.app, context, 'General')));

        children.add(StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .textFormField(widget.app, context,
                labelText: 'Name',
                icon: Icons.text_format,
                readOnly: _readOnly(accessState, state),
                textEditingController: _nameController,
                keyboardType: TextInputType.text,
                validator: (_) =>
                    state is NameAlbumEntryFormError ? state.message : null,
                hintText: null));

        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .divider(widget.app, context));

        children.add(Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: StyleRegistry.registry()
                .styleWithApp(widget.app)
                .adminFormStyle()
                .groupTitle(widget.app, context, 'Optional Image')));

        children.add(
          DropdownButtonComponentFactory().createNew(
              app: widget.app,
              id: "platformMediums",
              value: _medium,
              trigger: (value, privilegeLevel) => _onMediumSelected(value),
              optional: true),
        );

        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .divider(widget.app, context));

        children.add(Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: StyleRegistry.registry()
                .styleWithApp(widget.app)
                .adminFormStyle()
                .groupTitle(widget.app, context, 'Optional Code')));

        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .divider(widget.app, context));

        if ((formAction != FormAction.showData) &&
            (formAction != FormAction.showPreloadedData)) {
          children.add(StyleRegistry.registry()
              .styleWithApp(widget.app)
              .adminFormStyle()
              .button(
                widget.app,
                context,
                label: 'Submit',
                onPressed: _readOnly(accessState, state)
                    ? null
                    : () {
                        if (state is AlbumEntryFormError) {
                          return;
                        } else {
                          if (formAction == FormAction.updateAction) {
                            BlocProvider.of<AlbumEntryListBloc>(context)
                                .add(UpdateAlbumEntryList(
                                    value: state.value!.copyWith(
                              documentID: state.value!.documentID,
                              name: state.value!.name,
                              medium: state.value!.medium,
                            )));
                          } else {
                            BlocProvider.of<AlbumEntryListBloc>(context)
                                .add(AddAlbumEntryList(
                                    value: AlbumEntryModel(
                              documentID: state.value!.documentID,
                              name: state.value!.name,
                              medium: state.value!.medium,
                            )));
                          }
                          if (widget.submitAction != null) {
                            eliudrouter.Router.navigateTo(
                                context, widget.submitAction!);
                          } else {
                            Navigator.pop(context);
                          }
                        }
                      },
              ));
        }

        return StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .container(
                widget.app,
                context,
                Form(
                  child: ListView(
                      padding: const EdgeInsets.all(8),
                      physics: ((formAction == FormAction.showData) ||
                              (formAction == FormAction.showPreloadedData))
                          ? NeverScrollableScrollPhysics()
                          : null,
                      shrinkWrap: ((formAction == FormAction.showData) ||
                          (formAction == FormAction.showPreloadedData)),
                      children: children),
                ),
                formAction!);
      } else {
        return StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminListStyle()
            .progressIndicator(widget.app, context);
      }
    });
  }

  void _onNameChanged() {
    _myFormBloc.add(ChangedAlbumEntryName(value: _nameController.text));
  }

  void _onMediumSelected(String? val) {
    setState(() {
      _medium = val;
    });
    _myFormBloc.add(ChangedAlbumEntryMedium(value: val));
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  /// Is the form read-only?
  bool _readOnly(AccessState accessState, AlbumEntryFormInitialized state) {
    return (formAction == FormAction.showData) ||
        (formAction == FormAction.showPreloadedData) ||
        (!accessState.memberIsOwner(widget.app.documentID));
  }
}
