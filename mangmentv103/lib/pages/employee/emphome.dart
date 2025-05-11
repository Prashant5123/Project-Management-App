import 'package:flutter/material.dart';

class EmpFirstPage extends StatefulWidget {
  const EmpFirstPage({super.key});

  @override
  State<EmpFirstPage> createState() => _EmpFirstPageState();
}

class _EmpFirstPageState extends State<EmpFirstPage> {
  bool taskistrue = false;
  Padding sendlisttile(int index) {
    if (taskistrue == true) {
      return Padding(
        padding: EdgeInsets.all(6.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return descoftask(istasktrue: true);
            }));
          },
          child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all()),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("TASKED ASSIGNED ")],
                  ),
                  Container(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text("TASK TITLE")],
                  ),
                  Container(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text("PROJECT:PROEJCT NAME")],
                  )
                ],
              )),
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.all(6.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return descoftask(istasktrue: false);
          }));
        },
        child: Container(
            padding: EdgeInsets.all(9.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), border: Border.all()),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Raised Issue ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Container(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Text("ISSUE TITLE")],
                ),
                Container(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Text("PROJECT:PROEJCT NAME")],
                )
              ],
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          Text('ASSIGNED ',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primaryContainer)),
          const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        taskistrue = false;
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 170,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20.0)),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            width: 2,
                            color: Color.fromARGB(255, 0, 0, 0),
                          )),
                      child: Center(
                          child: Text(
                        'RAISED ISSUE',
                        style: TextStyle(color: Colors.red),
                      )),
                    )),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          taskistrue = true;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 170,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              width: 2,
                              color: Color.fromARGB(255, 0, 0, 0),
                            )),
                        child: Center(child: Text('Task Assign')),
                      )))
            ],
          ),

          const Text('LIST '), // To separate the two lists
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Number of items
              itemBuilder: (context, index) {
                return sendlisttile(index);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class descoftask extends StatefulWidget {
  final bool istasktrue;
  const descoftask({super.key, required this.istasktrue});

  @override
  State<descoftask> createState() => _descoftaskState();
}

class _descoftaskState extends State<descoftask> {
  String uregtmornot = " find by fetching  ";
  Text sendtitle(bool istruetask) {
    if (istruetask == true) {
      return Text('Task Assigned');
    }
    uregtmornot = "TOMORROW";
    return Text('Raised Issue ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: sendtitle(widget.istasktrue),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                Text("   TITLE : {                    }"),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text("  Team Lead Name : {                    }"),
            SizedBox(
              height: 20,
            ),
            Text("   DESCRIPTION  "),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8.0)),
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                      child: Text(
                          "iasudbfiabwefibiweaofueiboisdbifbaoishdbfiubasiodbfiobaibdifbiusbiudofboiuabsoidu"))),
            ),
            SizedBox(height: 20),
            Text("    DUE: $uregtmornot "),
          ],
        ));
  }
}
