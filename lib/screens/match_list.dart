import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/models/match_model.dart';

import 'package:flutter/material.dart';

class LiveScoreScreen extends StatefulWidget {
  const LiveScoreScreen({super.key});

  @override
  State<LiveScoreScreen> createState() => _LiveScoreScreenState();
}

class _LiveScoreScreenState extends State<LiveScoreScreen> {
  List<MachModel> matchList = [];

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> _getData() async {
    matchList.clear();
    final QuerySnapshot match = await firebaseFirestore
        .collection("football")
        .get(); // Await the async operation
    for (QueryDocumentSnapshot doc in match.docs) {
      matchList.add(MachModel(
        teamAname: doc.get('team1Name'),
        teamBname: doc.get('team2Name'),
        teamAScore: doc.get('team1goal'),
        teamBScore: doc.get('team1goal'),
      ));
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Live Scord"),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: firebaseFirestore.collection('football').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Text('No data found');
            }
            matchList.clear();
            for (QueryDocumentSnapshot doc in snapshot.data?.docs ?? []) {
              matchList.add(MachModel(
                teamAname: doc.get('team1Name'),
                teamBname: doc.get('team2Name'),
                teamAScore: doc.get('team1goal'),
                teamBScore: doc.get('team1goal'),
              ));
            }
            return ListView.builder(
                itemCount: matchList.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(matchList[index].teamAname.toString()),
                              Text(matchList[index].teamAScore.toString())
                            ],
                          ),
                          const Text("Vs"),
                          Column(
                            children: [
                              Text(matchList[index].teamBname.toString()),
                              Text(matchList[index].teamBScore.toString())
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
