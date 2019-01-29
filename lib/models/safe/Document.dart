import 'package:flutter/material.dart';

class Document {
  final String id;
  final String password;
  final String userName;
  final String link;
  final DateTime cratedDate;

  Document({
    @required this.id,
    @required this.password,
    this.userName,
    this.link,
    this.cratedDate,
  });
}
