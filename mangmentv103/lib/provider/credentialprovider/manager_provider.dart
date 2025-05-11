import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ManagerProvider extends ChangeNotifier {
  List managerProjectList = [];
  List<String> teamLeadList = [];

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  void getProjectList() async {
    managerProjectList = [];
    QuerySnapshot response =
        await firebaseFirestore.collection("Projects").get();
    for (var doc in response.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data["project_id"] = doc.id;
      managerProjectList.add(data);
    }
    notifyListeners();
  }

    void getTeamLeadList() async {
      teamLeadList = [];
      QuerySnapshot response =
          await firebaseFirestore.collection("Team_Lead").get();
      for (var doc in response.docs) {
        teamLeadList.add(doc.id);
      }

      notifyListeners();
      
    }
  }

