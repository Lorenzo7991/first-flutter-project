import 'package:flutter/material.dart';

void main() {
  runApp( MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Hello Flutter'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.brown[700],
        centerTitle: true,
      ),
    ),
  ));
}