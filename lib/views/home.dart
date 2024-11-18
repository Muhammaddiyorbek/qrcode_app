import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qrcode_app/app_strings/app_strings.dart';
import 'package:qrcode_app/views/generate.dart';
import 'package:qrcode_app/views/skaner_view.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(242, 243, 248, 1),
        appBar: AppBar(
          shape: Border(bottom: BorderSide(color: Colors.black)),
          title: Text(
            AppStrings.appName,
            style: GoogleFonts.philosopher(fontSize: 35),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
          ),
          child: TabBar(
            labelColor: Colors.green,
            indicatorColor: Colors.lightGreen,
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.qr_code,
                  size: 35,
                ),
                child: Text(
                  "Generate",
                  style: GoogleFonts.philosopher(fontSize: 20),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.qr_code_scanner,
                  size: 35,
                ),
                child: Text(
                  "Skaner",
                  style: GoogleFonts.philosopher(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            SingleChildScrollView(child: Generate_widget()),
            Skaner_widget()
          ],
        ),
      ),
    );
  }
}
