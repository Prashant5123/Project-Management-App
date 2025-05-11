//there are some flause and progress page and deatil apge for submited data must be made it will be made after firebase and sqlite and file upload
// ignore_for_file: library_private_types_in_public_api
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Manthirdpage extends StatefulWidget {
  const Manthirdpage({super.key});

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<Manthirdpage> {
  // Sample data for ongoing and completed projects
  final List<String> ongoingProjects = [
    'Project ABC',
    'Project DEF',
    'Project GHI'
  ];
  final List<String> completedProjects = [
    'Completed Project XYZ',
    'Completed Project LMN'
  ];

  @override
  Widget build(BuildContext context) {
    double cardHeight =
        MediaQuery.of(context).size.height * 0.15; // Adjust height as needed
    double cardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Completed",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: cardWidth * 0.3,
              width: cardWidth,
              child: ListView.builder(
                scrollDirection:
                    Axis.horizontal, // This makes the list scroll horizontally
                itemCount: completedProjects.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProgressDetailsPage(index: index)),
                      );
                    },
                    child: Card(
                      color: Theme.of(context).colorScheme.secondary,
                      child: Container(
                        height: cardHeight * 0.9,
                        width: cardWidth,
                        // You may want to set a fixed width for the cards
                        padding: const EdgeInsets.all(16.0),
                        child: Text(completedProjects[index]),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Ongoing",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                // This makes the list scroll horizontally
                itemCount: ongoingProjects.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProgressDetailsPage(index: index)),
                      );
                    },
                    child: Card(
                      color: Theme.of(context).colorScheme.secondary,
                      child: Container(
                        height: cardHeight * 1,
                        width: cardWidth,
                        // You may want to set a fixed width for the cards
                        padding: const EdgeInsets.all(16.0),
                        child: Text(ongoingProjects[index]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}




class ProgressDetailsPage extends StatefulWidget {
  final int? index;
  const ProgressDetailsPage({super.key, required this.index});
  @override
  _ProgressDetailspageState createState() => _ProgressDetailspageState();
}

class _ProgressDetailspageState extends State<ProgressDetailsPage> {
  double progressValue = 0.25;


  //

  @override
  Widget build(BuildContext context) {
    final double buttonHeight = MediaQuery.of(context).size.height * 0.06;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 25),
            Container(
              width: 200,
              height: 200,
              child: CircularProgressIndicator(
                value: progressValue,
                strokeWidth: 30,
                backgroundColor: Colors.grey,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 25),
            Text(
              "${(progressValue * 100).toStringAsFixed(1)}%",
              style: TextStyle(fontSize: 24),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Title",
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w200,
                        fontSize: 15,
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("widget.title",
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      )),
                  const SizedBox(height: 20),
                  Text("Descrption ",
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w200,
                        fontSize: 15,
                      )),
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Text("widget.desc",
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          )),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 10),
                  Text("Starting Date",
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w200,
                        fontSize: 15,
                      )),
                  const SizedBox(height: 5),
                  Text("widget.strdate",
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      )),
                  const SizedBox(height: 20),
                  Text("Ending Date",
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w200,
                        fontSize: 15,
                      )),
                  const SizedBox(height: 5),
                  Text("widget.enddate",
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      )),
                  const SizedBox(height: 20),
                  Text("Team Lead Allocation",
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w200,
                        fontSize: 15,
                      )),
                  Text("widget.leadid",
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      )),
                ],
              ),
            ),
            Container(
              height: buttonHeight,
              width: MediaQuery.of(context).size.width *
                  0.8, // Adjust button width
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProjectWorkDone()),
                  );
                },
                child: Text("Check Work",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary)),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: buttonHeight,
              width: MediaQuery.of(context).size.width *
                  0.8, // Adjust button width
              child: ElevatedButton(
                onPressed: () {

                  //Raise Issue page
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const ProjectWorkDone()),
                  // );
                },
                child: Text("Raise Issue",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary)),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: buttonHeight,
              width: MediaQuery.of(context).size.width *
                  0.8, // Adjust button width
              child: ElevatedButton(
                onPressed: () {

                  //Accept onTap


                  
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const ProjectWorkDone()),
                  // );
                },
                child: Text("Accept",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ProjectWorkDone extends StatelessWidget {
  const ProjectWorkDone({super.key});

  @override
  Widget build(BuildContext context) {
    final String url = "https://www.example.com";
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Completed Work'),
      ),
      body: Center(
          child: Column(
        children: [
          Text(
            "Work Done",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Container(
              child: Text(
            " Git Link/Link fro Demo /up work",
            style: TextStyle(fontSize: 20),
          )),
          const SizedBox(height: 20),
          GestureDetector(
              onTap: () async {
                final Uri uri = Uri.parse(url);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(
                    uri,
                    mode: LaunchMode
                        .externalApplication, // Ensures it opens in a browser
                  );
                } else {
                  throw "Could not launch $url";
                }
              },
              child: Text("Link",
                  style: TextStyle(fontSize: 20, color: Colors.blue)))
        ],
      )),
    );
  }
}






