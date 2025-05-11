import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TLnotification extends StatefulWidget {
  const TLnotification({super.key});

  @override
  State<TLnotification> createState() => _HomePageempState();
}

class _HomePageempState extends State<TLnotification> {
  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery.of(context).size.height * 0.120;
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Notification",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  bool istask = true; //check the istask or not bu ysing list
                  return Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return infopage(istask: istask);
                          }));
                        },
                        child: Card(
                          elevation: 4.0, // Adds shadow for elevated effect
                          color: Theme.of(context)
                              .colorScheme
                              .secondary, // Background color for the card
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            height: cardHeight,
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                //const Spacer(),
                                Padding(
                                  padding: EdgeInsets.all(6.0),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          (istask)
                                              ? "Project "
                                              : "Raised Issue",
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
                                ),
            
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        " Project Name ",
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
                        ),
                      ));
                },
              ),
            ),
          ],
        ));
  }
}

class infopage extends StatefulWidget {
  final bool istask;
  const infopage({super.key, required this.istask});

  @override
  State<infopage> createState() => _infopageState();
}

class _infopageState extends State<infopage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Project assigned "),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("PROJECT NAME : {             }"),
            SizedBox(
              height: 30,
            ),
            Text(" Manger  nanme or id : {             }"),
            SizedBox(
              height: 30,
            ),
            Text("Decription"),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8.0)),
                  child:
                      SingleChildScrollView(child: Text("ALL DDESCRIPTION "))),
            ),
            Text("DUE DATE :{               }"),
          ],
        ));
  }
}
