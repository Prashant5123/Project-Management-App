import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/single_child_widget.dart';

class assignprojecttoemp extends StatefulWidget {
  const assignprojecttoemp({super.key});

  @override
  State<assignprojecttoemp> createState() => _assignprojecttoempState();
}

class _assignprojecttoempState extends State<assignprojecttoemp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Project Info andd Assinging the employee'),
        ),
        body: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              height: 65,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).secondaryHeaderColor, width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return assingepm();
                    }));
                  },
                  child: Text(
                    'Assign the Employee to the project',
                    style: TextStyle(fontSize: 15),
                  ))),
          SizedBox(height: 20),
          Divider(),
          SizedBox(height: 20),
          Container(
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "TITLE:-",
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    'Title',
                    style: TextStyle(fontSize: 15),
                  )
                ]),
          ),
          SizedBox(height: 20),
          Text("DESCRIPTION", style: TextStyle(fontSize: 15)),
          SizedBox(height: 15),
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).secondaryHeaderColor, width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Text('Descrtion ', style: TextStyle(fontSize: 15)),
            ),
          ),
          SizedBox(height: 20),
          const Text("Link",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
              )),
          TextField(
            // controller:
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
          ),
          SizedBox(height: 20),
          Container(
              height: 65,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).secondaryHeaderColor, width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Final Submition Of Proejct',
                    style: TextStyle(fontSize: 15),
                  ))),
        ])));
  }
}

class assingepm extends StatefulWidget {
  const assingepm({super.key});

  @override
  State<assingepm> createState() => _assingepmState();
}

class _assingepmState extends State<assingepm> {
  List<TextEditingController> employeeControllers = [];
  List<TextEditingController> descriptionControllers = [];

  void _addFields() {
    setState(() {
      employeeControllers.add(TextEditingController());
      descriptionControllers.add(TextEditingController());
    });
  }

  void _submitData() {
    for (int i = 0; i < employeeControllers.length; i++) {
      print("Employee ${i + 1}: ${employeeControllers[i].text}");
      print("Description ${i + 1}: ${descriptionControllers[i].text}");
    }
    // You can now send this data to a backend or use it as needed.
  }

  void _updateData() {
    setState(() {
      for (int i = 0; i < employeeControllers.length; i++) {
        if (employeeControllers[i].text.isNotEmpty) {
          employeeControllers[i].text += ' - updated';
        }
        if (descriptionControllers[i].text.isNotEmpty) {
          descriptionControllers[i].text += ' - updated';
        }
      }
    });
  }

  void _deleteLastField() {
    if (employeeControllers.isNotEmpty && descriptionControllers.isNotEmpty) {
      setState(() {
        employeeControllers.last.dispose();
        descriptionControllers.last.dispose();
        employeeControllers.removeLast();
        descriptionControllers.removeLast();
      });
    }
  }

  @override
  void dispose() {
    for (var controller in employeeControllers) {
      controller.dispose();
    }
    for (var controller in descriptionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Employees')),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(employeeControllers.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: employeeControllers[index],
                          decoration: InputDecoration(
                            labelText: 'Employee Name ${index + 1}',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: descriptionControllers[index],
                          decoration: InputDecoration(
                            labelText: 'Description ${index + 1}',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: _addFields,
                  child: Text('Add'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    _updateData();
                  },
                  child: Text('Update'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    _submitData();
                    Navigator.pop(context);
                  },
                  child: Text('Submit'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _deleteLastField,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text('Delete'),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
