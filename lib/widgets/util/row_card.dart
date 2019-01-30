import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import 'package:flutter_todo/scoped_models/app_model.dart';
import 'package:flutter_todo/models/safe/Safe.dart';
import 'package:flutter_todo/widgets/helpers/priority_helper.dart';

class RowCard extends StatelessWidget {
  final Safe safe;

  RowCard(this.safe);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, AppModel model) {
        return Card(
          child: Row(
            children: <Widget>[
              Container(
                decoration: new BoxDecoration(
                  //color: PriorityHelper.getPriorityColor(todo.priority),
                  color: Colors.blue,
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(4.0),
                    bottomLeft: const Radius.circular(4.0),
                  ),
                ),
                width: 40.0,
                height: 80.0,
                child:
                //todo.isDone
                  //  ?
                IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () {
                          model.toggleDone(safe.id);
                        },
                      )
//                    : IconButton(
//                        icon: Icon(Icons.check_box_outline_blank),
//                        onPressed: () {
//                          model.toggleDone(todo.id);
//                        },
//                      ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    safe.name,
                    style: TextStyle(
                        fontSize: 24.0,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  model.setCurrentSafe(safe);

                  Navigator.pushNamed(context, '/editor');
                },
              )
            ],
          ),
        );
      },
    );
  }
}
