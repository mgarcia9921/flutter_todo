import 'package:flutter/material.dart';
import 'package:flutter_todo/models/safe/Binder.dart';

class Safe {
  final String id;
  final String name;
  final String type;
  final DateTime created;
  final bool isActive;
  final List<Binder> binder;

  Safe({
    @required this.id,
    @required this.name,
    this.type,
    this.created,
    this.isActive,
    this.binder,
  });
}
