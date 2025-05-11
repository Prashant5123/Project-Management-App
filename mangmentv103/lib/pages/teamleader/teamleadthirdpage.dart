import 'package:flutter/material.dart';

import 'package:mangmentv103/pages/teamleader/classes.dart';

class TLThirdPage extends StatefulWidget {
  const TLThirdPage({super.key});

  @override
  State<TLThirdPage> createState() => _TLThirdPageState();
}

class _TLThirdPageState extends State<TLThirdPage> {
  int listnumber = 0;
  String listdesc = "";

  Padding sendlisttile(int index, int listnumber, String listdesc) {
    String tasktype = "";
    String title = "";

    if (listnumber == 0) {
      tasktype = "Raised Issue for Employee";
      title = "Ticket raised";
      listdesc = "Issues that are pending to complete";
    } else if (listnumber == 1) {
      tasktype =
          "Employee Submition"; // Task assigned by  team lead to employeee
      title = "Task Assigned";
      listdesc = "Task Assigned by TL and click to check submition";
    } else {
      tasktype = 'Accepeted Task for merge'; //task accepeted by Team lead
      title = "Accepted task ";
      listdesc = "Task Done and approved by TL";
    }

    return Padding(
      padding: EdgeInsets.all(6.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return submittaskempincompleted(
                  task: tasktype,
                  listnumber: listnumber,
                );
              },
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(9.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("$title", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 5),
                  Text(tasktype, style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              Container(height: 10),
              Text("ISSUE TITLE"),
              Container(height: 10),
              Text("PROJECT:PROEJCT NAME"),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //
                  //
                  //
                  //
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 5,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          listnumber = 0;
                        });
                      },
                      child: Container(
                        height: 70,
                        width: 170,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            width: 2,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Ticket ',
                            style: TextStyle(color: Colors.red, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //
                  //
                  //
                  //
                  //
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          listnumber = 1;
                        });
                      },
                      child: Container(
                        height: 70,
                        width: 170,
                        padding: EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            width: 2,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Assigned Task',
                            style: TextStyle(fontSize: 15, color: Colors.blue),
                          ),
                        ), // submited by employyes
                      ),
                    ),
                  ),

                  //
                  //
                  //
                  //
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 5,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          listnumber = 2;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(4.0),
                        height: 70,
                        width: 170,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            width: 2,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Acccpted Task',
                            style: TextStyle(fontSize: 15, color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text('LIST :- $listdesc'), // To separate the two lists
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Number of items
                itemBuilder: (context, index) {
                  //this will come on run time
                  //here you can write a logic for the rsortting thema all for all list view builder
                  return sendlisttile(index, listnumber, listdesc);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
