import 'package:flutter/material.dart';
import 'package:mangmentv103/components/my_button.dart';

class submittaskempincompleted extends StatefulWidget {
  final String task;
  final int listnumber;
  const submittaskempincompleted({
    super.key,
    required this.task,
    required this.listnumber,
  });

  @override
  State<submittaskempincompleted> createState() =>
      _submittaskempincompletedState();
}

class _submittaskempincompletedState extends State<submittaskempincompleted> {
  String title = '';

  Text retruntitle(int listnumer) {
    if (listnumer == 0) {
      title = "Incomplete Task ";
      return Text(title);
    } else if (listnumer == 1) {
      title = "Assigned Task";
      return Text(title);
    } else {
      title = "Completed Task";
      return Text(title);
    }
  }

  Widget sendButton(int listnumer) {
    if (listnumer == 0 || listnumer == 1) {
      return MyButton(
        buttoncolor: Theme.of(context).colorScheme.primary,
        text: "Accept Work",
        onTap: () {
          //  isAccepted=true;
          //change the lsit of the incomokkpet and cmpleted
        },
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    int listnum = widget.listnumber;
    return Scaffold(
      appBar: AppBar(title: retruntitle(listnum)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(widget.task),
              SizedBox(height: 20),
              Text("TITLE : {                    }"),
              SizedBox(height: 20),
              Text("Project   TITLE : {                    }"),
              SizedBox(height: 20),
              SizedBox(height: 20),
              Text("Employee Name : {                    }"),
              SizedBox(height: 20),
              Text("DESCRIPTION  "),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(0.0),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(child: Text("Descrption ")),
                ),
              ),
              SizedBox(height: 20),
              Text("    SUBMITED WORK "),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Link"),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Center(child: sendButton(widget.listnumber)),
            ],
          ),
        ),
      ),
    );
  }
}
