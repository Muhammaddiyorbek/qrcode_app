import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Generate_widget extends StatefulWidget {
  const Generate_widget({super.key});

  @override
  State<Generate_widget> createState() => _Generate_widgetState();
}

class _Generate_widgetState extends State<Generate_widget> {
  final link_controller = TextEditingController();
  late String link_string = "QrCode";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          padding: EdgeInsets.only(left: 15, right: 0),
          margin: EdgeInsets.symmetric(vertical: 40),
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: SingleChildScrollView(
                    child: Text(
                      link_string,
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
                    final url = Uri.parse(link_string);
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
        ),
        Container(
          alignment: Alignment.center,
          child: QrImageView(
            data: link_string,
            size: size.width * 0.6,
            padding: EdgeInsets.all(0),
            version: QrVersions.auto,
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
            border: Border(
              bottom: BorderSide(color: Colors.black12, width: 12),
            ),
            color: Colors.white,
          ),
          width: size.width * 0.8,
          height: size.width * 0.8,
        ),
        Container(
          clipBehavior: Clip.hardEdge,
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.symmetric(vertical: 40),
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
          child: TextField(
            keyboardType: TextInputType.url,
            controller: link_controller,
            style: GoogleFonts.philosopher(
                fontSize: 25, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: "Url / Text kiriting",
              contentPadding:
                  EdgeInsets.only(left: 26.0, bottom: 8.0, right: 50.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 0.5),
                borderRadius: BorderRadius.circular(26),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 0.5),
                borderRadius: BorderRadius.circular(26),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: CupertinoButton(
            child: Text(
              "Generate",
              style: GoogleFonts.philosopher(fontSize: 23),
            ),
            onPressed: () {
              setState(() {
                link_string = link_controller.text == ""
                    ? "QrCode"
                    : link_controller.text;
                link_controller.text = "";
                print(link_string);
              });
            },
            color: Colors.green,
            borderRadius: BorderRadius.circular(90),
          ),
        )
      ],
    );
  }
}
