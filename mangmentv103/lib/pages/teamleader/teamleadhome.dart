import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangmentv103/pages/teamleader/assignprojectemp.dart';
import 'package:mangmentv103/provider/credentialprovider/teamlead_provider.dart';
import 'package:provider/provider.dart';

class TLFirstPage extends StatefulWidget {
  const TLFirstPage({super.key});

  @override
  State<TLFirstPage> createState() => _TLFirstPageState();
}

class _TLFirstPageState extends State<TLFirstPage> {

  List teamLeadProjectList=[];
  @override
  Widget build(BuildContext context) {
    teamLeadProjectList=Provider.of<TeamleadProvider>(context).teamLeadProjectList;
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
                  'Assigned Projects',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                const SizedBox(height: 24, width: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(47, 47, 47, 1),
                    ),
                    child: Center(
                      child: Icon(Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  )
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: teamLeadProjectList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Card(
                    elevation: 4.0, // Adds shadow for elevated effect
                    color:
                        Theme.of(context)
                            .colorScheme
                            .secondary, // Background color for the card
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      height: 150,
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          //const Spacer(),
                          Row(
                            children: [
                              Flexible(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        teamLeadProjectList[index]["title"],
                                        style: GoogleFonts.quicksand(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                        maxLines: 1, // Limit to one line
                                        overflow:
                                            TextOverflow
                                                .ellipsis, // Show ellipsis for overflow
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          child: Icon(
                                            Icons.pie_chart_sharp,
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.inversePrimary,
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (context) =>
                                                        assignprojecttoemp(),
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(width: 12),
                                        GestureDetector(
                                          child: Icon(
                                            Icons.edit,
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.inversePrimary,
                                            size: 25,
                                          ),
                                          onTap: () {},
                                        ),
                                        const SizedBox(width: 12),
                                        GestureDetector(
                                          child: Icon(
                                            Icons.delete,
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.inversePrimary,
                                            size: 25,
                                          ),
                                          onTap: () {},
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          //
                          Padding(
                            padding: EdgeInsets.all(8.0),
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
                                  teamLeadProjectList[index]["strdate"],

                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
          
                          //
                          Padding(
                            padding: EdgeInsets.all(8.0),
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
                                  teamLeadProjectList[index]["enddate"],
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
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
