import 'package:flutter/material.dart';
import 'package:flutter_todo/models/safe/Safe.dart';

import 'package:scoped_model/scoped_model.dart';

import 'package:flutter_todo/.env.dart';
import 'package:flutter_todo/models/todo.dart';
import 'package:flutter_todo/models/safe/enum/AccessLevel.dart';
import 'package:flutter_todo/models/priority.dart';
import 'package:flutter_todo/scoped_models/app_model.dart';
import 'package:flutter_todo/widgets/helpers/message_dialog.dart';
import 'package:flutter_todo/widgets/helpers/confirm_dialog.dart';
import 'package:flutter_todo/widgets/ui_elements/loading_modal.dart';
import 'package:flutter_todo/widgets/form_fields/priority_form_field.dart';
import 'package:flutter_todo/widgets/form_fields/toggle_form_field.dart';

class SafeEditorPage extends StatefulWidget {

  final AppModel model;

  SafeEditorPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _SafeEditorPageState();
  }
}

class _SafeEditorPageState extends State<SafeEditorPage> {
  final Map<String, dynamic> _formData = {
    'name': null,
    'type': AccessLevel.Private.toString(),

  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildAppBar(AppModel model) {
    return AppBar(
      title: Text(Configure.AppName),
      backgroundColor: Colors.blue,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.lock),
          onPressed: () async {
            bool confirm = await ConfirmDialog.show(context);

            if (confirm) {
              Navigator.pop(context);

              model.logout();
            }
          },
        ),
      ],
    );
  }

  Widget _buildFloatingActionButton(AppModel model) {
    return FloatingActionButton(
      child: Icon(Icons.save),
      onPressed: () {
        if (!_formKey.currentState.validate()) {
          return;
        }

        _formKey.currentState.save();

        if (model.currentSafe != null ) {
          model
              .updateSafe(

          )
              .then((bool success) {
            if (success) {
              model.setCurrentTodo(null);

              Navigator.pop(context);
            } else {
              MessageDialog.show(context);
            }
          });
        } else {
          model
              .createSafe(
//            _formData['title'],
//            _formData['content'],
//            _formData['priority'],
//            _formData['isDone'],
          )
              .then((bool success) {
            if (success) {
              Navigator.pop(context);
            } else {
              MessageDialog.show(context);
            }
          });
        }
      },
    );
  }

  Widget _buildTitleField(Safe safe) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Title'),
      initialValue: safe != null ? safe.name : '',
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a safe name\'s title';
        }
      },
      onSaved: (value) {
        _formData['name'] = value;
      },
    );
  }

  Widget _buildContentField(Safe safe) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Type'),
      initialValue: safe != null ? safe.type : '',
      maxLines: 5,
      onSaved: (value) {
        _formData['type'] = value;
      },
    );
  }

  Widget _buildOthers(Todo todo) {
    final bool isDone = todo != null && todo.isDone;
    final Priority priority = todo != null ? todo.priority : Priority.Low;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ToggleFormField(
          initialValue: isDone,
          onSaved: (bool value) {
            _formData['isDone'] = value;
          },
        ),
        PriorityFormField(
          initialValue: priority,
          onSaved: (Priority value) {
            _formData['priority'] = value;
          },
        ),
      ],
    );
  }

  Widget _buildForm(AppModel model) {
    Safe safe = model.currentSafe;

    _formData['title'] = safe != null ? safe.name : null;
    _formData['type'] = safe != null ? safe.type : null;

    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          _buildTitleField(safe),
          _buildContentField(safe),
          SizedBox(
            height: 12.0,
          ),
         // _buildOthers(todo),
        ],
      ),
    );
  }

  Widget _buildPageContent(AppModel model) {
    return Scaffold(
      appBar: _buildAppBar(model),
      floatingActionButton: _buildFloatingActionButton(model),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: _buildForm(model),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (BuildContext context, Widget child, AppModel model) {
        Stack mainStack = Stack(
          children: <Widget>[
            _buildPageContent(model),
          ],
        );

        if (model.isLoading) {
          mainStack.children.add(LoadingModal());
        }

        return mainStack;
      },
    );
  }
}
