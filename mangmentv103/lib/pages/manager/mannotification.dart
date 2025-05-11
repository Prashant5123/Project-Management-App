import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe_to/swipe_to.dart';

class Mannotification extends StatefulWidget {
  const Mannotification({super.key});

  @override
  State<Mannotification> createState() => _HomePageempState();
}

class _HomePageempState extends State<Mannotification> {
  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery.of(context).size.height * 0.10;
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Notification",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Card(
                      elevation: 4.0, // Adds shadow for elevated effect
                      color: const Color.fromARGB(255, 253, 247,
                          255), // Background color for the card
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: SwipeTo(
                          onRightSwipe: (details) {},
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: cardHeight,
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  //const Spacer(),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "title",
                                          style: GoogleFonts.quicksand(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                          maxLines: 1, // Limit to one line
                                          overflow: TextOverflow
                                              .ellipsis, // Show ellipsis for overflow
                                        ),
                                      ),
                                    ],
                                  ),
        
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 4.0,
                                      bottom: 8.0,
                                      right: 6.0,
                                      left: 6.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          " Description ",
                                          style: GoogleFonts.quicksand(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))));
            },
          ),
        ),
      ],
    ));
  }
}
