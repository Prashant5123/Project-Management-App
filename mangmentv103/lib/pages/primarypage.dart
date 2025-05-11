import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';

import 'package:mangmentv103/components/my_drawer.dart';
import 'package:mangmentv103/pages/chatapp/home_page_chat.dart';
import 'package:mangmentv103/pages/employee/empnotification.dart';
import 'package:mangmentv103/pages/employee/emphome.dart';
import 'package:mangmentv103/pages/common/secondpage.dart';
import 'package:mangmentv103/pages/employee/empthirdpage.dart';
import 'package:mangmentv103/pages/common/fourthpage.dart';
import 'package:mangmentv103/pages/manager/manfirstpage.dart';
import 'package:mangmentv103/pages/manager/mannotification.dart';
import 'package:mangmentv103/pages/manager/manthirdpage.dart';
import 'package:mangmentv103/pages/teamleader/teamleadhome.dart';
import 'package:mangmentv103/pages/teamleader/teamleadnotification.dart';
import 'package:mangmentv103/pages/teamleader/teamleadthirdpage.dart';
import 'package:mangmentv103/provider/credentialprovider/loginprovider.dart';
import 'package:mangmentv103/provider/credentialprovider/manager_provider.dart';
import 'package:mangmentv103/provider/credentialprovider/teamlead_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageempState();
}

class _HomePageempState extends State<HomePage> {
  //int levelno = 3;
  bool tapped = false;
  Icon noticon = const Icon(Icons.notifications_outlined);

  TabBarView changethetabpage() {
    LoginProvider loginProvider = Provider.of<LoginProvider>(context);
    if (loginProvider.userdata!.designation == 3) {
      return TabBarView(
        children: [
          EmpFirstPage(),
          SecondPage(),
          Empthirdpage(),
          Empnotification(),
          FourthPage(),
        ],
      );
    } else if (loginProvider.userdata!.designation == 2) {
      return TabBarView(
        children: [
          TLFirstPage(),
          SecondPage(),
          TLThirdPage(),
          TLnotification(),
          FourthPage(),
        ],
      );
    } else {
      return TabBarView(
        children: [
          Manfirstpage(),
          SecondPage(),
          Manthirdpage(),
          Mannotification(),
          FourthPage(),
        ],
      );
    }
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    if(Provider.of<LoginProvider>(context).userdata!.userType=="Manager"){
     Provider.of<ManagerProvider>(context,listen: false).getTeamLeadList();
    Provider.of<ManagerProvider>(context,listen: false).getProjectList();

    }else if(Provider.of<LoginProvider>(context).userdata!.userType=="Team_Lead"){
       Provider.of<TeamleadProvider>(context,listen: false).getTeamLeadProject(Provider.of<LoginProvider>(context).userdata!.userType, Provider.of<LoginProvider>(context).userdata!.email);
    }
  }

  @override
  Widget build(BuildContext context) {
    String? name = Provider.of<LoginProvider>(context).userdata?.name;
    String useranme = " ${Provider.of<LoginProvider>(context).userdata?.name}";
    String avatarUrl = "https://robohash.org/$useranme";

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        appBar: AppBar(
          actions: [
            SizedBox(width: 20),
            Padding(
              padding: EdgeInsets.all(7.0),
              child: GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey[200],
                  child: ClipOval(
                    child: Image.network(
                      avatarUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.person, size: 40); // default icon
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
          title: Text(
            'Welcome  $name ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          bottom: TabBar(
            unselectedLabelColor: Theme.of(context).colorScheme.inversePrimary,
            labelColor: Theme.of(context).colorScheme.tertiary,
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.business)),
              Tab(icon: Icon(Icons.school)),
              Tab(icon: Icon(Icons.notifications)),
              Tab(icon: Icon(Icons.person)),
            ],
          ),
        ),
        body: changethetabpage(),
        drawer: MyDrawer(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromRGBO(47, 47, 47, 1),
          child: Icon(Icons.message_outlined),
          onPressed: () async {
            // () => Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => HomePagechat()),
          },
        ),
      ),
    );
  }
}
