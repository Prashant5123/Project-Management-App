import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:mangmentv103/pages/manager/manprojectinfo.dart';
//import 'package:mangmentv103/provider/manprovider/manProvider.dart';
import 'package:intl/intl.dart';
import 'package:mangmentv103/provider/credentialprovider/loginprovider.dart';
import 'package:mangmentv103/provider/credentialprovider/manager_provider.dart';
import 'package:provider/provider.dart';
//import 'package:provider/provider.dart';

class Manfirstpage extends StatefulWidget {
  const Manfirstpage({super.key});
  @override
  State createState() => _FirstPageState();
}

class _FirstPageState extends State<Manfirstpage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> submit(bool doEdit,String selectedTeamLead, [int? index]) async {
    //toDoMOdelobbj is null

    if (titleController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty &&
        startDateController.text.trim().isNotEmpty &&
        endDateController.text.trim().isNotEmpty &&
        selectedTeamLead!=null) {
      Map<String, dynamic> data = {
        "title": titleController.text.trim(),
        "description": descriptionController.text.trim(),
        "enddate": endDateController.text.trim(),
        "strdate": startDateController.text.trim(),
        "tlid":selectedTeamLead
      };
      try{
      if (!doEdit) {
        await firebaseFirestore.collection("Projects").add(data);
        await firebaseFirestore
            .collection("Team_Lead")
            .doc(selectedTeamLead)
            .collection("Projects")
            .add(data);

        Provider.of<ManagerProvider>(context, listen: false).getProjectList();
      } else {
        await firebaseFirestore
            .collection("Projects")
            .doc(projectList[index!]["project_id"])
            .update(data);
        Provider.of<ManagerProvider>(context, listen: false).getProjectList();
      }

      }catch (e){
        log("$e");
      }
    }
    clearController();
  }

  void clearController() {
    titleController.clear();
    descriptionController.clear();
    startDateController.clear();
    endDateController.clear();
  }

  bool editcreate = false;
  String sheettitle() {
    if (editcreate == false) {
      return "Create Project";
    } else {
      editcreate = false;
      return "Edit Project";
    }
  }

  List projectList = [];

  void editCard(int index) {
    titleController.text = projectList[index]["title"];
    descriptionController.text = projectList[index]["description"];
    startDateController.text = projectList[index]["strdate"];
    endDateController.text = projectList[index]["enddate"];
  
    editcreate = true;
    showBottomSheet(true, index);
  }

  Future<void> deleteCard(int index) async {
    await firebaseFirestore
        .collection("Projects")
        .doc(projectList[index!]["project_id"])
        .delete();
    Provider.of<ManagerProvider>(context, listen: false).getProjectList();
  }

  void showBottomSheet(bool doEdit, [int? index]) {
    List<String> teamLeadList =
        Provider.of<ManagerProvider>(context, listen: false).teamLeadList;
    String? selectedTeamLead;
    showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.surface,
      //isScrollControlled: true, //modal sheet bottom must go up when typng
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            //padding: MediaQuery.of(context).viewInsets,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,

                ///when the sheet goes up it shows minmum
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    //"Create Task",
                    sheettitle(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Title",
                        style: GoogleFonts.quicksand(
                          //use google fonts
                          //style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                      const Text(
                        "Description",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: descriptionController,
                          maxLines: null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Description",
                            hintStyle: TextStyle(color: Colors.black54),
                          ),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Text(
                        "Start Date",
                        style: GoogleFonts.quicksand(
                          //use google fonts
                          //style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: startDateController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          suffixIcon: Icon(Icons.calendar_month_outlined),
                        ),
                        readOnly: true,
                        onTap: () async {
                          //pick the date from datepicker
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(3000),
                            //Formates the date into the Required
                            //Format of date i.e Year month Date
                          );
                          String formatedDate = DateFormat.yMMMd().format(
                            pickedDate!,
                          );
                          setState(() {
                            startDateController.text = formatedDate;
                          });
                        },
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "End Date",
                        style: GoogleFonts.quicksand(
                          //use google fonts
                          //style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: endDateController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          suffixIcon: Icon(Icons.calendar_month_outlined),
                        ),
                        readOnly: true,
                        onTap: () async {
                          //pick the date from datepicker
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(3000),
                            //Formates the date into the Required
                            //Format of date i.e Year month Date
                          );
                          String formatedDate = DateFormat.yMMMd().format(
                            pickedDate!,
                          );
                          setState(() {
                            endDateController.text = formatedDate;
                          });
                        },
                      ),
                      Text(
                        "Team Lead",
                        style: GoogleFonts.quicksand(
                          //use google fonts
                          //style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 5),
                      DropdownButtonFormField(
                          value: selectedTeamLead,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          hint: Text("Select Team Lead"),
                          items: teamLeadList.map(
                            (String item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            },
                          ).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedTeamLead = value;
                            });
                          }),
                    ],
                  ),
                  Container(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (!doEdit) {
                        //!doEdit it is defalu false it will become true and send bu submit function
                        //to add task only doedit will be Send
                        submit(doEdit,selectedTeamLead!);
                      } else {
                        //For editng task obj and doEdit will be send
                        submit(doEdit,selectedTeamLead!, index);
                      }

                      Navigator.of(context).pop();
                    },
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Color.fromRGBO(120, 120, 120, 1),
                      ),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  double calculateProgress(String startDate, String endDate) {
    // Ensure the date format matches the format in the input strings
    DateFormat dateFormat = DateFormat(
      "MMM dd, yyyy",
    ); // Adjust based on your format
    DateTime start = dateFormat.parse(startDate);
    DateTime end = dateFormat.parse(endDate);
    DateTime now = DateTime.now();

    // Check if the current date is before the start date or after the end date
    if (now.isBefore(start)) return 0.0;
    if (now.isAfter(end)) return 1.0;

    // Calculate the progress as a fraction of the days passed between start and end
    double progress =
        (now.difference(start).inDays / end.difference(start).inDays)
            .clamp(0.0, 1.0);
    return progress;
  }

  List<ToDoModelClass> cardList = [];

  @override
  Widget build(BuildContext context) {
    projectList = Provider.of<ManagerProvider>(context,listen: false).managerProjectList;
    double cardHeight = MediaQuery.of(context).size.height * 0.20;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 3.0, top: 3.0),
            child: Row(
              children: [
                const SizedBox(height: 24, width: 20),
                const Text(
                  'Create Projects ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                //add project button
                GestureDetector(
                  onTap: () {
                    showBottomSheet(false);
                    clearController();
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromRGBO(47, 47, 47, 1),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 24, width: 20),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: projectList.length,
              itemBuilder: (BuildContext context, int index) {
                double progress = calculateProgress(
                  projectList[index]['strdate'],
                  projectList[index]["enddate"],
                );
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
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
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          //const Spacer(),
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  projectList[index]["title"],
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
                              top: 0.0,
                              bottom: 4.0,
                              right: 6.0,
                              left: 6.0,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Starting Date :',
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  projectList[index]["strdate"],
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      child: Icon(
                                        Icons.pie_chart_sharp,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.inversePrimary,
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProjectInfo(
                                              index: index,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(width: 12),
                                    GestureDetector(
                                      child: Icon(
                                        Icons.edit,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.inversePrimary,
                                        size: 25,
                                      ),
                                      onTap: () {
                                        editCard(index);
                                      },
                                    ),
                                    const SizedBox(width: 12),
                                    GestureDetector(
                                      child: Icon(
                                        Icons.delete,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.inversePrimary,
                                        size: 25,
                                      ),
                                      onTap: () {
                                        deleteCard(index);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                                  'Ending Date :',
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  projectList[index]["enddate"],
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 0.0,
                              bottom: 0.0,
                              right: 6.0,
                              left: 6.0,
                            ),
                            child: Text(
                              'Time remaing ',
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 20,
                              left: 20,
                              bottom: 6.0,
                              top: 6.0,
                            ),
                            child: LinearProgressIndicator(
                              value: progress,
                              backgroundColor: Colors.grey[300],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).colorScheme.inversePrimary,
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//this make to send all the things compusory if not given it will show error
class ToDoModelClass {
  String title;
  String description;
  String strdate;
  String enddate;
  String tlid;
  ToDoModelClass({
    required this.title,
    required this.description,
    required this.strdate,
    required this.enddate,
    required this.tlid,
  });
}
