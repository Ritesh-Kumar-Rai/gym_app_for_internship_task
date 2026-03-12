import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class HistoryScreen extends StatefulWidget {
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final db = DatabaseHelper();

  List workouts = [];
  List diets = [];

  loadData() async {
    workouts = await db.getWorkouts();
    diets = await db.getDiet();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,

      child: Scaffold(
        appBar: AppBar(
          title: Text("History"),
          bottom: TabBar(
            tabs: [
              Tab(text: "Workouts"),
              Tab(text: "Diet"),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            /// WORKOUT HISTORY
            (workouts.isNotEmpty)
                ? ListView.builder(
                    itemCount: workouts.length,
                    itemBuilder: (context, index) {
                      var w = workouts[index];

                      return ListTile(
                        title: Text(w['name']),
                        subtitle: Text(
                          "Calories: ${w['calories']} | Duration: ${w['duration']}",
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "No history found for workouts!",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

            /// DIET HISTORY
            (diets.isNotEmpty)
                ? ListView.builder(
                    itemCount: diets.length,
                    itemBuilder: (context, index) {
                      var d = diets[index];

                      return ListTile(
                        title: Text(d['mealName']),
                        subtitle: Text(
                          "Calories: ${d['calories']} | Protein: ${d['protein']}",
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "No history found for diets!",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
