import 'package:flutter/material.dart';
import 'package:qrcode_app/app_strings/app_strings.dart';
import 'package:qrcode_app/views/home.dart';

void main() {
  runApp(
    MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      home: Home(),
    ),
  );
}
