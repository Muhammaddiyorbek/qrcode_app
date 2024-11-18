import 'dart:typed_data';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qrcode_app/views/skaner_kamera.dart';
import 'package:url_launcher/url_launcher.dart';

class Skaner_widget extends StatefulWidget {
  const Skaner_widget({super.key});

  @override
  State<Skaner_widget> createState() => _Skaner_widgetState();
}

class _Skaner_widgetState extends State<Skaner_widget> {
  late String link_string = "QrCode";
  late List<String> qr_string_list = [];
  Uint8List? image;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          child: image != null
              ? Image(
                  image: MemoryImage(image!),
                  fit: BoxFit.cover,
                )
              : Center(
                  child: Text(
                    "Hozircha rasm yo'q",
                    style: GoogleFonts.philosopher(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 5),
              BoxShadow(
                color: Colors.grey,
                offset: Offset(10, 15),
                blurRadius: 10,
              ),
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
            border: image == null
                ? Border(
                    bottom: BorderSide(color: Colors.black12, width: 12),
                  )
                : Border(bottom: BorderSide.none),
            color: Colors.white,
          ),
          width: size.width * 0.8,
          height: size.width * 0.8,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 25),
          child: CupertinoButton(
            child: Text(
              "Skaner",
              style: GoogleFonts.philosopher(fontSize: 23),
            ),
            onPressed: () async {
              final result = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SkanerKamera()));
              setState(() {});
              image = result[0];
              qr_string_list = [];
              for (final qr in result[1]) {
                qr_string_list.add(qr.rawValue);
              }
            },
            color: Colors.green,
            borderRadius: BorderRadius.circular(90),
          ),
        ),
        ...qr_string_list.map((qr) => Container(
              clipBehavior: Clip.hardEdge,
              padding: EdgeInsets.only(left: 8, right: 0),
              margin: EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 20),
              height: 60,
              width: size.width * 0.9,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, blurRadius: 10, offset: Offset(0, 1))
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(90),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: GestureDetector(
                      onTap: () async {
                        await FlutterClipboard.copy(qr);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text(
                            "Nusxalandi",
                            style: GoogleFonts.philosopher(fontSize: 20),
                          ),
                          backgroundColor: Colors.amber,
                        ));
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.grey, blurRadius: 2),
                          ],
                        ),
                        child: Icon(Icons.copy),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: SingleChildScrollView(
                        child: Text(
                          qr,
                          maxLines: 3,
                          overflow: TextOverflow.fade,
                          style: GoogleFonts.philosopher(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      color: Colors.green,
                      onPressed: () async {
                        final url = Uri.parse(qr);
                        if (await canLaunchUrl(url)) {
                          launchUrl(url);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                "Bu url emas!",
                                style: GoogleFonts.philosopher(fontSize: 20),
                              ),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        }
                      },
                      icon: Icon(
                        Icons.arrow_forward,
                        size: 40,
                      ))
                ],
              ),
            ))
      ],
    );
  }
}
