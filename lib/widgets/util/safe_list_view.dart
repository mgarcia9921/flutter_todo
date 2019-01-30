import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_todo/models/filter.dart';

import 'package:scoped_model/scoped_model.dart';

import 'package:flutter_todo/scoped_models/app_model.dart';
import 'package:flutter_todo/models/safe/Safe.dart';
import 'package:flutter_todo/widgets/util/row_card.dart';

class SafeListView extends StatelessWidget {
  Widget _buildEmptyText(AppModel model) {
    String emptyText;

    if(model.isSafeEmpty){
      emptyText = 'This is boring here. \r\nCreate a Safe to make it crowd.';
    }

    Widget svg = new SvgPicture.asset(
      'assets/todo_list.svg',
      width: 200,
    );

    return Container(
      color: Color.fromARGB(16, 0, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          svg,
          SizedBox(
            height: 40.0,
          ),
          Text(
            emptyText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(AppModel model) {
    return ListView.builder(
      itemCount: model.safes.length,
      itemBuilder: (BuildContext context, int index) {
        Safe safe = model.safes[index];

        return Dismissible(
          key: Key(safe.id),
          onDismissed: (DismissDirection direction) {
            model.removeSafe(safe);
          },
          child: RowCard(safe),
          background: Container(color: Colors.red),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (BuildContext context, Widget child, AppModel model) {
        Widget safeCards = model.safes.length > 0
            ? _buildListView(model)
            : _buildEmptyText(model);

        return safeCards;
      },
    );
  }
}
