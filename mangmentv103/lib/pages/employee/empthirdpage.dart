import 'package:flutter/material.dart';
import 'package:mangmentv103/components/my_button.dart';

class Empthirdpage extends StatefulWidget {
  const Empthirdpage({super.key});

  @override
  State<Empthirdpage> createState() => _EmpthirdpageState();
}

class _EmpthirdpageState extends State<Empthirdpage> {
  bool completed = false;

  Padding sendlisttile(int index, bool taskistrue) {
    String task = "Task Assigned";
    if (taskistrue == true) {
      task = "TASK ASSIGNED";
    } else if (taskistrue == false) {
      task = "RAISED ISSUE";
    }
    if (completed == true) {
      return Padding(
        padding: EdgeInsets.all(6.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return submitedtaskempcomp(task: task);
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
                    Text(
                      "Completed Task  ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5),
                    Text(task, style: TextStyle(fontWeight: FontWeight.bold)),
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
    return Padding(
      padding: EdgeInsets.all(6.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return submittaskempincompleted(task: task);
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
                  Text(
                    "PENDING TASK ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5),
                  Text(task, style: TextStyle(fontWeight: FontWeight.bold)),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        completed = false;
                      });
                    },
                    child: Container(
                      height: 50,
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
                          'PENDING',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        completed = true;
                      });
                    },
                    child: Container(
                      height: 50,
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
                      child: Center(child: Text('COMPLETED')),
                    ),
                  ),
                ),
              ],
            ),
            const Text('LIST '), // To separate the two lists
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Number of items
                itemBuilder: (context, index) {
                  bool taskistrue = false; //this will come on run time
                  //here you can write a logic for the rsortting thema all for all list view builder
                  return sendlisttile(index, taskistrue);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
//
////
////
////
////
///
class submitedtaskempcomp extends StatefulWidget {
  final String task;
  submitedtaskempcomp({super.key, required this.task});

  @override
  State<submitedtaskempcomp> createState() => _submitedtaskempcompState();
}

class _submitedtaskempcompState extends State<submitedtaskempcomp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("COMPLETED TASK ")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(widget.task),
          SizedBox(height: 20),
          Row(
            children: [
              Text("   TITLE : {                    }"),
              SizedBox(height: 20),
            ],
          ),
          SizedBox(height: 20),
          Text("  Team Lead Name : {                    }"),
          SizedBox(height: 20),
          Text("   DESCRIPTION  "),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(8.0),
              ),
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Text(
                  "iasudbfiabwefibiweaofueiboisdbifbaoishdbfiubasiodbfiobaibdifbiusbiudofboiuabsoidu",
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text("    SUBMITED WORK "),
          SizedBox(height: 20),
          Center(
            /// make it go to the browser
            child: GestureDetector(child: Container(child: Text("LINK "))),
          ),
        ],
      ),
    );
  }
}

////
/////
////
////
////
////
////
class submittaskempincompleted extends StatefulWidget {
  final String task;
  submittaskempincompleted({super.key, required this.task});

  @override
  State<submittaskempincompleted> createState() =>
      _submittaskempincompletedState();
}

class _submittaskempincompletedState extends State<submittaskempincompleted> {
  TextEditingController _linkcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Incomplete task ")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text("   " + widget.task),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(height: 20),
              Text("   TITLE : {                    }"),
              SizedBox(height: 20),
            ],
          ),
          SizedBox(height: 20),
          Text("    Team Lead Name : {                    }"),
          SizedBox(height: 20),
          Text("   DESCRIPTION  "),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(8.0),
              ),
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Text(
                  "iasudbfiabwefibiweaofueiboisdbifbaoishdbfiubasiodbfiobaibdifbiusbiudofboiuabsoidu",
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text("    SUBMITED WORK "),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(color: Colors.blue),
                keyboardType: TextInputType.text,
                controller: _linkcontroller,
                obscureText: false,
                decoration: InputDecoration(
                  // const Color.fromARGB(255, 59, 57, 57),
                  hintText: "LINK",
                  fillColor: Colors.blue,
                ),
              ),
            ),
          ),
          SizedBox(height: 40),
          Center(
            child: MyButton(
              buttoncolor: Theme.of(context).colorScheme.primary,
              text: "Submit work",
              onTap: () {
                //change the lsit of the incomokkpet and cmpleted
              },
            ),
          ),
        ],
      ),
    );
  }
}
