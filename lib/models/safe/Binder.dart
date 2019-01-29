import 'package:flutter/material.dart';
import 'package:flutter_todo/models/safe/Document.dart';

class Binder {
  final String id;
  final String title;
  final String category;
  final DateTime createdDate;
  final List<Document> docs;

  Binder({
    @required this.id,
    @required this.title,
    this.category,
    this.createdDate,
    this.docs,
  });
}
