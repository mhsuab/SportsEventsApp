import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sports/utils/utils.dart';

class HomePage extends StatelessWidget {
  final Function(SportSwitch)? onTap;
  const HomePage({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        Container(
          color: Colors.black,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Sports",
              textDirection: TextDirection.ltr,
              style: GoogleFonts.titanOne(
                fontSize: 60,
                fontStyle: FontStyle.italic,
                decoration: TextDecoration.underline,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            ...sports
                .map((key, value) => MapEntry(
                    key.name,
                    GestureDetector(
                        onTap: () => onTap!(key),
                        child: Center(
                          child: Container(
                            margin: const EdgeInsets.all(5.0),
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: const StadiumBorder(
                                side: BorderSide(
                                  width: 2,
                                  color: Colors.blueGrey,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              shadows: [
                                BoxShadow(
                                  offset: const Offset(1.5, 1.5),
                                  color: Colors.blueGrey.shade300,
                                  blurRadius: 0.5,
                                ),
                              ],
                            ),
                            height: 40,
                            width: 250,
                            child: Center(
                              child: Text(
                                value.abbr,
                                textDirection: TextDirection.ltr,
                                style: GoogleFonts.staatliches(
                                  fontSize: 28,
                                  color: Colors.blueGrey.shade800,
                                ),
                              ),
                            ),
                          ),
                        ))))
                .values
                .toList(),
          ],
        ),
      ],
    );
  }
}
