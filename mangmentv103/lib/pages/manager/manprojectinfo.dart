// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mangmentv103/provider/credentialprovider/manager_provider.dart';
//import 'package:mangmentv103/provider/manprovider/manProvider.dart';
//import 'package:mangmentv103/provider/manprovider/manProvider.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class ProjectInfo extends StatefulWidget {
  int index;
  ProjectInfo({required this.index});
  @override
  State<ProjectInfo> createState() => _ProjectInfoState();
}

class _ProjectInfoState extends State<ProjectInfo> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startDateController =
      TextEditingController(); // New controller for starting date
  TextEditingController endDateController =
      TextEditingController(); // New controller for ending date
  final TextEditingController description = TextEditingController();
  TextEditingController selectTL = TextEditingController();

  @override
  Widget build(BuildContext context) {
     List projectList= Provider.of<ManagerProvider>(context).managerProjectList;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("Project Information"),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Title",
              style: GoogleFonts.quicksand(
                fontWeight: FontWeight.bold,
                fontSize: 18,
            
              ),
            ),
            const SizedBox(height: 5),
            Text(
              projectList[widget.index]["title"],
              style: GoogleFonts.quicksand(
               
                fontSize: 16,
                
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Descrption ",
              style: GoogleFonts.quicksand(
               fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Container(
              
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Text(
                 projectList[widget.index]["description"],
                  style: GoogleFonts.quicksand(
                
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 10),
            Text(
              "Starting Date",
              style: GoogleFonts.quicksand(
              fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              projectList[widget.index]["strdate"],
              style: GoogleFonts.quicksand(
              
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Ending Date",
              style: GoogleFonts.quicksand(
               fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              projectList[widget.index]["enddate"],
              style: GoogleFonts.quicksand(
                
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Team Lead Allocation",
              style: GoogleFonts.quicksand(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              projectList[widget.index]["tlid"],
              style: GoogleFonts.quicksand(
               
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
