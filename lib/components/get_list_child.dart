import 'package:flutter/material.dart';
import 'card_list_view.dart';

List<Widget> getListChild () {
  List<Widget> children = [];
  for (int i = 0; i<12; i++) {
    children.add(const CardInListView());
  }
  return children;
}