import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TeamleadProvider extends ChangeNotifier{
  List teamLeadProjectList=[];
  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
  
  void getTeamLeadProject(String userType,String userID)async{
    QuerySnapshot response=await firebaseFirestore.collection(userType).doc(userID).collection("Projects").get();

    for(var doc in response.docs){
      teamLeadProjectList=[];
      Map data=doc.data() as Map;
      teamLeadProjectList.add(data);
    }

    log("$teamLeadProjectList");
    notifyListeners();

  }
}

